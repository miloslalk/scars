import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  bool _isLoadingTrack = true;
  bool _playingRemote = false;
  String? _remoteUrl;
  String? _loadError;
  GuidedAudioTrack _track = const GuidedAudioTrack(
    title: '',
    description: '',
    fallbackAssetPath: 'music/keys-of-moon-white-petals(chosic.com).mp3',
    storagePath: null,
  );

  @override
  void initState() {
    super.initState();
    _player.setReleaseMode(ReleaseMode.stop);
    _player.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _player.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
    _player.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    _player.onPlayerComplete.listen((_) {
      setState(() {
        _position = Duration.zero;
        _isPlaying = false;
      });
    });
    _loadTrack();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

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
    if (_track.storagePath != null) {
      try {
        _remoteUrl ??= await FirebaseStorage.instance
            .ref(_track.storagePath!)
            .getDownloadURL();
        await _player.play(UrlSource(_remoteUrl!));
        if (!mounted) return;
        setState(() {
          _playingRemote = true;
        });
        return;
      } catch (_) {}
    }

    await _player.play(AssetSource(_track.fallbackAssetPath));
    if (!mounted) return;
    setState(() {
      _playingRemote = false;
    });
  }

  Future<void> _skip() async {
    await _player.stop();
    if (!mounted) return;
    Navigator.pop(context);
  }

  String _format(Duration duration) {
    String two(int n) => n.toString().padLeft(2, '0');
    final minutes = two(duration.inMinutes.remainder(60));
    final seconds = two(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingTrack) {
      return const Scaffold(
        appBar: AppTopBar(showUserAction: false),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final max = _duration.inMilliseconds.toDouble();
    final value = _position.inMilliseconds.clamp(0, _duration.inMilliseconds);

    return Scaffold(
      appBar: const AppTopBar(showUserAction: false),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final horizontalPadding = constraints.maxWidth >= 1000 ? 40.0 : 20.0;
          final verticalPadding = constraints.maxHeight >= 700 ? 24.0 : 12.0;

          Widget meta = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _track.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                _track.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (_loadError != null) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.guidedMeditationMetadataLoadFailed,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 8),
              Text(
                _playingRemote
                    ? l10n.guidedMeditationSourceFirebase
                    : l10n.guidedMeditationSourceFallback,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );

          Widget playerCore = Column(
            children: [
              Expanded(
                child: Center(
                  child: Icon(
                    Icons.music_note,
                    size: isWide ? 160 : 120,
                    color: Colors.blue.shade200,
                  ),
                ),
              ),
              Slider(
                value: max == 0 ? 0 : value.toDouble(),
                max: max == 0 ? 1 : max,
                onChanged: (newValue) {
                  _player.seek(Duration(milliseconds: newValue.round()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(_format(_position)), Text(_format(_duration))],
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, actionConstraints) {
                  if (actionConstraints.maxWidth >= 420) {
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _skip,
                            child: Text(l10n.skipLabel),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _togglePlay,
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            label: Text(
                              _isPlaying ? l10n.pauseLabel : l10n.playLabel,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Wrap(
                    runSpacing: 8,
                    children: [
                      SizedBox(
                        width: actionConstraints.maxWidth,
                        child: OutlinedButton(
                          onPressed: _skip,
                          child: Text(l10n.skipLabel),
                        ),
                      ),
                      SizedBox(
                        width: actionConstraints.maxWidth,
                        child: ElevatedButton.icon(
                          onPressed: _togglePlay,
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          label: Text(
                            _isPlaying ? l10n.pauseLabel : l10n.playLabel,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: isWide
                ? Row(
                    children: [
                      Expanded(flex: 4, child: meta),
                      const SizedBox(width: 24),
                      Expanded(flex: 6, child: playerCore),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      meta,
                      const SizedBox(height: 16),
                      Expanded(child: playerCore),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
