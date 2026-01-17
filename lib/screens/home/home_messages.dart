part of '../home_page.dart';

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
  late final List<String> _messagePool;

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

    _messagePool = const [
      'You are doing better than you think.',
      'Take a deep breath. You are safe right now.',
      'Small steps still move you forward.',
      'Your feelings are valid and important.',
      'You are allowed to take up space.',
      'Be gentle with yourself today.',
      'You are stronger than this moment.',
      'Let today be enough.',
      'You deserve kindness, especially from yourself.',
      'It is okay to pause and rest.',
      'You are not alone.',
      'Keep going. You are growing.',
    ];

    _balloons = List.generate(30, (index) {
      final messageText = _messagePool[random.nextInt(_messagePool.length)];
      return _BalloonSpec(
        x: random.nextDouble(),
        size: 36 + random.nextDouble() * 60,
        speed: 0.08 + random.nextDouble() * 0.5,
        offset: random.nextDouble() * 2,
        drift: (random.nextDouble() - 0.5) * 0.08,
        color: palette[index % palette.length],
        message: _MessageSpec(id: 'msg_$index', text: messageText),
      );
    });

    _loadBalloonSvg();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _popBalloon(int index) {
    if (_poppedAt.containsKey(index)) return;
    final balloon = _balloons[index];
    _showMessageDialog(balloon);
    setState(() {
      _poppedAt[index] = DateTime.now();
    });
  }

  Future<void> _showMessageDialog(_BalloonSpec balloon) async {
    final message = balloon.message;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(message.text),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await _saveMessage(message);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await _reportMessage(message);
              },
              child: const Text('Report'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveMessage(_MessageSpec message) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseDatabase.instance
        .ref('users/${user.uid}/library/messages')
        .push()
        .set({
          'text': message.text,
          'savedAt': DateTime.now().toIso8601String(),
        });
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saved to My Space.')));
  }

  Future<void> _reportMessage(_MessageSpec message) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseDatabase.instance.ref('message_reports').push().set({
        'messageId': message.id,
        'messageText': message.text,
        'reporterUid': user?.uid,
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'pending',
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Reported. Thank you.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report failed. Please try again.')),
      );
    }
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
        ? SvgPicture.asset(
            'assets/images/balloon-heart-fill_1.svg',
            width: balloon.size,
            height: balloon.size,
            colorFilter: ColorFilter.mode(balloon.color, BlendMode.srcIn),
          )
        : SvgPicture.string(
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
  const _MessageSpec({required this.id, required this.text});

  final String id;
  final String text;
}
