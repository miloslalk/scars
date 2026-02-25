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
  bool _isAnytimeActionsExpanded = false;

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
          final l10n = AppLocalizations.of(context)!;
          return AlertDialog(
            content: Text(l10n.homeHowFeelingToday),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.startLabel),
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
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.savingLabel)));
    try {
      final result = await _canvasKey.currentState?.saveToFirebase();
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      final message = result ?? l10n.canvasNotReady;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text(message)));
      if (result == l10n.drawingSaved) {
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
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.saveFailedWithError('$error'))),
      );
    }
  }

  Future<void> _showBodyTransitionDialogIfNeeded() async {
    while (mounted && _bodyStatus == _HomeStepStatus.pending) {
      if (!context.mounted) return;
      final result = await showDialog<_BodyTransitionChoice>(
        context: context,
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          return AlertDialog(
            content: Text(l10n.bodyTransitionPrompt),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, _BodyTransitionChoice.continueBody),
                child: Text(l10n.continueLabel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  _BodyTransitionChoice.guidedMeditation,
                ),
                child: Text(l10n.guidedMeditationTitle),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, _BodyTransitionChoice.skipBody),
                child: Text(l10n.skipLabel),
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
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 560;
        if (isWide) {
          return Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _handleMoodSkip,
                  child: Text(l10n.skipLabel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleMoodSave,
                  child: Text(l10n.saveLabel),
                ),
              ),
            ],
          );
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: OutlinedButton(
                onPressed: _handleMoodSkip,
                child: Text(l10n.skipLabel),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              child: ElevatedButton(
                onPressed: _handleMoodSave,
                child: Text(l10n.saveLabel),
              ),
            ),
          ],
        );
      },
    );
  }

  String _pickQuoteForToday() {
    final l10n = AppLocalizations.of(context)!;
    final dailyAffirmations = [
      l10n.dailyAffirmation1,
      l10n.dailyAffirmation2,
      l10n.dailyAffirmation3,
      l10n.dailyAffirmation4,
      l10n.dailyAffirmation5,
      l10n.dailyAffirmation6,
      l10n.dailyAffirmation7,
    ];
    final seed =
        int.tryParse(_todayKey()) ?? DateTime.now().millisecondsSinceEpoch;
    final index = seed % dailyAffirmations.length;
    return dailyAffirmations[index];
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
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            _isAnytimeActionsExpanded = !_isAnytimeActionsExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.homeCheckAgainAnytime,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    _isAnytimeActionsExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
              if (_isAnytimeActionsExpanded) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: _reopenMoodCheck,
                      child: Text(l10n.moodCheckLabel),
                    ),
                    OutlinedButton(
                      onPressed: _reopenBodyCheck,
                      child: Text(l10n.bodyCheckLabel),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodStep(String displayName) {
    final l10n = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compactHeight = constraints.maxHeight < 360;
        final compactCanvasHeight = constraints.maxHeight < 180
            ? 120.0
            : (constraints.maxHeight * 0.55).clamp(140.0, 260.0);

        if (_isMoodFullscreen && !compactHeight) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.moodCheckFullscreenTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.exitFullscreenLabel,
                    onPressed: _toggleMoodFullscreen,
                    icon: const Icon(Icons.fullscreen_exit),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: DrawingCanvas(
                  key: _canvasKey,
                  username: widget.displayName,
                ),
              ),
              const SizedBox(height: 12),
              _buildMoodActionRow(),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skipToQuote,
                  child: Text(l10n.skipToQuoteLabel),
                ),
              ),
            ],
          );
        }

        if (compactHeight) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isMoodFullscreen
                        ? l10n.moodCheckFullscreenTitle
                        : l10n.homeGreeting(displayName),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton.icon(
                      onPressed: _toggleMoodFullscreen,
                      icon: Icon(
                        _isMoodFullscreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen,
                      ),
                      label: Text(
                        _isMoodFullscreen
                            ? l10n.exitFullscreenLabel
                            : l10n.fullscreenLabel,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: compactCanvasHeight,
                    child: DrawingCanvas(
                      key: _canvasKey,
                      username: widget.displayName,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMoodActionRow(),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _skipToQuote,
                      child: Text(l10n.skipToQuoteLabel),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.homeGreeting(displayName),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isLandscape ? 8 : 16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: _toggleMoodFullscreen,
                icon: const Icon(Icons.fullscreen),
                label: Text(l10n.fullscreenLabel),
              ),
            ),
            SizedBox(height: isLandscape ? 4 : 8),
            Expanded(
              child: DrawingCanvas(
                key: _canvasKey,
                username: widget.displayName,
              ),
            ),
            SizedBox(height: isLandscape ? 8 : 16),
            _buildMoodActionRow(),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _skipToQuote,
                child: Text(l10n.skipToQuoteLabel),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuoteStep() {
    final l10n = AppLocalizations.of(context)!;
    final quote = _quoteText ?? _pickQuoteForToday();
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.todaysAffirmationLabel,
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
    final l10n = AppLocalizations.of(context)!;
    final displayName = widget.displayName.trim().isNotEmpty
        ? widget.displayName.trim()
        : l10n.thereFallback;
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth >= 1000 ? 40.0 : 20.0;
        final verticalPadding = constraints.maxHeight >= 700 ? 24.0 : 8.0;
        final hideHeaderForFullscreenOrCompact =
            _currentView == _HomeStepView.mood && _isMoodFullscreen;
        final hideHeaderForLowHeight = constraints.maxHeight < 520;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!hideHeaderForFullscreenOrCompact &&
                  !hideHeaderForLowHeight) ...[
                _buildAnytimeLogNote(),
                const SizedBox(height: 12),
              ],
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  child: KeyedSubtree(
                    key: ValueKey(_currentView),
                    child: content,
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

enum _BodyTransitionChoice { continueBody, guidedMeditation, skipBody }

enum _HomeStepStatus { pending, completed, skipped }

enum _HomeStepView { mood, body, quote }
