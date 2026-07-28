part of '../home_page.dart';

class _MessagesContent extends StatefulWidget {
  @override
  State<_MessagesContent> createState() => _MessagesContentState();
}

class _MessagesContentState extends State<_MessagesContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_BalloonSpec> _balloons = [];
  String? _balloonSvg;
  final Map<String, DateTime> _poppedAt = {};
  _MessageSpec? _shownMessage;
  bool _saved = false;
  bool _hasOpenedToday = false;
  bool _popInFlight = false;
  String _localeCode = 'en';
  bool _messagesLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();

    _loadBalloonSvg();
    _checkOpenedToday();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).languageCode;
    if (!_messagesLoaded || locale != _localeCode) {
      _messagesLoaded = true;
      _localeCode = locale;
      _loadMessages();
    }
  }

  // Device-local day key so the daily limit resets at the user's midnight,
  // consistent with daily_flow/daily_quotes/daily_messages keys.
  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> _checkOpenedToday() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final snapshot = await FirebaseDatabase.instance
          .ref('users/${user.uid}/opened_messages/${_todayKey()}')
          .get();
      if (!mounted) return;
      if (snapshot.exists) {
        setState(() => _hasOpenedToday = true);
      }
    } catch (_) {
      // Fail open: popping still requires its own successful write.
    }
  }

  Future<void> _loadBalloonSvg() async {
    try {
      final raw = await rootBundle.loadString(
        'assets/images/balloon-heart-fill_1.svg',
      );
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

  Future<void> _loadMessages() async {
    final results = await Future.wait([
      _readMessages(),
      _readPoppedMessageIds(),
    ]);
    final messages = results[0] as List<_MessageSpec>;
    final popped = results[1] as Set<String>;
    // Once popped, a message is never shown to this user again.
    final unpopped = messages
        .where((message) => !popped.contains(safeKey(message.id)))
        .toList();
    if (!mounted) return;
    setState(() {
      _balloons = _buildBalloons(unpopped);
      _poppedAt.clear();
    });
  }

  Future<Set<String>> _readPoppedMessageIds() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return {};
    try {
      final snapshot = await FirebaseDatabase.instance
          .ref('users/${user.uid}/popped_messages')
          .get();
      final value = snapshot.value;
      if (value is! Map) return {};
      return value.keys.map((key) => key.toString()).toSet();
    } catch (_) {
      return {};
    }
  }

  Future<List<_MessageSpec>> _readMessages() async {
    final fromDb = await _readMessagesFromDatabase();
    if (fromDb != null && fromDb.isNotEmpty) return fromDb;
    return [];
  }

  static bool _looksLikeMessage(Map item) {
    return item['text'] is String || item['textEn'] is String;
  }

  Future<List<_MessageSpec>?> _readMessagesFromDatabase() async {
    try {
      final snapshot = await FirebaseDatabase.instance.ref('messages').get();
      final value = snapshot.value;
      if (value is! Map) return null;
      final messages = <_MessageSpec>[];
      final seenIds = <String>{};

      // The DB holds two shapes: flat `messages/{id}` entries (bulk import
      // tool) and per-locale buckets `messages/{locale}/{id}` (admin tool).
      final localeBuckets = <String, Map>{};
      for (final entry in value.entries) {
        final item = entry.value;
        if (item is! Map) continue;
        if (_looksLikeMessage(item)) {
          final enabled = item['enabled'];
          if (enabled is bool && !enabled) continue;
          final id = (item['id'] ?? entry.key).toString();
          final text = (item['text'] as String?)?.trim() ?? '';
          final textEn = (item['textEn'] as String?)?.trim() ?? '';
          if (text.isEmpty && textEn.isEmpty) continue;
          if (!seenIds.add(id)) continue;
          messages.add(
            _MessageSpec(
              id: id,
              text: text.isNotEmpty ? text : textEn,
              englishText: textEn.isNotEmpty ? textEn : null,
            ),
          );
        } else {
          localeBuckets[entry.key.toString()] = item;
        }
      }

      final enBucket = localeBuckets['en'];
      final bucket = localeBuckets[_localeCode] ?? enBucket;
      if (bucket != null) {
        for (final entry in bucket.entries) {
          final item = entry.value;
          if (item is! Map) continue;
          final enabled = item['enabled'];
          if (enabled is bool && !enabled) continue;
          final id = (item['id'] ?? entry.key).toString();
          final text = (item['text'] as String?)?.trim() ?? '';
          if (text.isEmpty) continue;
          if (!seenIds.add(id)) continue;
          String? textEn;
          if (!identical(bucket, enBucket)) {
            final enItem = enBucket?[entry.key];
            if (enItem is Map) {
              final enText = (enItem['text'] as String?)?.trim();
              if (enText != null && enText.isNotEmpty) textEn = enText;
            }
          }
          messages.add(_MessageSpec(id: id, text: text, englishText: textEn));
        }
      }
      return messages;
    } catch (_) {}
    return null;
  }

  List<_BalloonSpec> _buildBalloons(List<_MessageSpec> messages) {
    if (messages.isEmpty) return [];
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

    final availableMessages = List<_MessageSpec>.of(messages)..shuffle(random);
    return List.generate(availableMessages.length, (index) {
      final message = availableMessages[index];
      return _BalloonSpec(
        x: random.nextDouble(),
        size: 36 + random.nextDouble() * 60,
        speed: 0.08 + random.nextDouble() * 0.5,
        offset: random.nextDouble() * 2,
        drift: (random.nextDouble() - 0.5) * 0.08,
        color: palette[index % palette.length],
        message: message,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _popBalloon(int index) async {
    if (_hasOpenedToday) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.messageAlreadyOpenedToday)));
      return;
    }
    final balloon = _balloons[index];
    final messageId = balloon.message.id;
    if (_poppedAt.containsKey(messageId) || _popInFlight) return;

    // Persist BEFORE showing the pop: "once popped, never shown again" must
    // hold even if the app dies right after the animation.
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _popInFlight = true;
      try {
        final now = DateTime.now();
        await Future.wait([
          FirebaseDatabase.instance
              .ref('users/${user.uid}/opened_messages/${_todayKey()}')
              .set({'openedAt': now.toIso8601String(), 'messageId': messageId}),
          FirebaseDatabase.instance
              .ref('users/${user.uid}/popped_messages/${safeKey(messageId)}')
              .set({'messageId': messageId, 'poppedAt': now.toIso8601String()}),
        ]);
      } catch (_) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.messageOpenFailed)));
        }
        return;
      } finally {
        _popInFlight = false;
      }
    }
    if (!mounted) return;
    setState(() {
      _shownMessage = balloon.message;
      _poppedAt[messageId] = DateTime.now();
      _hasOpenedToday = true;
    });
    Future.delayed(const Duration(milliseconds: 320), () {
      if (!mounted) return;
      setState(() {
        _balloons.removeWhere((item) => item.message.id == messageId);
        _poppedAt.remove(messageId);
      });
    });
  }

  void _dismissThoughtCloud() {
    setState(() {
      _shownMessage = null;
      _saved = false;
    });
  }

  Future<void> _saveMessage(_MessageSpec message) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final now = DateTime.now();
    final dateKey = _todayKey();
    await Future.wait([
      FirebaseDatabase.instance
          .ref('users/${user.uid}/library/messages')
          .push()
          .set({
            'text': message.text,
            'textEn': message.englishText ?? message.text,
            'savedAt': now.toIso8601String(),
          }),
      FirebaseDatabase.instance
          .ref('users/${user.uid}/daily_messages/$dateKey')
          .set({
            'text': message.text,
            'textEn': message.englishText ?? message.text,
            'savedAt': now.toIso8601String(),
          }),
    ]);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.savedToMySpace)));
  }

  Widget _buildMessageOverlay() {
    final message = _shownMessage!;
    final english = message.englishText;
    final hasTranslation =
        english != null &&
        english.trim().isNotEmpty &&
        english.trim() != message.text.trim();

    // Cloud SVG viewBox: 300x257 — roughly square
    return GestureDetector(
      onTap: _dismissThoughtCloud,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final svgWidth = constraints.maxWidth;
                  final svgHeight = svgWidth * (257 / 300);

                  return SizedBox(
                    width: svgWidth,
                    height: svgHeight,
                    child: Stack(
                      children: [
                        svg.SvgPicture.asset(
                          'assets/images/cloud_jon_phillips_01.svg',
                          width: svgWidth,
                          height: svgHeight,
                          fit: BoxFit.contain,
                        ),
                        // Text area inside cloud body
                        Positioned(
                          left: svgWidth * 0.18,
                          right: svgWidth * 0.18,
                          top: svgHeight * 0.22,
                          bottom: svgHeight * 0.24,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: svgWidth * 0.64,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (hasTranslation) ...[
                                    Text(
                                      english,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2E1A47),
                                        height: 1.3,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      message.text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF5C4A87),
                                        height: 1.3,
                                      ),
                                    ),
                                  ] else
                                    Text(
                                      message.text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2E1A47),
                                        height: 1.3,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Save button — outside top-right of cloud
                        Positioned(
                          right: svgWidth * 0.06,
                          top: svgHeight * 0.02,
                          child: GestureDetector(
                            onTap: _saved
                                ? null
                                : () async {
                                    try {
                                      await _saveMessage(message);
                                    } catch (_) {
                                      if (!context.mounted) return;
                                      final l10n = AppLocalizations.of(
                                        context,
                                      )!;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(l10n.genericSaveFailed),
                                        ),
                                      );
                                      return;
                                    }
                                    if (!mounted) return;
                                    setState(() => _saved = true);
                                    Future.delayed(
                                      const Duration(milliseconds: 1500),
                                      () {
                                        if (!mounted) return;
                                        _dismissThoughtCloud();
                                      },
                                    );
                                  },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  _saved
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  key: ValueKey(_saved),
                                  size: 22,
                                  color: _saved
                                      ? const Color(0xFFB06FA8)
                                      : const Color(0xFF5C4A87),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
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
                    if (_shownMessage != null) _buildMessageOverlay(),
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
    final popStart = _poppedAt[balloon.message.id];
    if (popStart != null) {
      final elapsed = DateTime.now().difference(popStart).inMilliseconds / 320;
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
            color: balloon.color.withValues(alpha: 0.9),
            size: balloon.size,
          ),
        ),
      );
    }

    final widget = _balloonSvg == null
        ? svg.SvgPicture.asset(
            'assets/images/balloon-heart-fill_1.svg',
            width: balloon.size,
            height: balloon.size,
            colorFilter: ColorFilter.mode(balloon.color, BlendMode.srcIn),
          )
        : svg.SvgPicture.string(
            _balloonSvg!,
            width: balloon.size,
            height: balloon.size,
            colorFilter: ColorFilter.mode(balloon.color, BlendMode.srcIn),
          );

    return GestureDetector(onTap: () => _popBalloon(index), child: widget);
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
    required this.message,
  });

  final double x;
  final double size;
  final double speed;
  final double offset;
  final double drift;
  final Color color;
  final _MessageSpec message;
}

class _MessageSpec {
  const _MessageSpec({required this.id, required this.text, this.englishText});

  final String id;
  final String text;
  final String? englishText;
}
