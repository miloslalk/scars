part of '../home_page.dart';

class _MySpaceContent extends StatefulWidget {
  @override
  State<_MySpaceContent> createState() => _MySpaceContentState();
}

class _MySpaceContentState extends State<_MySpaceContent> {
  Future<void> _openCalendar() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const _MySpaceCalendarPickerSheet(),
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
          Text('My Space', style: Theme.of(context).textTheme.headlineSmall),
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

class _MySpaceCalendarPickerSheet extends StatefulWidget {
  const _MySpaceCalendarPickerSheet();

  @override
  State<_MySpaceCalendarPickerSheet> createState() =>
      _MySpaceCalendarPickerSheetState();
}

class _MySpaceCalendarPickerSheetState
    extends State<_MySpaceCalendarPickerSheet> {
  late final DateTime _lastDay =
      DateTime(DateTime.now().year + 1, 12, 31);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isLoading = true;
  Set<String> _entryKeys = {};
  DateTime _minSelectableDay = DateTime(2022, 1, 1);

  @override
  void initState() {
    super.initState();
    _minSelectableDay = DateUtils.dateOnly(
      FirebaseAuth.instance.currentUser?.metadata.creationTime ??
          DateTime(2022, 1, 1),
    );
    _focusedDay = DateUtils.dateOnly(DateTime.now());
    _loadEntryDates();
  }

  Future<void> _loadEntryDates() async {
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
          .ref('users/${user.uid}/body_awareness')
          .get();

      final keys = <String>{};
      if (drawingsSnap.exists && drawingsSnap.value is Map) {
        final data = Map<String, dynamic>.from(drawingsSnap.value as Map);
        for (final entry in data.values) {
          if (entry is! Map) continue;
          final map = Map<String, dynamic>.from(entry);
          final createdAt = map['createdAt'] as String?;
          if (createdAt == null) continue;
          final parsed = DateTime.tryParse(createdAt);
          if (parsed == null) continue;
          keys.add(_dateKey(parsed));
        }
      }

      if (journalSnap.exists && journalSnap.value is Map) {
        final data = Map<String, dynamic>.from(journalSnap.value as Map);
        for (final entry in data.values) {
          if (entry is! Map) continue;
          final map = Map<String, dynamic>.from(entry);
          final createdAt = map['createdAt'] as String?;
          if (createdAt == null) continue;
          final parsed = DateTime.tryParse(createdAt);
          if (parsed == null) continue;
          keys.add(_dateKey(parsed));
        }
      }

      if (bodySnap.exists && bodySnap.value is Map) {
        final data = Map<String, dynamic>.from(bodySnap.value as Map);
        for (final key in data.keys) {
          if (key.length == 8) {
            keys.add(key);
          }
        }
      }

      if (!mounted) return;
      setState(() {
        _entryKeys = keys;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _dateKey(DateTime date) {
    final yyyy = date.year.toString();
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '$yyyy$mm$dd';
  }

  void _openDaySheet(DateTime date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _MySpaceCalendarSheet(date: date),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Calendar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              TableCalendar(
                firstDay: _minSelectableDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                enabledDayPredicate: (day) {
                  final today = DateUtils.dateOnly(DateTime.now());
                  final candidate = DateUtils.dateOnly(day);
                  if (candidate.isBefore(_minSelectableDay)) return false;
                  return !candidate.isAfter(today);
                },
                selectedDayPredicate: (day) =>
                    _selectedDay != null && isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  final today = DateUtils.dateOnly(DateTime.now());
                  final candidate = DateUtils.dateOnly(selectedDay);
                  if (candidate.isBefore(_minSelectableDay)) return;
                  if (candidate.isAfter(today)) return;
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _openDaySheet(selectedDay);
                },
                onPageChanged: (focusedDay) {
                  final normalized = DateUtils.dateOnly(focusedDay);
                  if (normalized.isBefore(_minSelectableDay)) {
                    _focusedDay = _minSelectableDay;
                  } else {
                    _focusedDay = focusedDay;
                  }
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final hasEntry = _entryKeys.contains(_dateKey(day));
                    if (!hasEntry) return null;
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: Text('${day.day}'),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final hasEntry = _entryKeys.contains(_dateKey(day));
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade50,
                        border: hasEntry
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    final hasEntry = _entryKeys.contains(_dateKey(day));
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        border: hasEntry
                            ? Border.all(color: Colors.blue.shade900, width: 2)
                            : null,
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
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
              : Image.network(drawing.downloadUrl!, fit: BoxFit.contain),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
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
            color: Colors.white.withValues(alpha: 0.9),
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
    this.content,
    this.fullBleedContent = false,
  });

  final String title;
  final String? body;
  final IconData icon;
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
                  colorFilter: ColorFilter.mode(outlineColor, BlendMode.srcIn),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(painter: _BodyGlowPainter(point: point)),
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
          active.color.withValues(alpha: 0.85),
          active.color.withValues(alpha: 0.15),
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
          final date = createdAt != null ? DateTime.tryParse(createdAt) : null;
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
      appBar: AppBar(title: const Text('My Space Journal')),
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
              separatorBuilder: (_, _) => const SizedBox(height: 12),
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
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Prompts', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ..._prompts.map(
            (prompt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('ƒ?ô $prompt'),
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

class _MySpaceLibraryPage extends StatefulWidget {
  @override
  State<_MySpaceLibraryPage> createState() => _MySpaceLibraryPageState();
}

class _MySpaceLibraryPageState extends State<_MySpaceLibraryPage> {
  List<String> _savedMessages = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedMessages();
  }

  Future<void> _loadSavedMessages() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _savedMessages = const [];
        _loading = false;
      });
      return;
    }

    final snapshot = await FirebaseDatabase.instance
        .ref('users/${user.uid}/library/messages')
        .get();

    final values = snapshot.value;
    final messages = <String>[];
    if (values is Map) {
      for (final entry in values.values) {
        if (entry is Map) {
          final text = entry['text'];
          if (text is String && text.trim().isNotEmpty) {
            messages.add(text);
          }
        }
      }
    }

    if (!mounted) return;
    setState(() {
      _savedMessages = messages;
      _loading = false;
    });
  }

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
            items: _loading
                ? const ['Loading...']
                : (_savedMessages.isEmpty
                      ? const ['No saved messages yet.']
                      : _savedMessages),
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

  Widget _librarySection({required String title, required List<String> items}) {
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
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(item),
            ),
          ),
        ],
      ),
    );
  }
}
