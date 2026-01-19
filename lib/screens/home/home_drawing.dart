part of '../home_page.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key, required this.username});

  final String username;

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final GlobalKey _canvasKey = GlobalKey();
  final List<_Stroke> _strokes = [];
  final List<_TextItem> _texts = [];
  final List<_FillLayer> _fills = [];
  _Stroke? _activeStroke;
  Color _strokeColor = Colors.black87;
  double _strokeWidth = 3;
  bool _isEraser = false;
  bool _isTextTool = false;
  bool _isBucketTool = false;
  double _textSize = 20;
  String _textFontFamily = 'Sans';
  int? _activeTextIndex;
  Offset? _textDragStart;
  Offset? _textOrigin;
  Color _pendingColor = Colors.black;
  bool _colorConfirmed = true;
  ui.Image? _fillLayer;
  bool _isFilling = false;
  final List<Color> _palette = const [
    Color(0xFF000000),
    Color(0xFFFFFFFF),
    Color(0xFFFF0000),
    Color(0xFF00FF00),
    Color(0xFF0000FF),
    Color(0xFFFFFF00),
    Color(0xFF00FFFF),
    Color(0xFFFF00FF),
  ];

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
      _texts.clear();
      for (final fill in _fills) {
        fill.image.dispose();
      }
      _fills.clear();
      _fillLayer = null;
    });
  }

  void _undoLastStroke() {
    if (_strokes.isEmpty && _texts.isEmpty && _fills.isEmpty) return;
    setState(() {
      final lastTextTime = _texts.isNotEmpty ? _texts.last.timestamp : null;
      final lastStrokeTime =
          _strokes.isNotEmpty ? _strokes.last.timestamp : null;
      final lastFillTime = _fills.isNotEmpty ? _fills.last.timestamp : null;
      final isTextLatest = lastTextTime != null &&
          (lastStrokeTime == null || lastTextTime.isAfter(lastStrokeTime)) &&
          (lastFillTime == null || lastTextTime.isAfter(lastFillTime));
      final isFillLatest = lastFillTime != null &&
          (lastStrokeTime == null || lastFillTime.isAfter(lastStrokeTime)) &&
          (lastTextTime == null || lastFillTime.isAfter(lastTextTime));

      if (isTextLatest) {
        _texts.removeLast();
      } else if (isFillLatest) {
        final removed = _fills.removeLast();
        removed.image.dispose();
        _fillLayer = _fills.isNotEmpty ? _fills.last.image : null;
      } else {
        _strokes.removeLast();
      }
    });
  }

  void _setStrokeColor(Color color) {
    setState(() {
      _strokeColor = color;
    });
  }

  void _setStrokeWidth(double value) {
    setState(() {
      _strokeWidth = value;
    });
  }

  void _setTool(bool isEraser) {
    setState(() {
      _isEraser = isEraser;
      _isTextTool = false;
      _isBucketTool = false;
    });
  }

  void _setTextTool() {
    setState(() {
      _isTextTool = true;
      _isEraser = false;
      _isBucketTool = false;
      _activeTextIndex = null;
    });
  }

  String? _resolvedFontFamily(String family) {
    if (family == 'Serif') return 'serif';
    if (family == 'Mono') return 'monospace';
    return null;
  }

  Color _sanitizeColor(Color color) {
    return color.withValues(alpha: 1.0);
  }

  Future<String?> saveToFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'Please log in again.';
    }
    final boundary =
        _canvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      return 'Unable to capture drawing.';
    }

    final image = await boundary.toImage(
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      return 'Unable to export drawing.';
    }

    final pngBytes = byteData.buffer.asUint8List();
    final fileName = _timestampFileName();
    final storagePath = 'users/${user.uid}/drawings/$fileName';
    final ref = FirebaseStorage.instance.ref().child(storagePath);

    try {
      await ref.putData(pngBytes, SettableMetadata(contentType: 'image/png'));
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/drawings/${_timestampKey(fileName)}')
          .set({
            'fileName': fileName,
            'storagePath': storagePath,
            'createdAt': DateTime.now().toIso8601String(),
          });
      return 'Drawing saved.';
    } on FirebaseException catch (error) {
      final message = error.message ?? 'Unknown error';
      debugPrint('Failed to save drawing: ${error.code} $message');
      return 'Failed to save: ${error.code}';
    } catch (error) {
      debugPrint('Failed to save drawing: $error');
      return 'Failed to save drawing.';
    }
  }

  String _timestampFileName() {
    final now = DateTime.now();
    final yyyy = now.year.toString();
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    final hh = now.hour.toString().padLeft(2, '0');
    final min = now.minute.toString().padLeft(2, '0');
    final ss = now.second.toString().padLeft(2, '0');
    final safeUsername = _safeUsername(widget.username);
    return '${safeUsername}_$yyyy$mm${dd}_$hh$min$ss.png';
  }

  String _timestampKey(String fileName) {
    return fileName.replaceAll('.', '_');
  }

  String _safeUsername(String username) {
    final trimmed = username.trim();
    if (trimmed.isEmpty) return 'anonymous';
    final buffer = StringBuffer();
    for (final codeUnit in trimmed.codeUnits) {
      final ch = String.fromCharCode(codeUnit);
      final isLetterOrDigit =
          (codeUnit >= 48 && codeUnit <= 57) ||
          (codeUnit >= 65 && codeUnit <= 90) ||
          (codeUnit >= 97 && codeUnit <= 122);
      buffer.write(isLetterOrDigit ? ch : '_');
    }
    return buffer.toString();
  }

  void _openToolsSheet() {
    _pendingColor = _strokeColor;
    _colorConfirmed = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            void updateTools(VoidCallback update) {
              update();
              setModalState(() {});
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  16 + MediaQuery.of(sheetContext).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Tools',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            if (!_colorConfirmed) {
                              updateTools(() {
                                _strokeColor = Colors.black;
                              });
                            }
                            Navigator.pop(sheetContext);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!_isEraser)
                      Center(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            for (final color in _palette)
                              _ColorChip(
                                color: color,
                                isSelected: _strokeColor == color,
                                onTap: () => updateTools(() {
                                  _strokeColor = color.withValues(alpha: 1.0);
                                  _pendingColor = _strokeColor;
                                  _colorConfirmed = true;
                                }),
                              ),
                          ],
                        ),
                      ),
                    if (!_isEraser) ...[
                      const SizedBox(height: 12),
                      ColorPicker(
                        pickerColor: _pendingColor,
                        onColorChanged: (color) => updateTools(() {
                          _pendingColor = _sanitizeColor(color);
                          _colorConfirmed = false;
                        }),
                        paletteType: PaletteType.hsvWithHue,
                        enableAlpha: false,
                        displayThumbColor: true,
                        labelTypes: const [],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => updateTools(() {
                            _strokeColor = _pendingColor;
                            _colorConfirmed = true;
                            Navigator.pop(sheetContext);
                          }),
                          child: const Text('Use this color'),
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (_isTextTool)
                      Row(
                        children: [
                          const Text('Text size'),
                          Expanded(
                            child: Slider(
                              value: _textSize,
                              min: 12,
                              max: 48,
                              divisions: 12,
                              label: _textSize.toStringAsFixed(0),
                              onChanged: (value) => updateTools(() {
                                _textSize = value;
                              }),
                            ),
                          ),
                        ],
                      )
                    else if (_isBucketTool)
                      const SizedBox.shrink()
                    else
                      Row(
                        children: [
                          Text(_isEraser ? 'Eraser size' : 'Brush size'),
                          Expanded(
                            child: Slider(
                              value: _strokeWidth,
                              min: 2,
                              max: 20,
                              divisions: 18,
                              label: _strokeWidth.toStringAsFixed(0),
                              onChanged: (value) => updateTools(() {
                                _strokeWidth = value;
                              }),
                            ),
                          ),
                        ],
                      ),
                    if (!_isBucketTool) ...[
                      const SizedBox(height: 8),
                      _ToolPreview(
                        isText: _isTextTool,
                        isEraser: _isEraser,
                        color: _strokeColor,
                        strokeWidth: _strokeWidth,
                        textSize: _textSize,
                        fontFamily: _resolvedFontFamily(_textFontFamily),
                      ),
                    ],
                    if (_isTextTool) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Font'),
                          const SizedBox(width: 12),
                          DropdownButton<String>(
                            value: _textFontFamily,
                            onChanged: (value) {
                              if (value == null) return;
                              updateTools(() {
                                _textFontFamily = value;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'Sans',
                                child: Text('Sans', style: TextStyle(fontFamily: null)),
                              ),
                              DropdownMenuItem(
                                value: 'Serif',
                                child: Text('Serif', style: TextStyle(fontFamily: 'serif')),
                              ),
                              DropdownMenuItem(
                                value: 'Mono',
                                child: Text('Mono', style: TextStyle(fontFamily: 'monospace')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _startStroke(Offset position) {
    if (_isTextTool || _isBucketTool || _isFilling) return;
    final stroke = _Stroke(
      points: [position],
      color: _strokeColor,
      width: _strokeWidth,
      isEraser: _isEraser,
      timestamp: DateTime.now(),
    );
    setState(() {
      _strokes.add(stroke);
      _activeStroke = stroke;
    });
  }

  void _appendStrokePoint(Offset position) {
    if (_isTextTool || _isBucketTool || _isFilling) return;
    setState(() {
      _activeStroke?.points.add(position);
    });
  }

  void _endStroke() {
    if (_isTextTool || _isBucketTool || _isFilling) return;
    setState(() {
      _activeStroke?.points.add(null);
      _activeStroke = null;
    });
  }

  Future<void> _fillAt(Offset position) async {
    if (_isFilling) return;
    final renderBox = _canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    setState(() {
      _isFilling = true;
    });

    try {
      final size = renderBox.size;
      final image = await _renderToImage(size);
      final bytes = await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (bytes == null) {
        return;
      }
      final width = image.width;
      final height = image.height;
      final data = bytes.buffer.asUint8List();

      final x = position.dx.clamp(0, width - 1).round();
      final y = position.dy.clamp(0, height - 1).round();

      final startIndex = (y * width + x) * 4;
      final target = _rgbaAt(data, startIndex);
      final fill = _colorToRgba(_strokeColor);
      if (_rgbaEquals(target, fill)) return;

      const tolerance = 16;
      final stack = <int>[x, y];
      while (stack.isNotEmpty) {
        final cy = stack.removeLast();
        final cx = stack.removeLast();
        if (cx < 0 || cy < 0 || cx >= width || cy >= height) continue;
        final idx = (cy * width + cx) * 4;
        final current = _rgbaAt(data, idx);
        if (!_rgbaClose(current, target, tolerance)) continue;
        data[idx] = fill[0];
        data[idx + 1] = fill[1];
        data[idx + 2] = fill[2];
        data[idx + 3] = fill[3];
        stack.add(cx + 1);
        stack.add(cy);
        stack.add(cx - 1);
        stack.add(cy);
        stack.add(cx);
        stack.add(cy + 1);
        stack.add(cx);
        stack.add(cy - 1);
      }

      final filled = await _imageFromPixels(data, width, height);
      setState(() {
        _fills.add(_FillLayer(image: filled, timestamp: DateTime.now()));
        _fillLayer = filled;
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isFilling = false;
      });
    }
  }

  List<int> _rgbaAt(Uint8List data, int index) {
    return [data[index], data[index + 1], data[index + 2], data[index + 3]];
  }

  bool _rgbaEquals(List<int> a, List<int> b) {
    return a[0] == b[0] && a[1] == b[1] && a[2] == b[2] && a[3] == b[3];
  }

  bool _rgbaClose(List<int> a, List<int> b, int tolerance) {
    return (a[0] - b[0]).abs() <= tolerance &&
        (a[1] - b[1]).abs() <= tolerance &&
        (a[2] - b[2]).abs() <= tolerance &&
        (a[3] - b[3]).abs() <= tolerance;
  }

  List<int> _colorToRgba(Color color) {
    return [color.red, color.green, color.blue, color.alpha];
  }

  Future<ui.Image> _imageFromPixels(
    Uint8List pixels,
    int width,
    int height,
  ) {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      pixels,
      width,
      height,
      ui.PixelFormat.rgba8888,
      (image) => completer.complete(image),
    );
    return completer.future;
  }

  Future<ui.Image> _renderToImage(Size size) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.white,
    );
    if (_fillLayer != null) {
      canvas.drawImage(_fillLayer!, Offset.zero, Paint());
    }
    for (final stroke in _strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round
        ..blendMode = stroke.isEraser ? BlendMode.clear : BlendMode.srcOver;
      final points = stroke.points;
      for (var i = 0; i < points.length - 1; i++) {
        final current = points[i];
        final next = points[i + 1];
        if (current != null && next != null) {
          canvas.drawLine(current, next, paint);
        }
      }
    }
    for (final textItem in _texts) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: textItem.text,
          style: TextStyle(
            color: textItem.color,
            fontSize: textItem.size,
            fontFamily: textItem.fontFamily,
          ),
        ),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width - textItem.position.dx);
      textPainter.paint(canvas, textItem.position);
    }
    final picture = recorder.endRecording();
    return picture.toImage(size.width.round(), size.height.round());
  }

  Future<void> _addTextAt(Offset position) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add text'),
          content: TextField(
            controller: controller,
            maxLines: 2,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(hintText: 'Write up to 2 lines'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    final text = result?.trim();
    if (text == null || text.isEmpty) {
      return;
    }

    setState(() {
      _texts.add(
        _TextItem(
          text: text,
          position: position,
          color: _strokeColor,
          size: _textSize,
          fontFamily: _resolvedFontFamily(_textFontFamily),
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  int? _hitTestText(Offset position, Size size) {
    for (var i = _texts.length - 1; i >= 0; i--) {
      final textItem = _texts[i];
      final textPainter = TextPainter(
        text: TextSpan(
          text: textItem.text,
          style: TextStyle(
            color: textItem.color,
            fontSize: textItem.size,
            fontFamily: textItem.fontFamily,
          ),
        ),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width - textItem.position.dx);

      final rect = textItem.position & textPainter.size;
      if (rect.contains(position)) {
        return i;
      }
    }
    return null;
  }

  void _startTextDrag(Offset position, Size size) {
    final index = _hitTestText(position, size);
    if (index == null) return;
    setState(() {
      _activeTextIndex = index;
      _textDragStart = position;
      _textOrigin = _texts[index].position;
    });
  }

  void _updateTextDrag(Offset position) {
    if (_activeTextIndex == null ||
        _textDragStart == null ||
        _textOrigin == null) {
      return;
    }
    final delta = position - _textDragStart!;
    setState(() {
      _texts[_activeTextIndex!] = _texts[_activeTextIndex!].copyWith(
        position: _textOrigin! + delta,
      );
    });
  }

  void _endTextDrag() {
    setState(() {
      _activeTextIndex = null;
      _textDragStart = null;
      _textOrigin = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: RepaintBoundary(
              key: _canvasKey,
              child: GestureDetector(
                onTapUp: (details) {
                  if (_isBucketTool) {
                    _fillAt(details.localPosition);
                  } else if (_isTextTool) {
                    _addTextAt(details.localPosition);
                  }
                },
                onPanStart: (details) {
                  if (_isTextTool) {
                    final renderBox = context.findRenderObject() as RenderBox?;
                    if (renderBox == null) return;
                    _startTextDrag(details.localPosition, renderBox.size);
                  } else if (_isBucketTool) {
                    return;
                  } else {
                    _startStroke(details.localPosition);
                  }
                },
                onPanUpdate: (details) {
                  if (_isTextTool) {
                    _updateTextDrag(details.localPosition);
                  } else if (_isBucketTool) {
                    return;
                  } else {
                    _appendStrokePoint(details.localPosition);
                  }
                },
                onPanEnd: (_) {
                  if (_isTextTool) {
                    _endTextDrag();
                  } else if (_isBucketTool) {
                    return;
                  } else {
                    _endStroke();
                  }
                },
                child: CustomPaint(
                  painter: _DrawingPainter(
                    strokes: List<_Stroke>.of(_strokes),
                    texts: List<_TextItem>.of(_texts),
                    fillLayer: _fillLayer,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Material(
              color: Colors.white.withValues(alpha: 0.95),
              elevation: 2,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: IconTheme(
                  data: const IconThemeData(size: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: IconButton(
                            tooltip: 'Undo',
                            icon: const Icon(Icons.undo),
                            onPressed: _undoLastStroke,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            tooltip: 'Clear',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: _clearCanvas,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Center(
                          child: _ToolIconButton(
                            icon: Icons.brush,
                            isSelected:
                                !_isEraser && !_isTextTool && !_isBucketTool,
                            onPressed: () {
                              setState(() {
                                _isEraser = false;
                                _isTextTool = false;
                                _isBucketTool = false;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Center(
                          child: _ToolIconButton(
                            icon: Icons.auto_fix_off,
                            isSelected: _isEraser,
                            onPressed: () {
                              setState(() {
                                _isEraser = true;
                                _isTextTool = false;
                                _isBucketTool = false;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Center(
                          child: _ToolIconButton(
                            icon: Icons.text_fields,
                            isSelected: _isTextTool,
                            onPressed: () {
                              setState(() {
                                _isTextTool = true;
                                _isEraser = false;
                                _isBucketTool = false;
                                _activeTextIndex = null;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Center(
                          child: _ToolIconButton(
                            icon: Icons.format_color_fill,
                            isSelected: _isBucketTool,
                            onPressed: () {
                              setState(() {
                                _isBucketTool = true;
                                _isTextTool = false;
                                _isEraser = false;
                                _activeTextIndex = null;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            tooltip: 'More tools',
                            icon: const Icon(Icons.tune),
                            onPressed: _openToolsSheet,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  const _DrawingPainter({
    required this.strokes,
    required this.texts,
    this.fillLayer,
  });

  final List<_Stroke> strokes;
  final List<_TextItem> texts;
  final ui.Image? fillLayer;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);
    if (fillLayer != null) {
      canvas.drawImage(fillLayer!, Offset.zero, Paint());
    }

    canvas.saveLayer(Offset.zero & size, Paint());
    for (final stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round
        ..blendMode = stroke.isEraser ? BlendMode.clear : BlendMode.srcOver;

      final points = stroke.points;
      for (var i = 0; i < points.length - 1; i++) {
        final current = points[i];
        final next = points[i + 1];
        if (current != null && next != null) {
          canvas.drawLine(current, next, paint);
        }
      }
    }

    for (final textItem in texts) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: textItem.text,
          style: TextStyle(
            color: textItem.color,
            fontSize: textItem.size,
            fontFamily: textItem.fontFamily,
          ),
        ),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width - textItem.position.dx);

      textPainter.paint(canvas, textItem.position);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DrawingPainter oldDelegate) {
    return true;
  }
}

class _Stroke {
  _Stroke({
    required this.points,
    required this.color,
    required this.width,
    required this.isEraser,
    required this.timestamp,
  });

  final List<Offset?> points;
  final Color color;
  final double width;
  final bool isEraser;
  final DateTime timestamp;
}

class _FillLayer {
  _FillLayer({required this.image, required this.timestamp});

  final ui.Image image;
  final DateTime timestamp;
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black87 : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _ToolIconButton extends StatelessWidget {
  const _ToolIconButton({
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        color: isSelected ? Colors.blue : Colors.grey.shade700,
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      ),
    );
  }
}

class _ToolPreview extends StatelessWidget {
  const _ToolPreview({
    required this.isText,
    required this.isEraser,
    required this.color,
    required this.strokeWidth,
    required this.textSize,
    required this.fontFamily,
  });

  final bool isText;
  final bool isEraser;
  final Color color;
  final double strokeWidth;
  final double textSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    if (isText) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Aa',
          style: TextStyle(
            color: color,
            fontSize: textSize,
            fontFamily: fontFamily,
          ),
        ),
      );
    }

    final previewSize = strokeWidth.clamp(4.0, 28.0);
    final previewColor = isEraser ? Colors.grey.shade500 : color;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: previewSize,
        height: previewSize,
        decoration: BoxDecoration(
          color: previewColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _TextItem {
  _TextItem({
    required this.text,
    required this.position,
    required this.color,
    required this.size,
    required this.fontFamily,
    required this.timestamp,
  });

  final String text;
  final Offset position;
  final Color color;
  final double size;
  final String? fontFamily;
  final DateTime timestamp;

  _TextItem copyWith({
    String? text,
    Offset? position,
    Color? color,
    double? size,
    String? fontFamily,
    DateTime? timestamp,
  }) {
    return _TextItem(
      text: text ?? this.text,
      position: position ?? this.position,
      color: color ?? this.color,
      size: size ?? this.size,
      fontFamily: fontFamily ?? this.fontFamily,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
