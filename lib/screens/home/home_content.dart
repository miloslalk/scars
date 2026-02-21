part of '../home_page.dart';
// ignore_for_file: use_build_context_synchronously

class _HomeContent extends StatefulWidget {
  const _HomeContent({required this.displayName});

  final String displayName;

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  final GlobalKey<_DrawingCanvasState> _canvasKey =
      GlobalKey<_DrawingCanvasState>();
  bool _isLoading = true;
  bool _hasShownDailyPrompt = false;
  bool _isPromptDialogOpen = false;
  _HomeStepStatus _moodStatus = _HomeStepStatus.pending;
  _HomeStepStatus _bodyStatus = _HomeStepStatus.pending;
  String? _quoteText;
  bool _isMoodFullscreen = false;

  static const List<String> _dailyAffirmations = [
    'You are allowed to take this day one breath at a time.',
    'Your feelings matter, and your body deserves gentle care.',
    'You are stronger than this moment feels right now.',
    'Small steps today are still meaningful progress.',
    'You belong exactly as you are, here and now.',
    'Your voice, your pace, and your healing all count.',
    'You can rest and still be growing.',
  ];

  @override
  void initState() {
    super.initState();
    _loadDailyFlow();
  }

  String _todayKey() {
    final now = DateTime.now();
    final yyyy = now.year.toString();
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    return '$yyyy$mm$dd';
  }

  _HomeStepStatus _statusFromValue(Object? value) {
    if (value is String) {
      switch (value) {
        case 'completed':
          return _HomeStepStatus.completed;
        case 'skipped':
          return _HomeStepStatus.skipped;
      }
    }
    return _HomeStepStatus.pending;
  }

  String _statusToValue(_HomeStepStatus status) {
    switch (status) {
      case _HomeStepStatus.completed:
        return 'completed';
      case _HomeStepStatus.skipped:
        return 'skipped';
      case _HomeStepStatus.pending:
        return 'pending';
    }
  }

  Future<void> _loadDailyFlow() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _showDailyPromptIfNeeded();
      return;
    }

    final key = _todayKey();
    try {
      final flowRef = FirebaseDatabase.instance.ref(
        'users/${user.uid}/daily_flow/$key',
      );
      final quoteRef = FirebaseDatabase.instance.ref(
        'users/${user.uid}/daily_quotes/$key',
      );
      final snapshots = await Future.wait([flowRef.get(), quoteRef.get()]);
      final flowSnap = snapshots[0];
      final quoteSnap = snapshots[1];

      var moodStatus = _HomeStepStatus.pending;
      var bodyStatus = _HomeStepStatus.pending;
      var hasPrompt = false;
      String? quote;

      if (flowSnap.exists && flowSnap.value is Map) {
        final map = Map<String, dynamic>.from(flowSnap.value as Map);
        moodStatus = _statusFromValue(map['moodStatus']);
        bodyStatus = _statusFromValue(map['bodyStatus']);
        hasPrompt = map['moodPromptShownAt'] != null;
        final quoteValue = map['quote'];
        if (quoteValue is String && quoteValue.trim().isNotEmpty) {
          quote = quoteValue.trim();
        }
      }

      if (quote == null && quoteSnap.exists && quoteSnap.value is Map) {
        final map = Map<String, dynamic>.from(quoteSnap.value as Map);
        final text = map['text'];
        if (text is String && text.trim().isNotEmpty) {
          quote = text.trim();
        }
      }

      if (!mounted) return;
      setState(() {
        _moodStatus = moodStatus;
        _bodyStatus = bodyStatus;
        _hasShownDailyPrompt = hasPrompt;
        _quoteText = quote;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }

    if (_currentView == _HomeStepView.quote) {
      await _ensureDailyQuote();
    }
    _showDailyPromptIfNeeded();
  }

  Future<void> _persistDailyFlow() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final now = DateTime.now().toIso8601String();
    await FirebaseDatabase.instance
        .ref('users/${user.uid}/daily_flow/${_todayKey()}')
        .set({
          'moodStatus': _statusToValue(_moodStatus),
          'bodyStatus': _statusToValue(_bodyStatus),
          'quote': _quoteText,
          if (_hasShownDailyPrompt) 'moodPromptShownAt': now,
          'updatedAt': now,
        });
  }

  Future<void> _showDailyPromptIfNeeded() async {
    if (!mounted || _hasShownDailyPrompt || _isPromptDialogOpen) return;
    _isPromptDialogOpen = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _hasShownDailyPrompt) {
        _isPromptDialogOpen = false;
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('How are you feeling today?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Start'),
              ),
            ],
          );
        },
      );
      if (!mounted) {
        _isPromptDialogOpen = false;
        return;
      }
      setState(() {
        _hasShownDailyPrompt = true;
      });
      _isPromptDialogOpen = false;
      await _persistDailyFlow();
    });
  }

  _HomeStepView get _currentView {
    if (_moodStatus == _HomeStepStatus.pending) {
      return _HomeStepView.mood;
    }
    if (_bodyStatus == _HomeStepStatus.pending) {
      return _HomeStepView.body;
    }
    return _HomeStepView.quote;
  }

  Future<void> _handleMoodSkip() async {
    setState(() {
      _moodStatus = _HomeStepStatus.skipped;
    });
    _canvasKey.currentState?._clearCanvas();
    await _persistDailyFlow();
    await _showBodyTransitionDialogIfNeeded();
  }

  Future<void> _handleMoodSave() async {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saving...')));
    try {
      final result = await _canvasKey.currentState?.saveToFirebase();
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      final message = result ?? 'Canvas is not ready yet.';
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text(message)));
      if (result == 'Drawing saved.') {
        setState(() {
          _moodStatus = _HomeStepStatus.completed;
        });
        await _persistDailyFlow();
        await _showBodyTransitionDialogIfNeeded();
      }
    } catch (error) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text('Save failed: $error')));
    }
  }

  Future<void> _showBodyTransitionDialogIfNeeded() async {
    while (mounted && _bodyStatus == _HomeStepStatus.pending) {
      if (!context.mounted) return;
      final result = await showDialog<_BodyTransitionChoice>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              'Would you like to take a moment to gently tune into the physical '
              'sensations in your body before identifying your feeling?',
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, _BodyTransitionChoice.continueBody),
                child: const Text('Continue'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  _BodyTransitionChoice.guidedMeditation,
                ),
                child: const Text('Guided meditation'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, _BodyTransitionChoice.skipBody),
                child: const Text('Skip'),
              ),
            ],
          );
        },
      );
      if (!mounted || result == null) return;
      if (result == _BodyTransitionChoice.continueBody) return;
      if (result == _BodyTransitionChoice.guidedMeditation) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicPlayerPage(
              localeCode: Localizations.localeOf(context).languageCode,
              fallbackAssetPath:
                  'music/keys-of-moon-white-petals(chosic.com).mp3',
            ),
          ),
        );
        continue;
      }

      setState(() {
        _bodyStatus = _HomeStepStatus.skipped;
      });
      await _persistDailyFlow();
      await _ensureDailyQuote();
      return;
    }
  }

  Future<void> _skipToQuote() async {
    setState(() {
      _moodStatus = _HomeStepStatus.skipped;
      _bodyStatus = _HomeStepStatus.skipped;
    });
    await _persistDailyFlow();
    await _ensureDailyQuote();
  }

  Future<void> _markBodyComplete() async {
    setState(() {
      _bodyStatus = _HomeStepStatus.completed;
    });
    await _persistDailyFlow();
    await _ensureDailyQuote();
  }

  Future<void> _markBodySkipped() async {
    setState(() {
      _bodyStatus = _HomeStepStatus.skipped;
    });
    await _persistDailyFlow();
    await _ensureDailyQuote();
  }

  Future<void> _reopenMoodCheck() async {
    setState(() {
      _moodStatus = _HomeStepStatus.pending;
      _isMoodFullscreen = false;
    });
    await _persistDailyFlow();
  }

  Future<void> _reopenBodyCheck() async {
    setState(() {
      _bodyStatus = _HomeStepStatus.pending;
      _isMoodFullscreen = false;
    });
    await _persistDailyFlow();
  }

  void _toggleMoodFullscreen() {
    setState(() {
      _isMoodFullscreen = !_isMoodFullscreen;
    });
  }

  Widget _buildMoodActionRow() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _handleMoodSkip,
            child: const Text('Skip'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _handleMoodSave,
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }

  String _pickQuoteForToday() {
    final seed =
        int.tryParse(_todayKey()) ?? DateTime.now().millisecondsSinceEpoch;
    final index = seed % _dailyAffirmations.length;
    return _dailyAffirmations[index];
  }

  Future<void> _ensureDailyQuote() async {
    if (_quoteText != null && _quoteText!.trim().isNotEmpty) return;
    final quote = _pickQuoteForToday();
    if (!mounted) return;
    setState(() {
      _quoteText = quote;
    });
    await _persistDailyFlow();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseDatabase.instance
        .ref('users/${user.uid}/daily_quotes/${_todayKey()}')
        .set({'text': quote, 'createdAt': DateTime.now().toIso8601String()});
  }

  Widget _buildAnytimeLogNote() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You can check in again anytime today.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                OutlinedButton(
                  onPressed: _reopenMoodCheck,
                  child: const Text('Mood check'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _reopenBodyCheck,
                  child: const Text('Body check'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodStep(String displayName) {
    if (_isMoodFullscreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Mood check (fullscreen)',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                tooltip: 'Exit fullscreen',
                onPressed: _toggleMoodFullscreen,
                icon: const Icon(Icons.fullscreen_exit),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: DrawingCanvas(key: _canvasKey, username: widget.displayName),
          ),
          const SizedBox(height: 12),
          _buildMoodActionRow(),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _skipToQuote,
              child: const Text('Skip to quote'),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Hi $displayName, How are you feeling today?',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton.icon(
            onPressed: _toggleMoodFullscreen,
            icon: const Icon(Icons.fullscreen),
            label: const Text('Fullscreen'),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: DrawingCanvas(key: _canvasKey, username: widget.displayName),
        ),
        const SizedBox(height: 16),
        _buildMoodActionRow(),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: _skipToQuote,
            child: const Text('Skip to quote'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteStep() {
    final quote = _quoteText ?? _pickQuoteForToday();
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Today\'s affirmation',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(
                quote,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.displayName.trim().isNotEmpty
        ? widget.displayName.trim()
        : 'there';
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget content;
    switch (_currentView) {
      case _HomeStepView.mood:
        content = _buildMoodStep(displayName);
        break;
      case _HomeStepView.body:
        content = _BodyAwarenessContent(
          onCompleted: _markBodyComplete,
          onSkipped: _markBodySkipped,
        );
        break;
      case _HomeStepView.quote:
        content = _buildQuoteStep();
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!(_currentView == _HomeStepView.mood && _isMoodFullscreen)) ...[
            _buildAnytimeLogNote(),
            const SizedBox(height: 12),
          ],
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: KeyedSubtree(key: ValueKey(_currentView), child: content),
            ),
          ),
        ],
      ),
    );
  }
}

enum _BodyTransitionChoice { continueBody, guidedMeditation, skipBody }

enum _HomeStepStatus { pending, completed, skipped }

enum _HomeStepView { mood, body, quote }
