part of '../home_page.dart';

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
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saving...')),
    );
    try {
      final result = await _canvasKey.currentState?.saveToFirebase();
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      final message = result ?? 'Canvas is not ready yet.';
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text('Save failed: $error')));
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
    if (!mounted) return false;
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
    final displayName = widget.displayName.trim().isNotEmpty
        ? widget.displayName.trim()
        : 'there';

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
            child: DrawingCanvas(key: _canvasKey, username: widget.displayName),
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

enum _BodyCheckChoice { yes, skip }
