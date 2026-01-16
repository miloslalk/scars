import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'care_corner_page.dart';
import 'package:flutter/services.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import '../widgets/app_top_bar.dart';
import 'landing_page.dart';
import 'music_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.username,
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final String username;
  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _buildPages(String displayName) {
    return [
      _HomeContent(displayName: displayName),
      _BodyAwarenessContent(),
      const CareCornerPage(),
      _MySpaceContent(),
      _MessagesContent(),
      _HelpContent(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LandingPage(
          localeNotifier: widget.localeNotifier,
          supportedLocales: widget.supportedLocales,
          themeModeNotifier: widget.themeModeNotifier,
        ),
      ),
      (route) => false,
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          localeNotifier: widget.localeNotifier,
          supportedLocales: widget.supportedLocales,
          themeModeNotifier: widget.themeModeNotifier,
        ),
      ),
    );
  }

  Widget _buildScaffold({
    required String displayName,
    String? avatarUrl,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final initial = displayName.trim().isNotEmpty
        ? displayName.trim().substring(0, 1).toUpperCase()
        : null;

    return Scaffold(
      appBar: AppTopBar(
        userInitial: initial,
        userName: displayName,
        userAvatarUrl: avatarUrl,
        onSettingsTap: _openSettings,
        onLogoutTap: _logout,
      ),
      body: _buildPages(displayName)[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: l10n.homeLabel),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            label: 'Body awareness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.park_outlined),
            label: 'Care Corner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'My Space',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Messages',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: l10n.helpLabel),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return _buildScaffold(displayName: widget.username);
    }
    final profileStream =
        FirebaseDatabase.instance.ref('users/${user.uid}').onValue;
    return StreamBuilder<DatabaseEvent>(
      stream: profileStream,
      builder: (context, snapshot) {
        final value = snapshot.data?.snapshot.value;
        String? avatarUrl;
        String? fullName;
        if (value is Map) {
          final data = Map<String, dynamic>.from(value);
          final avatarValue = data['avatarUrl'];
          final nameValue = data['fullName'];
          avatarUrl = avatarValue is String ? avatarValue : null;
          fullName = nameValue is String ? nameValue : null;
        }
        final displayName = (fullName != null && fullName.trim().isNotEmpty)
            ? fullName.trim()
            : widget.username;
        return _buildScaffold(
          displayName: displayName,
          avatarUrl: avatarUrl,
        );
      },
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent({required this.displayName});

  final String displayName;

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  final GlobalKey<_DrawingCanvasState> _canvasKey =
      GlobalKey<_DrawingCanvasState>();

  Future<void> _handleSkip() async {
    final proceed = await _confirmBodyCheck();
    if (!proceed) return;
    _canvasKey.currentState?._clearCanvas();
  }

  Future<void> _handleSave() async {
    final proceed = await _confirmBodyCheck(waitForMusic: false);
    if (!proceed) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Saving...')),
    );
    try {
      final result = await _canvasKey.currentState?.saveToFirebase();
      if (!mounted) return;
      final message = result ?? 'Canvas is not ready yet.';
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (error) {
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(content: Text('Save failed: $error')),
      );
    }
  }

  Future<bool> _confirmBodyCheck({bool waitForMusic = true}) async {
    final result = await showDialog<_BodyCheckChoice>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            'Would you like to take a moment to gently tune into the physical '
            'sensation in your body before identifing your feeling?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, _BodyCheckChoice.yes),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, _BodyCheckChoice.skip),
              child: const Text('Skip'),
            ),
          ],
        );
      },
    );
    if (result == null) return false;
    if (result == _BodyCheckChoice.yes) {
      final route = MaterialPageRoute(
        builder: (context) => const MusicPlayerPage(
          assetPath: 'music/keys-of-moon-white-petals(chosic.com).mp3',
        ),
      );
      if (waitForMusic) {
        await Navigator.push(context, route);
      } else {
        Navigator.push(context, route);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        widget.displayName.trim().isNotEmpty ? widget.displayName.trim() : 'there';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Hi $displayName, How are you feeling today?',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: DrawingCanvas(
              key: _canvasKey,
              username: widget.displayName,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _handleSkip,
                  child: const Text('Skip'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleSave,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _BodyCheckChoice {
  yes,
  skip,
}

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
          (_strokes.isEmpty || _texts.last.timestamp.isAfter(_strokes.last.timestamp))) {
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
      await ref.putData(
        pngBytes,
        SettableMetadata(contentType: 'image/png'),
      );
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
    return '${safeUsername}_${yyyy}${mm}${dd}_${hh}${min}${ss}.png';
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
      final isLetterOrDigit = (codeUnit >= 48 && codeUnit <= 57) ||
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
            decoration: const InputDecoration(
              hintText: 'Write up to 2 lines',
            ),
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
          style: TextStyle(
            color: textItem.color,
            fontSize: textItem.size,
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
    if (_activeTextIndex == null || _textDragStart == null || _textOrigin == null) {
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
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.white,
    );

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

class _MySpaceContent extends StatefulWidget {
  @override
  State<_MySpaceContent> createState() => _MySpaceContentState();
}

class _MySpaceContentState extends State<_MySpaceContent> {
  Future<void> _openCalendar() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (selected == null || !mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _MySpaceCalendarSheet(date: selected),
      ),
    );
  }

  void _openJournal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _MySpaceJournalPage()),
    );
  }

  void _openLibrary() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _MySpaceLibraryPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Space',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const Text(
            'Calendar, journaling, and your saved library in one place.',
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _MySpaceTile(
                icon: Icons.calendar_month,
                title: 'Calendar',
                subtitle: 'Mood, body, quote, note',
                onTap: _openCalendar,
              ),
              _MySpaceTile(
                icon: Icons.book_outlined,
                title: 'Journal',
                subtitle: 'Entries and prompts',
                onTap: _openJournal,
              ),
              _MySpaceTile(
                icon: Icons.folder_copy_outlined,
                title: 'Library',
                subtitle: 'Saved resources',
                onTap: _openLibrary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MySpaceTile extends StatelessWidget {
  const _MySpaceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.shade50,
              child: Icon(icon, color: Colors.blue),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _MySpaceCalendarSheet extends StatefulWidget {
  const _MySpaceCalendarSheet({required this.date});

  final DateTime date;

  @override
  State<_MySpaceCalendarSheet> createState() => _MySpaceCalendarSheetState();
}

class _MySpaceCalendarSheetState extends State<_MySpaceCalendarSheet> {
  final PageController _controller = PageController();
  int _pageIndex = 0;
  bool _isLoading = true;
  List<_DayDrawing> _dayDrawings = [];
  String? _noteText;
  String? _quoteText;
  _BodyAwarenessPoint? _bodyPoint;

  @override
  void initState() {
    super.initState();
    _loadDayData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadDayData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final drawingsSnap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/drawings')
          .get();
      final journalSnap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/journal')
          .get();
      final bodySnap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness/${_dateKey(widget.date)}')
          .get();

      final drawingsForDay = <_DayDrawing>[];
      if (drawingsSnap.exists && drawingsSnap.value is Map) {
        final data = Map<String, dynamic>.from(drawingsSnap.value as Map);
        for (final entry in data.entries) {
          final value = entry.value;
          if (value is! Map) continue;
          final map = Map<String, dynamic>.from(value);
          final createdAt = map['createdAt'] as String?;
          final storagePath = map['storagePath'] as String?;
          if (createdAt == null || storagePath == null) continue;
          final parsed = DateTime.tryParse(createdAt);
          if (parsed == null) continue;
          if (!_isSameDay(parsed, widget.date)) continue;
          drawingsForDay.add(
            _DayDrawing(
              key: entry.key,
              storagePath: storagePath,
              createdAt: parsed,
              downloadUrl: null,
            ),
          );
        }
      }

      String? latestNoteText;
      DateTime? latestNoteTime;
      if (journalSnap.exists && journalSnap.value is Map) {
        final data = Map<String, dynamic>.from(journalSnap.value as Map);
        for (final entry in data.values) {
          if (entry is! Map) continue;
          final map = Map<String, dynamic>.from(entry);
          final createdAt = map['createdAt'] as String?;
          final text = map['text'] as String?;
          if (createdAt == null || text == null) continue;
          final parsed = DateTime.tryParse(createdAt);
          if (parsed == null) continue;
          if (!_isSameDay(parsed, widget.date)) continue;
          if (latestNoteTime == null || parsed.isAfter(latestNoteTime)) {
            latestNoteTime = parsed;
            latestNoteText = text;
          }
        }
      }

      drawingsForDay.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      for (var i = 0; i < drawingsForDay.length; i++) {
        final item = drawingsForDay[i];
        try {
          final url = await FirebaseStorage.instance
              .ref(item.storagePath)
              .getDownloadURL();
          drawingsForDay[i] = item.copyWith(downloadUrl: url);
        } catch (_) {
          drawingsForDay[i] = item;
        }
      }

      _BodyAwarenessPoint? bodyPoint;
      if (bodySnap.exists && bodySnap.value is Map) {
        final data = Map<String, dynamic>.from(bodySnap.value as Map);
        final x = data['x'];
        final y = data['y'];
        final colorValue = data['color'];
        if (x is num && y is num && colorValue is int) {
          bodyPoint = _BodyAwarenessPoint(
            x: x.toDouble(),
            y: y.toDouble(),
            color: Color(colorValue),
          );
        }
      }

      if (!mounted) return;
      setState(() {
        _dayDrawings = drawingsForDay;
        _noteText = latestNoteText;
        _quoteText = null;
        _bodyPoint = bodyPoint;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _dateKey(DateTime date) {
    final yyyy = date.year.toString();
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '$yyyy$mm$dd';
  }

  Future<void> _confirmDeleteDrawing(_DayDrawing drawing) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete drawing?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      await FirebaseStorage.instance.ref(drawing.storagePath).delete();
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/drawings/${drawing.key}')
          .remove();
      if (!mounted) return;
      setState(() {
        _dayDrawings.removeWhere((item) => item.key == drawing.key);
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete drawing.')),
      );
    }
  }

  Widget _buildMoodContent() {
    if (_dayDrawings.isEmpty) {
      return const Center(child: Text('No drawings saved for this day.'));
    }
    if (_dayDrawings.length == 1) {
      return _buildDrawingViewer(_dayDrawings.first);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemExtent: constraints.maxHeight,
            physics: const PageScrollPhysics(),
            itemCount: _dayDrawings.length,
            itemBuilder: (context, index) {
              return _buildDrawingViewer(_dayDrawings[index]);
            },
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime date) {
    final hh = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    final ss = date.second.toString().padLeft(2, '0');
    return '$hh:$min:$ss';
  }

  Widget _buildBodyContent() {
    if (_bodyPoint == null) {
      return const Center(child: Text('No body map saved for this day.'));
    }
    return _BodyAwarenessView(
      point: _bodyPoint,
      interactive: false,
      outlineColor: Colors.grey.shade500,
    );
  }

  Widget _buildDrawingViewer(_DayDrawing drawing) {
    final timestamp = _formatTimestamp(drawing.createdAt);
    return Stack(
      children: [
        Positioned.fill(
          child: drawing.downloadUrl == null
              ? Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Text('Preview unavailable'),
                )
              : Image.network(
                  drawing.downloadUrl!,
                  fit: BoxFit.contain,
                ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              timestamp,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Material(
            color: Colors.white.withOpacity(0.9),
            shape: const CircleBorder(),
            child: IconButton(
              tooltip: 'Delete drawing',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDeleteDrawing(drawing),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        '${widget.date.year}-${widget.date.month.toString().padLeft(2, '0')}-${widget.date.day.toString().padLeft(2, '0')}';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Day overview',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text('Selected date: $dateLabel'),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PageView(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      children: [
                        _MySpaceCarouselPage(
                          title: 'Mood',
                          icon: Icons.sentiment_satisfied_alt,
                          content: _buildMoodContent(),
                          fullBleedContent: true,
                        ),
                        _MySpaceCarouselPage(
                          title: 'Body',
                          icon: Icons.accessibility_new,
                          content: _buildBodyContent(),
                          fullBleedContent: true,
                        ),
                        _MySpaceCarouselPage(
                          title: 'Quote',
                          body: _quoteText ?? 'No quote saved for this day.',
                          icon: Icons.format_quote,
                        ),
                        _MySpaceCarouselPage(
                          title: 'Note',
                          body: _noteText ?? 'No note saved for this day.',
                          icon: Icons.sticky_note_2_outlined,
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _pageIndex
                        ? Colors.blue
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MySpaceCarouselPage extends StatelessWidget {
  const _MySpaceCarouselPage({
    required this.title,
    this.body,
    required this.icon,
    this.imageUrl,
    this.content,
    this.fullBleedContent = false,
  });

  final String title;
  final String? body;
  final IconData icon;
  final String? imageUrl;
  final Widget? content;
  final bool fullBleedContent;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(icon, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Builder(
                  builder: (context) {
                    if (content != null) {
                      return fullBleedContent
                          ? SizedBox.expand(child: content!)
                          : content!;
                    }
                    if (imageUrl != null) {
                      return Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    }
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Text(body ?? ''),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayDrawing {
  const _DayDrawing({
    required this.key,
    required this.storagePath,
    required this.createdAt,
    required this.downloadUrl,
  });

  final String key;
  final String storagePath;
  final DateTime createdAt;
  final String? downloadUrl;

  _DayDrawing copyWith({
    String? key,
    String? storagePath,
    DateTime? createdAt,
    String? downloadUrl,
  }) {
    return _DayDrawing(
      key: key ?? this.key,
      storagePath: storagePath ?? this.storagePath,
      createdAt: createdAt ?? this.createdAt,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }
}

class _BodyAwarenessPoint {
  const _BodyAwarenessPoint({
    required this.x,
    required this.y,
    required this.color,
  });

  final double x;
  final double y;
  final Color color;
}

class _BodyAwarenessView extends StatelessWidget {
  const _BodyAwarenessView({
    required this.point,
    required this.interactive,
    this.onTap,
    this.outlineColor = Colors.white,
  });

  final _BodyAwarenessPoint? point;
  final bool interactive;
  final ValueChanged<Offset>? onTap;
  final Color outlineColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: interactive
              ? (details) => onTap?.call(details.localPosition)
              : null,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/Human_body_outline.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    outlineColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: _BodyGlowPainter(
                    point: point,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BodyGlowPainter extends CustomPainter {
  const _BodyGlowPainter({required this.point});

  final _BodyAwarenessPoint? point;

  @override
  void paint(Canvas canvas, Size size) {
    final active = point;
    if (active == null) return;

    final center = Offset(active.x * size.width, active.y * size.height);
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          active.color.withOpacity(0.85),
          active.color.withOpacity(0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 90));
    canvas.drawCircle(center, 90, glow);
  }

  @override
  bool shouldRepaint(_BodyGlowPainter oldDelegate) {
    return oldDelegate.point != point;
  }
}

class _JournalEntry {
  _JournalEntry({
    required this.title,
    required this.body,
    required this.date,
    required this.fontFamily,
    required this.isBold,
    required this.isItalic,
    required this.id,
  });

  final String title;
  final String body;
  final DateTime date;
  final String fontFamily;
  final bool isBold;
  final bool isItalic;
  final String id;
}

class _MySpaceJournalPage extends StatefulWidget {
  @override
  State<_MySpaceJournalPage> createState() => _MySpaceJournalPageState();
}

class _MySpaceJournalPageState extends State<_MySpaceJournalPage> {
  final List<_JournalEntry> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final ref = FirebaseDatabase.instance.ref('users/${user.uid}/journal');
    final snapshot = await ref.get();
    final loaded = <_JournalEntry>[];
    if (snapshot.exists && snapshot.value is Map) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      data.forEach((key, value) {
        if (value is Map) {
          final map = Map<String, dynamic>.from(value);
          final createdAt = map['createdAt'] as String?;
          final date = createdAt != null
              ? DateTime.tryParse(createdAt)
              : null;
          if (date == null) return;
          loaded.add(
            _JournalEntry(
              id: key,
              title: _formattedDate(date),
              body: (map['text'] as String?) ?? '',
              date: date,
              fontFamily: (map['fontFamily'] as String?) ?? 'Sans',
              isBold: (map['isBold'] as bool?) ?? false,
              isItalic: (map['isItalic'] as bool?) ?? false,
            ),
          );
        }
      });
    }
    loaded.sort((a, b) => b.date.compareTo(a.date));
    if (!mounted) return;
    setState(() {
      _entries
        ..clear()
        ..addAll(loaded);
      _isLoading = false;
    });
  }

  Future<void> _addEntry() async {
    final entry = await Navigator.push<_JournalEntry>(
      context,
      MaterialPageRoute(builder: (context) => _MySpaceJournalEditorPage()),
    );
    if (entry == null) return;
    final saved = await _saveEntryToDatabase(entry);
    if (saved == null) return;
    if (!mounted) return;
    setState(() {
      _entries.insert(0, saved);
    });
  }

  Future<_JournalEntry?> _saveEntryToDatabase(_JournalEntry entry) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    final ref = FirebaseDatabase.instance.ref('users/${user.uid}/journal');
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.child(id).set({
      'text': entry.body,
      'createdAt': entry.date.toIso8601String(),
      'fontFamily': entry.fontFamily,
      'isBold': entry.isBold,
      'isItalic': entry.isItalic,
    });
    return _JournalEntry(
      id: id,
      title: _formattedDate(entry.date),
      body: entry.body,
      date: entry.date,
      fontFamily: entry.fontFamily,
      isBold: entry.isBold,
      isItalic: entry.isItalic,
    );
  }

  String _formattedDate(DateTime date) {
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    final hh = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    final ss = date.second.toString().padLeft(2, '0');
    return '${date.year}-$mm-$dd $hh:$min:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Space Journal'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: const Icon(Icons.edit),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? const Center(child: Text('No journal entries yet.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final entry = _entries[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(entry.body),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}

class _MySpaceJournalEditorPage extends StatefulWidget {
  @override
  State<_MySpaceJournalEditorPage> createState() =>
      _MySpaceJournalEditorPageState();
}

class _MySpaceJournalEditorPageState extends State<_MySpaceJournalEditorPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;
  String _fontFamily = 'Sans';

  final List<String> _prompts = const [
    'What is one thing that brought you comfort today?',
    'How did your body feel this morning?',
    'Name three things you are grateful for.',
    'If your emotions were a color, what would it be?',
    'Write a short note to your future self.',
  ];

  TextStyle _editorStyle() {
    final family = _fontFamily == 'Serif'
        ? 'serif'
        : _fontFamily == 'Mono'
            ? 'monospace'
            : null;
    return TextStyle(
      fontSize: 16,
      fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
      fontFamily: family,
    );
  }

  void _saveEntry() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      Navigator.pop(context);
      return;
    }
    final entry = _JournalEntry(
      id: '',
      title: _formattedDate(DateTime.now()),
      body: text,
      date: DateTime.now(),
      fontFamily: _fontFamily,
      isBold: _isBold,
      isItalic: _isItalic,
    );
    Navigator.pop(context, entry);
  }

  String _formattedDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
        actions: [
          TextButton(
            onPressed: _saveEntry,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Prompts',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ..._prompts.map(
            (prompt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('• $prompt'),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton<String>(
                value: _fontFamily,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _fontFamily = value;
                  });
                },
                items: const [
                  DropdownMenuItem(value: 'Sans', child: Text('Sans')),
                  DropdownMenuItem(value: 'Serif', child: Text('Serif')),
                  DropdownMenuItem(value: 'Mono', child: Text('Mono')),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isBold = !_isBold;
                  });
                },
                icon: Icon(
                  Icons.format_bold,
                  color: _isBold ? Colors.blue : Colors.grey.shade600,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isItalic = !_isItalic;
                  });
                },
                icon: Icon(
                  Icons.format_italic,
                  color: _isItalic ? Colors.blue : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 12,
            style: _editorStyle(),
            decoration: InputDecoration(
              hintText: 'Start writing...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MySpaceLibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Space Library')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _librarySection(
            title: 'Saved Resources',
            items: const ['Guided breathing video', 'Calming audio'],
          ),
          const SizedBox(height: 16),
          _librarySection(
            title: 'Saved Messages',
            items: const [
              'Your heart is safe with you.',
              'Keep going. You are doing great.',
            ],
          ),
          const SizedBox(height: 16),
          _librarySection(
            title: 'Contacts',
            items: const ['Therapist', 'Trusted friend'],
          ),
        ],
      ),
    );
  }

  Widget _librarySection({
    required String title,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(item),
              )),
        ],
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, size: 80, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            l10n.profilePageTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(l10n.profilePageBody),
        ],
      ),
    );
  }
}

class _MessagesContent extends StatefulWidget {
  @override
  State<_MessagesContent> createState() => _MessagesContentState();
}

class _MessagesContentState extends State<_MessagesContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_BalloonSpec> _balloons;
  String? _balloonSvg;
  final Map<int, DateTime> _poppedAt = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();

    final random = Random(24);
    final palette = [
      const Color(0xFF6B539D),
      const Color(0xFF745CA3),
      const Color(0xFFBB9FC8),
      const Color(0xFF8E6FB8),
      const Color(0xFF5C4A87),
      const Color(0xFFB06FA8),
      const Color(0xFF7B5FA2),
    ];

    _balloons = List.generate(30, (index) {
      return _BalloonSpec(
        x: random.nextDouble(),
        size: 36 + random.nextDouble() * 60,
        speed: 0.08 + random.nextDouble() * 0.5,
        offset: random.nextDouble() * 2,
        drift: (random.nextDouble() - 0.5) * 0.08,
        color: palette[index % palette.length],
      );
    });

    _loadBalloonSvg();
  }

  Future<void> _loadBalloonSvg() async {
    try {
      final raw = await rootBundle.loadString('assets/images/balloon_heart.svg');
      final normalized = raw.replaceAll(
        'fill="#000000"',
        'fill="currentColor"',
      );
      if (!mounted) return;
      setState(() {
        _balloonSvg = normalized;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _popBalloon(int index) {
    if (_poppedAt.containsKey(index)) return;
    setState(() {
      _poppedAt[index] = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? const [Color(0xFF1A1624), Color(0xFF2E2940)]
        : const [Color(0xFFF7F5FA), Color(0xFFEDEDEC)];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: background,
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    for (var i = 0; i < _balloons.length; i++)
                      Positioned(
                        left: _balloonX(
                          _balloons[i],
                          constraints.maxWidth,
                          _controller.value,
                        ),
                        top: _balloonY(
                          _balloons[i],
                          constraints.maxHeight,
                          _controller.value,
                        ),
                        child: _buildBalloon(_balloons[i], i),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBalloon(_BalloonSpec balloon, int index) {
    final popStart = _poppedAt[index];
    if (popStart != null) {
      final elapsed =
          DateTime.now().difference(popStart).inMilliseconds / 320;
      if (elapsed >= 1) {
        return const SizedBox.shrink();
      }
      final scale = 1 + elapsed * 0.4;
      final opacity = (1 - elapsed).clamp(0.0, 1.0);
      return Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: scale,
          child: Icon(
            Icons.blur_on,
            color: balloon.color.withOpacity(0.9),
            size: balloon.size,
          ),
        ),
      );
    }

    final widget = _balloonSvg == null
        ? SvgPicture.asset(
            'assets/images/balloon_heart.svg',
            width: balloon.size,
            height: balloon.size,
            colorFilter: ColorFilter.mode(
              balloon.color,
              BlendMode.srcIn,
            ),
          )
        : SvgPicture.string(
            _balloonSvg!,
            width: balloon.size,
            height: balloon.size,
            colorFilter: ColorFilter.mode(
              balloon.color,
              BlendMode.srcIn,
            ),
          );

    return GestureDetector(
      onTap: () => _popBalloon(index),
      child: widget,
    );
  }
}

double _balloonY(_BalloonSpec balloon, double height, double progress) {
  final travel = (progress * balloon.speed + balloon.offset) % 1.0;
  return travel * height - balloon.size;
}

double _balloonX(_BalloonSpec balloon, double width, double progress) {
  final drift = (progress + balloon.offset) * 2 * pi;
  final sway = sin(drift) * balloon.drift;
  final base = (width - balloon.size) * balloon.x;
  return (base + sway * width).clamp(0.0, width - balloon.size);
}

class _BalloonSpec {
  const _BalloonSpec({
    required this.x,
    required this.size,
    required this.speed,
    required this.offset,
    required this.drift,
    required this.color,
  });

  final double x;
  final double size;
  final double speed;
  final double offset;
  final double drift;
  final Color color;
}

class _SettingsContent extends StatefulWidget {
  const _SettingsContent({
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  final ImagePicker _picker = ImagePicker();
  bool _isAvatarBusy = false;

  String _languageLabel(Locale locale, AppLocalizations l10n) {
    if (locale.languageCode == 'en') {
      return l10n.languageEnglish;
    }
    if (locale.languageCode == 'sr' && locale.scriptCode == 'Latn') {
      return l10n.languageSerbianLatin;
    }
    if (locale.languageCode == 'mk') {
      return l10n.languageMacedonian;
    }
    if (locale.languageCode == 'de') {
      return l10n.languageGerman;
    }
    if (locale.languageCode == 'el') {
      return l10n.languageGreek;
    }
    if (locale.languageCode == 'ro') {
      return l10n.languageRomanian;
    }
    if (locale.languageCode == 'ar') {
      return l10n.languageArabic;
    }
    if (locale.languageCode == 'rom') {
      return l10n.languageRomani;
    }
    if (locale.languageCode == 'tr') {
      return l10n.languageTurkish;
    }
    return locale.languageCode;
  }

  Future<void> _pickAvatar(ImageSource source) async {
    if (_isAvatarBusy) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _isAvatarBusy = true;
    });

    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 512,
      );
      if (picked == null) return;

      final file = File(picked.path);
      final ref = FirebaseStorage.instance
          .ref('users/${user.uid}/avatars/avatar.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/avatarUrl')
          .set(url);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avatar updated.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update avatar.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAvatarBusy = false;
        });
      }
    }
  }

  Future<void> _removeAvatar() async {
    if (_isAvatarBusy) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _isAvatarBusy = true;
    });

    try {
      final ref = FirebaseStorage.instance
          .ref('users/${user.uid}/avatars/avatar.jpg');
      await ref.delete();
    } catch (_) {}

    try {
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/avatarUrl')
          .remove();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avatar removed.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove avatar.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAvatarBusy = false;
        });
      }
    }
  }

  Future<void> _updateDisplayName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    try {
      await user.updateDisplayName(trimmed);
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/fullName')
          .set(trimmed);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name updated.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update name.')),
      );
    }
  }

  Future<void> _editDisplayName(String? currentName) async {
    final controller = TextEditingController(text: currentName ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit name'),
          content: TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Full name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result == null) return;
    await _updateDisplayName(result);
  }

  bool _canUpdateCredentials(User? user) {
    return user?.providerData
            .any((provider) => provider.providerId == 'password') ??
        false;
  }

  String? _validatePassword(String value) {
    final trimmed = value.trim();
    if (trimmed.length < 8) return 'Password must be at least 8 characters.';
    final hasUpper = RegExp(r'[A-Z]').hasMatch(trimmed);
    final hasNumber = RegExp(r'\d').hasMatch(trimmed);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(trimmed);
    if (!hasUpper || !hasNumber || !hasSpecial) {
      return 'Use 1 uppercase, 1 number, and 1 special character.';
    }
    return null;
  }

  Future<void> _updateEmail(String email, String? username) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final trimmed = email.trim();
    if (trimmed.isEmpty || !trimmed.contains('@')) return;
    final currentEmail = user.email?.trim();
    if (currentEmail != null &&
        currentEmail.isNotEmpty &&
        currentEmail.toLowerCase() == trimmed.toLowerCase()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email is unchanged.')),
      );
      return;
    }
    try {
      await user.updateEmail(trimmed);
      await user.sendEmailVerification();
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/email')
          .set(trimmed);
      if (username != null && username.trim().isNotEmpty) {
        await FirebaseDatabase.instance
            .ref('usernames/${_safeKey(username)}')
            .update({'email': trimmed});
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email updated. Please verify the new address.'),
        ),
      );
    } on FirebaseAuthException catch (error) {
      final message = error.code == 'requires-recent-login'
          ? 'Please log in again to update your email.'
          : 'Failed to update email.';
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update email.')),
      );
    }
  }

  String _safeKey(String value) {
    if (value.isEmpty) return 'user';
    final buffer = StringBuffer();
    for (final codeUnit in value.codeUnits) {
      final isValid = (codeUnit >= 48 && codeUnit <= 57) ||
          (codeUnit >= 65 && codeUnit <= 90) ||
          (codeUnit >= 97 && codeUnit <= 122) ||
          codeUnit == 45 ||
          codeUnit == 95;
      buffer.write(isValid ? String.fromCharCode(codeUnit) : '_');
    }
    return buffer.toString();
  }

  Future<void> _editEmail(String? currentEmail, String? username) async {
    final controller = TextEditingController(text: currentEmail ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit email'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result == null) return;
    await _updateEmail(result, username);
  }

  Future<void> _updatePassword(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final validation = _validatePassword(value);
    if (validation != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validation)),
      );
      return;
    }
    try {
      await user.updatePassword(value.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated.')),
      );
    } on FirebaseAuthException catch (error) {
      final message = error.code == 'requires-recent-login'
          ? 'Please log in again to update your password.'
          : 'Failed to update password.';
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update password.')),
      );
    }
  }

  Future<void> _editPassword() async {
    final controller = TextEditingController();
    final confirmController = TextEditingController();
    bool obscure = true;
    bool obscureConfirm = true;
    String? validationMessage;
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    obscureText: obscure,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        validationMessage = _validatePassword(value);
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmController,
                    obscureText: obscureConfirm,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirm = !obscureConfirm;
                          });
                        },
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      validationMessage ??
                          'Min 8 chars, 1 uppercase, 1 number, 1 special.',
                      style: TextStyle(
                        fontSize: 12,
                        color: validationMessage == null
                            ? Colors.grey.shade600
                            : Colors.red.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final password = controller.text;
                    final confirm = confirmController.text;
                    final validation = _validatePassword(password);
                    if (validation != null) {
                      setState(() {
                        validationMessage = validation;
                      });
                      return;
                    }
                    if (password != confirm) {
                      setState(() {
                        validationMessage = 'Passwords do not match.';
                      });
                      return;
                    }
                    Navigator.pop(context, password);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
    if (result == null) return;
    await _updatePassword(result);
  }

  Future<void> _reauthenticate() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final email = user.email?.trim();
    if (email == null || email.isEmpty) return;

    final controller = TextEditingController();
    bool obscure = true;
    final password = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Re-authenticate'),
              content: TextField(
                controller: controller,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );

    if (password == null || password.trim().isEmpty) return;
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password.trim(),
      );
      await user.reauthenticateWithCredential(credential);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication successful.')),
      );
    } on FirebaseAuthException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication failed.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication failed.')),
      );
    }
  }

  void _openAvatarSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Remove photo'),
                onTap: () {
                  Navigator.pop(context);
                  _removeAvatar();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _fallbackInitial(User? user) {
    final displayName = user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName.substring(0, 1).toUpperCase();
    }
    final email = user?.email?.trim();
    if (email != null && email.isNotEmpty) {
      return email.substring(0, 1).toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final profileStream = user == null
        ? null
        : FirebaseDatabase.instance
            .ref('users/${user.uid}')
            .onValue;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Text(
          l10n.settingsPreferencesTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.tune),
            title: Text(l10n.settingsPreferencesTitle),
            subtitle: Text(l10n.settingsPreferencesBody),
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder<DatabaseEvent>(
          stream: profileStream,
          builder: (context, snapshot) {
            final value = snapshot.data?.snapshot.value;
            String? avatarUrl;
            String? fullName;
            String? username;
            String? email;
            if (value is Map) {
              final data = Map<String, dynamic>.from(value);
              final avatarValue = data['avatarUrl'];
              final nameValue = data['fullName'];
              final usernameValue = data['username'];
              final emailValue = data['email'];
              avatarUrl = avatarValue is String ? avatarValue : null;
              fullName = nameValue is String ? nameValue : null;
              username = usernameValue is String ? usernameValue : null;
              email = emailValue is String ? emailValue : null;
            }
            final canUpdate = _canUpdateCredentials(user);
            final displayName =
                (fullName != null && fullName.trim().isNotEmpty)
                    ? fullName.trim()
                    : (user?.displayName ?? 'User');
            return Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: _openAvatarSheet,
                    leading: const Icon(Icons.account_circle_outlined),
                    title: const Text('Profile photo'),
                    subtitle: const Text('Add or remove your avatar.'),
                    trailing: _isAvatarBusy
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blue.shade100,
                            foregroundColor: Colors.blue.shade900,
                            backgroundImage: avatarUrl != null
                                ? NetworkImage(avatarUrl)
                                : null,
                            child: avatarUrl == null
                                ? Text(_fallbackInitial(user))
                                : null,
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Display name'),
                    subtitle: Text(displayName),
                    trailing: const Icon(Icons.edit),
                    onTap: () => _editDisplayName(displayName),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.verified_user_outlined),
                    title: const Text('Re-authenticate'),
                    subtitle: Text(
                      canUpdate
                          ? 'Confirm your password to update email or password.'
                          : 'Available only for password accounts.',
                    ),
                    trailing: Icon(
                      canUpdate ? Icons.chevron_right : Icons.lock_outline,
                    ),
                    onTap: canUpdate ? _reauthenticate : null,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('Email'),
                    subtitle: Text(email ?? user?.email ?? 'Unknown'),
                    trailing: Icon(
                      canUpdate ? Icons.edit : Icons.lock_outline,
                    ),
                    onTap: canUpdate
                        ? () => _editEmail(email ?? user?.email, username)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Password'),
                    subtitle: Text(
                      canUpdate
                          ? 'Update your password.'
                          : 'Managed by your sign-in provider.',
                    ),
                    trailing: Icon(
                      canUpdate ? Icons.edit : Icons.lock_outline,
                    ),
                    onTap: canUpdate ? _editPassword : null,
                  ),
                ),
              ],
            );
          },
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theme'),
                const SizedBox(height: 12),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: widget.themeModeNotifier,
                  builder: (context, mode, _) {
                    return DropdownButtonFormField<ThemeMode>(
                      value: mode,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('System'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Light'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Dark'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        widget.themeModeNotifier.value = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(l10n.settingsNotificationsTitle),
            subtitle: Text(l10n.settingsNotificationsBody),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.settingsLanguageTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.settingsLanguageBody),
                const SizedBox(height: 12),
                ValueListenableBuilder<Locale?>(
                  valueListenable: widget.localeNotifier,
                  builder: (context, locale, _) {
                    return DropdownButtonFormField<Locale?>(
                      value: locale,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(l10n.settingsLanguageSystem),
                        ),
                        ...widget.supportedLocales.map(
                          (supportedLocale) => DropdownMenuItem(
                            value: supportedLocale,
                            child: Text(_languageLabel(supportedLocale, l10n)),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          widget.localeNotifier.value = value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: _SettingsContent(
        localeNotifier: localeNotifier,
        supportedLocales: supportedLocales,
        themeModeNotifier: themeModeNotifier,
      ),
    );
  }
}

class _HelpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.help, size: 80, color: Colors.purple),
          SizedBox(height: 20),
          Text(
            l10n.helpTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(l10n.helpBody),
        ],
      ),
    );
  }
}

class _BodyAwarenessContent extends StatefulWidget {
  @override
  State<_BodyAwarenessContent> createState() => _BodyAwarenessContentState();
}


class _BodyAwarenessContentState extends State<_BodyAwarenessContent> {
  final List<Color> _palette = const [
    Color(0xFF1D5C7A),
    Color(0xFF2E8AA6),
    Color(0xFF52B0B8),
    Color(0xFF7FC6B6),
    Color(0xFFAEDB9D),
    Color(0xFFE7E27A),
    Color(0xFFF3C562),
    Color(0xFFF2A55A),
    Color(0xFFE67C5A),
    Color(0xFFD65B6E),
    Color(0xFFB14E8D),
    Color(0xFF7A4CA0),
  ];

  _BodyAwarenessPoint? _point;
  Color _selectedColor = const Color(0xFFF2A55A);
  bool _isSaving = false;

  void _setPoint(Offset localPosition, Size size) {
    final x = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final y = (localPosition.dy / size.height).clamp(0.0, 1.0);
    setState(() {
      _point = _BodyAwarenessPoint(x: x, y: y, color: _selectedColor);
    });
  }

  String _detectBodyRegion(Offset localPosition, Size size) {
    final x = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final y = (localPosition.dy / size.height).clamp(0.0, 1.0);

    if (y < 0.18 && x > 0.35 && x < 0.65) return 'Head';
    if (y >= 0.18 && y < 0.25 && x > 0.40 && x < 0.60) return 'Neck';
    if (y >= 0.25 && y < 0.35 && x <= 0.30) return 'Left shoulder';
    if (y >= 0.25 && y < 0.35 && x >= 0.70) return 'Right shoulder';
    if (y >= 0.25 && y < 0.45 && x > 0.30 && x < 0.70) return 'Chest';
    if (y >= 0.45 && y < 0.58 && x > 0.35 && x < 0.65) return 'Stomach';
    if (y >= 0.60 && y < 0.85 && x <= 0.22) return 'Left hand';
    if (y >= 0.60 && y < 0.85 && x >= 0.78) return 'Right hand';
    if (y >= 0.35 && y < 0.60 && x <= 0.30) return 'Left arm';
    if (y >= 0.35 && y < 0.60 && x >= 0.70) return 'Right arm';
    if (y >= 0.58 && y < 0.78 && x > 0.35 && x < 0.65) return 'Hips';
    if (y >= 0.70 && y < 0.80 && x > 0.30 && x < 0.45) return 'Left knee';
    if (y >= 0.70 && y < 0.80 && x > 0.55 && x < 0.70) return 'Right knee';
    if (y >= 0.80 && y < 0.92 && x > 0.30 && x < 0.45) return 'Left leg';
    if (y >= 0.80 && y < 0.92 && x > 0.55 && x < 0.70) return 'Right leg';
    if (y >= 0.92 && x < 0.50) return 'Left foot';
    if (y >= 0.92 && x >= 0.50) return 'Right foot';
    return 'Body';
  }

  String _dateKey(DateTime date) {
    final yyyy = date.year.toString();
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '$yyyy$mm$dd';
  }

  Future<void> _save() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final point = _point;
    if (point == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tap the body to log a sensation.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final now = DateTime.now();
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness/${_dateKey(now)}')
          .set({
        'x': point.x,
        'y': point.y,
        'color': point.color.value,
        'createdAt': now.toIso8601String(),
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Body awareness saved.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save body awareness.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? const [Color(0xFF2E2940), Color(0xFF1A1624)]
        : const [Color(0xFF745CA3), Color(0xFFBBA6D6)];
    final textColor = isDark ? const Color(0xFFF2EEF8) : Colors.white;
    final panelColor =
        isDark ? const Color(0xFF2E2940) : Colors.white.withOpacity(0.9);
    final outlineColor =
        isDark ? const Color(0xFFD9CFEA) : Colors.white;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Where does this feeling seem in rest in your body?\n'
                'Please touch that spot and select a color that feels true '
                'to the sensation.',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _BodyAwarenessView(
                      point: _point,
                      interactive: true,
                      outlineColor: outlineColor,
                      onTap: (offset) {
                        final region =
                            _detectBodyRegion(offset, constraints.biggest);
                        debugPrint('Body awareness tap: $region');
                        _setPoint(offset, constraints.biggest);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: panelColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _palette.map((color) {
                      final selected = color == _selectedColor;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                            if (_point != null) {
                              _point = _BodyAwarenessPoint(
                                x: _point!.x,
                                y: _point!.y,
                                color: _selectedColor,
                              );
                            }
                          });
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF6B539D)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: Text(_isSaving ? 'Saving...' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
