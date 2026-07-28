import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/services/guided_audio_service.dart';

import '../widgets/app_top_bar.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    this.localeCode = 'en',
    required this.fallbackAssetPath,
  });

  final String localeCode;
  final String fallbackAssetPath;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage>
    with TickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  final List<StreamSubscription> _playerSubscriptions = [];
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  bool _isLoadingTrack = true;
  bool _trackLoaded = false;
  bool _usingFallbackAsset = false;
  String? _loadError;
  GuidedAudioTrack _track = const GuidedAudioTrack(
    title: '',
    description: '',
    fallbackAssetPath: 'music/keys-of-moon-white-petals(chosic.com).mp3',
  );

  late final AnimationController _bgController;
  late final AnimationController _pulseController;
  late final List<_FloatingOrb> _orbs;

  // --- Monster video state ---
  static String get _introClip => Platform.isIOS
      ? 'assets/monster_clips/04_guided_meditation/ios/1_guided_meditation.mov'
      : 'assets/monster_clips/04_guided_meditation/android/1_guided_meditation.webm';
  static String get _loopClip => Platform.isIOS
      ? 'assets/monster_clips/04_guided_meditation/ios/2_guided_meditation.mov'
      : 'assets/monster_clips/04_guided_meditation/android/2_guided_meditation.webm';

  VideoPlayerController? _introController;
  VideoPlayerController? _loopController;

  /// The controller currently being displayed.
  VideoPlayerController? _activeVideo;
  VoidCallback? _introEndListener;
  bool _videoReady = false;
  bool _closed = false;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    final rng = Random(42);
    _orbs = List.generate(8, (_) => _FloatingOrb.random(rng));

    _player.setReleaseMode(ReleaseMode.stop);
    _playerSubscriptions.add(
      _player.onDurationChanged.listen((duration) {
        setState(() {
          _duration = duration;
        });
      }),
    );
    _playerSubscriptions.add(
      _player.onPositionChanged.listen((position) {
        setState(() {
          _position = position;
        });
      }),
    );
    _playerSubscriptions.add(
      _player.onPlayerStateChanged.listen((state) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }),
    );
    _playerSubscriptions.add(
      _player.onPlayerComplete.listen((_) {
        setState(() {
          _position = Duration.zero;
          _isPlaying = false;
        });
        // Music ended — close the page.
        if (!_closed && mounted) {
          Navigator.pop(context);
        }
      }),
    );
    _playerSubscriptions.add(
      _player.eventStream.listen(
        (_) {},
        // Network/decoder failures of the remote stream surface here, not
        // through play()'s future — without this the player just goes
        // silent instead of falling back to the bundled track.
        onError: (Object _) {
          if (_closed || !mounted) return;
          unawaited(_fallbackToAsset());
        },
      ),
    );

    // Start preparing videos immediately.
    unawaited(_initVideos());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_trackLoaded) {
      _trackLoaded = true;
      _loadTrack();
    }
  }

  @override
  void dispose() {
    _closed = true;
    _bgController.dispose();
    _pulseController.dispose();
    for (final sub in _playerSubscriptions) {
      sub.cancel();
    }
    _player.dispose();
    if (_introEndListener != null) {
      _introController?.removeListener(_introEndListener!);
    }
    _introController?.dispose();
    _loopController?.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Video lifecycle
  // ---------------------------------------------------------------------------

  Future<void> _initVideos() async {
    try {
      // Initialise intro, and pre-initialise loop + outro in parallel so they
      // are ready the moment we need them (no spinner between clips).
      final viewType = Platform.isIOS
          ? VideoViewType.platformView
          : VideoViewType.textureView;
      final intro = VideoPlayerController.asset(_introClip, viewType: viewType);
      final loop = VideoPlayerController.asset(_loopClip, viewType: viewType);

      _introController = intro;
      _loopController = loop;

      await Future.wait([intro.initialize(), loop.initialize()]);

      if (_closed) return;

      await loop.setLooping(true);

      // Listen for intro end → switch to loop clip.
      var switchedToLoop = false;
      _introEndListener = () {
        if (switchedToLoop || _closed) return;
        if (!intro.value.isInitialized) return;
        if (intro.value.isPlaying) return;
        if (intro.value.position >= intro.value.duration &&
            intro.value.duration > Duration.zero) {
          switchedToLoop = true;
          _switchToLoop();
        }
      };
      intro.addListener(_introEndListener!);

      _activeVideo = intro;
      await intro.play();
      if (!mounted || _closed) return;
      setState(() {
        _videoReady = true;
      });
    } catch (_) {}
  }

  void _switchToLoop() {
    if (_closed) return;
    final loop = _loopController;
    if (loop == null || !loop.value.isInitialized) return;

    _activeVideo = loop;
    loop.play();
    if (mounted) setState(() {});
  }

  // ---------------------------------------------------------------------------
  // Audio
  // ---------------------------------------------------------------------------

  Future<void> _loadTrack() async {
    try {
      final l10n = AppLocalizations.of(context)!;
      final resolved = await GuidedAudioService.instance.resolveTrack(
        localeCode: widget.localeCode,
        fallbackAssetPath: widget.fallbackAssetPath,
        defaultTitle: l10n.guidedMeditationTitle,
        defaultDescription: l10n.guidedMeditationDescription,
      );
      if (!mounted) return;
      setState(() {
        _track = resolved;
        _isLoadingTrack = false;
      });
      // Auto-play as soon as the track is resolved.
      unawaited(_startPlayback());
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loadError = '$error';
        _isLoadingTrack = false;
      });
    }
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
      return;
    }
    if (_position > Duration.zero) {
      await _player.resume();
    } else {
      await _startPlayback();
    }
  }

  Future<void> _startPlayback() async {
    final url = _track.remoteUrl;
    if (url != null && !_usingFallbackAsset) {
      try {
        await _player.play(UrlSource(url));
        return;
      } catch (_) {}
    }

    await _fallbackToAsset();
  }

  Future<void> _fallbackToAsset() async {
    if (_usingFallbackAsset) return;
    _usingFallbackAsset = true;
    try {
      await _player.play(AssetSource(_track.fallbackAssetPath));
    } catch (_) {
      // Both sources failed — leave the paused UI; the user can still exit.
    }
  }

  void _skip() {
    if (_closed) return;
    unawaited(_player.stop().catchError((_) {}));
    if (mounted) Navigator.pop(context);
  }

  String _format(Duration duration) {
    String two(int n) => n.toString().padLeft(2, '0');
    final minutes = two(duration.inMinutes.remainder(60));
    final seconds = two(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Widget _buildActiveVideo() {
    final controller = _activeVideo;
    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox.shrink();
    }
    // Let the native AVPlayerLayer handle scaling (aspect-fit) instead of
    // FittedBox, which doesn't reliably apply transforms to iOS platform views.
    return Positioned.fill(
      child: SizedBox.expand(child: VideoPlayer(controller)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradientColors = isDark
        ? const [Color(0xFF1A1035), Color(0xFF2D1B69), Color(0xFF0F2027)]
        : const [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFFF093FB)];

    if (_isLoadingTrack) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }
    final max = _duration.inMilliseconds.toDouble();
    final value = _position.inMilliseconds.clamp(0, _duration.inMilliseconds);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppTopBar(showUserAction: false),
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          final t = _bgController.value;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(
                  -1.0 + sin(t * 2 * pi) * 0.3,
                  -1.0 + cos(t * 2 * pi) * 0.3,
                ),
                end: Alignment(
                  1.0 + cos(t * 2 * pi) * 0.3,
                  1.0 + sin(t * 2 * pi) * 0.3,
                ),
                colors: gradientColors,
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            // Floating orbs (full screen)
            ...List.generate(_orbs.length, (i) {
              final orb = _orbs[i];
              return AnimatedBuilder(
                animation: _bgController,
                builder: (context, _) {
                  final t = _bgController.value;
                  final dx = sin((t + orb.phaseX) * 2 * pi) * orb.driftX;
                  final dy = cos((t + orb.phaseY) * 2 * pi) * orb.driftY;
                  final opacity = 0.08 + sin((t + orb.phaseX) * pi) * 0.06;
                  return Positioned(
                    left: MediaQuery.of(context).size.width * orb.startX + dx,
                    top: MediaQuery.of(context).size.height * orb.startY + dy,
                    child: Container(
                      width: orb.size,
                      height: orb.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orb.color.withValues(alpha: opacity),
                      ),
                    ),
                  );
                },
              );
            }),
            // Monster video (full screen) — only the active clip is in the tree.
            if (_videoReady) _buildActiveVideo(),
            // Controls — inside SafeArea so they respect notch/home bar.
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Track info
                    if (_track.title.isNotEmpty) ...[
                      Text(
                        _track.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (_track.description.isNotEmpty)
                      Text(
                        _track.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    if (_loadError != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        l10n.guidedMeditationMetadataLoadFailed,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const Spacer(flex: 1),
                    // Pulsing music icon — hide when video is showing
                    if (!_videoReady)
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final scale = _isPlaying
                              ? 1.0 + _pulseController.value * 0.12
                              : 1.0;
                          final glowRadius = _isPlaying
                              ? 40.0 + _pulseController.value * 30.0
                              : 30.0;
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFF093FB,
                                    ).withValues(alpha: 0.3),
                                    blurRadius: glowRadius,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.music_note_rounded,
                                size: 64,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          );
                        },
                      ),
                    const Spacer(flex: 2),
                    // Slider & controls
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white.withValues(
                          alpha: 0.25,
                        ),
                        thumbColor: Colors.white,
                        overlayColor: Colors.white.withValues(alpha: 0.15),
                        trackHeight: 3,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                      ),
                      child: Slider(
                        value: max == 0 ? 0 : value.toDouble(),
                        max: max == 0 ? 1 : max,
                        onChanged: (newValue) {
                          _player.seek(
                            Duration(milliseconds: newValue.round()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _format(_position),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _format(_duration),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _skip,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: Text(l10n.skipLabel),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _togglePlay,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.2,
                              ),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 0,
                            ),
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            label: Text(
                              _isPlaying ? l10n.pauseLabel : l10n.playLabel,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingOrb {
  const _FloatingOrb({
    required this.startX,
    required this.startY,
    required this.size,
    required this.color,
    required this.phaseX,
    required this.phaseY,
    required this.driftX,
    required this.driftY,
  });

  factory _FloatingOrb.random(Random rng) {
    const colors = [
      Color(0xFFF093FB),
      Color(0xFF667EEA),
      Color(0xFF764BA2),
      Color(0xFFE0C3FC),
      Color(0xFF8EC5FC),
      Color(0xFFFDCB82),
    ];
    return _FloatingOrb(
      startX: rng.nextDouble(),
      startY: rng.nextDouble(),
      size: 60 + rng.nextDouble() * 120,
      color: colors[rng.nextInt(colors.length)],
      phaseX: rng.nextDouble(),
      phaseY: rng.nextDouble(),
      driftX: 15 + rng.nextDouble() * 30,
      driftY: 15 + rng.nextDouble() * 30,
    );
  }

  final double startX;
  final double startY;
  final double size;
  final Color color;
  final double phaseX;
  final double phaseY;
  final double driftX;
  final double driftY;
}
