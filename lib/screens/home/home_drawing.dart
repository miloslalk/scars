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
  _Stroke? _activeStroke;
  Color _strokeColor = Colors.black87;
  double _strokeWidth = 3;
  bool _isEraser = false;
  bool _isTextTool = false;
  double _textSize = 20;
  int? _activeTextIndex;
  Offset? _textDragStart;
  Offset? _textOrigin;
  final List<Color> _palette = const [
    Color(0xFF000000),
    Color(0xFF2F2F2F),
    Color(0xFF6B6B6B),
    Color(0xFFFFFFFF),
    Color(0xFFE53935),
    Color(0xFFF4511E),
    Color(0xFFF9A825),
    Color(0xFFFDD835),
    Color(0xFF7CB342),
    Color(0xFF43A047),
    Color(0xFF26A69A),
    Color(0xFF00ACC1),
    Color(0xFF1E88E5),
    Color(0xFF3949AB),
    Color(0xFF5E35B1),
    Color(0xFF8E24AA),
    Color(0xFFD81B60),
    Color(0xFFFF7043),
    Color(0xFF8D6E63),
    Color(0xFF90A4AE),
  ];

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
      _texts.clear();
    });
  }

  void _undoLastStroke() {
    if (_strokes.isEmpty && _texts.isEmpty) return;
    setState(() {
      if (_texts.isNotEmpty &&
          (_strokes.isEmpty ||
              _texts.last.timestamp.isAfter(_strokes.last.timestamp))) {
        _texts.removeLast();
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
    });
  }

  void _setTextTool() {
    setState(() {
      _isTextTool = true;
      _isEraser = false;
      _activeTextIndex = null;
    });
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
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
                      onPressed: () => Navigator.pop(sheetContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _undoLastStroke,
                      icon: const Icon(Icons.undo),
                      label: const Text('Undo'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _clearCanvas,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Clear'),
                    ),
                    _ToolIconButton(
                      icon: Icons.brush,
                      isSelected: !_isEraser && !_isTextTool,
                      onPressed: () => _setTool(false),
                    ),
                    _ToolIconButton(
                      icon: Icons.auto_fix_off,
                      isSelected: _isEraser,
                      onPressed: () => _setTool(true),
                    ),
                    _ToolIconButton(
                      icon: Icons.text_fields,
                      isSelected: _isTextTool,
                      onPressed: _setTextTool,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                IgnorePointer(
                  ignoring: _isEraser,
                  child: Opacity(
                    opacity: _isEraser ? 0.4 : 1,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final color in _palette)
                          _ColorChip(
                            color: color,
                            isSelected: _strokeColor == color,
                            onTap: () => _setStrokeColor(color),
                          ),
                      ],
                    ),
                  ),
                ),
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
                          onChanged: (value) {
                            setState(() {
                              _textSize = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )
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
                          onChanged: _setStrokeWidth,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startStroke(Offset position) {
    if (_isTextTool) return;
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
    if (_isTextTool) return;
    setState(() {
      _activeStroke?.points.add(position);
    });
  }

  void _endStroke() {
    if (_isTextTool) return;
    setState(() {
      _activeStroke?.points.add(null);
      _activeStroke = null;
    });
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
          style: TextStyle(color: textItem.color, fontSize: textItem.size),
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
                  if (_isTextTool) {
                    _addTextAt(details.localPosition);
                  }
                },
                onPanStart: (details) {
                  if (_isTextTool) {
                    final renderBox = context.findRenderObject() as RenderBox?;
                    if (renderBox == null) return;
                    _startTextDrag(details.localPosition, renderBox.size);
                  } else {
                    _startStroke(details.localPosition);
                  }
                },
                onPanUpdate: (details) {
                  if (_isTextTool) {
                    _updateTextDrag(details.localPosition);
                  } else {
                    _appendStrokePoint(details.localPosition);
                  }
                },
                onPanEnd: (_) {
                  if (_isTextTool) {
                    _endTextDrag();
                  } else {
                    _endStroke();
                  }
                },
                child: CustomPaint(
                  painter: _DrawingPainter(
                    strokes: List<_Stroke>.of(_strokes),
                    texts: List<_TextItem>.of(_texts),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 2,
              child: IconButton(
                tooltip: 'Tools',
                icon: const Icon(Icons.tune),
                onPressed: _openToolsSheet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  const _DrawingPainter({required this.strokes, required this.texts});

  final List<_Stroke> strokes;
  final List<_TextItem> texts;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);

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
          style: TextStyle(color: textItem.color, fontSize: textItem.size),
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
        icon: Icon(icon),
        color: isSelected ? Colors.blue : Colors.grey.shade700,
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
    required this.timestamp,
  });

  final String text;
  final Offset position;
  final Color color;
  final double size;
  final DateTime timestamp;

  _TextItem copyWith({
    String? text,
    Offset? position,
    Color? color,
    double? size,
    DateTime? timestamp,
  }) {
    return _TextItem(
      text: text ?? this.text,
      position: position ?? this.position,
      color: color ?? this.color,
      size: size ?? this.size,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
