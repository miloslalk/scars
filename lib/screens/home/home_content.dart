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
  bool _isLoading = true;
  bool _hasShownDailyPrompt = false;
  bool _isPromptDialogOpen = false;
  _HomeStepStatus _moodStatus = _HomeStepStatus.pending;
  _HomeStepStatus _bodyStatus = _HomeStepStatus.pending;
  bool _isMoodFullscreen = false;
  bool _isAnytimeActionsExpanded = false;
  String? _quoteText;
  bool _isLoadingQuote = false;

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
      final flowSnap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/daily_flow/$key')
          .get();

      var bodyStatus = _HomeStepStatus.pending;
      var hasPrompt = false;

      if (flowSnap.exists && flowSnap.value is Map) {
        final map = Map<String, dynamic>.from(flowSnap.value as Map);
        bodyStatus = _statusFromValue(map['bodyStatus']);
        hasPrompt = map['moodPromptShownAt'] != null;
      }

      if (!mounted) return;
      // Always start on the drawing canvas (mood step) when the app opens,
      // regardless of whether it was completed earlier today.
      setState(() {
        _bodyStatus = bodyStatus;
        _hasShownDailyPrompt = hasPrompt;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }

    _showDailyPromptIfNeeded();
  }

  Future<void> _persistDailyFlow() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final now = DateTime.now().toIso8601String();
    final data = <String, dynamic>{
      'moodStatus': _statusToValue(_moodStatus),
      'bodyStatus': _statusToValue(_bodyStatus),
      'updatedAt': now,
    };
    if (_hasShownDailyPrompt) {
      data['moodPromptShownAt'] = now;
    }
    await FirebaseDatabase.instance
        .ref('users/${user.uid}/daily_flow/${_todayKey()}')
        .update(data);
  }

  Future<void> _showDailyPromptIfNeeded() async {
    if (!mounted || _hasShownDailyPrompt || _isPromptDialogOpen) return;
    _isPromptDialogOpen = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _hasShownDailyPrompt) {
        _isPromptDialogOpen = false;
        return;
      }
      // Play the monster "Hello" video instead of a plain dialog.
      try {
        const helloKey = '01_hello';
        final plan = MonsterManifestService.instance.resolvePlaybackPlan(
          helloKey,
          platform: Theme.of(context).platform,
        );
        if (!mounted) {
          _isPromptDialogOpen = false;
          return;
        }
        if (plan != null) {
          final paths = _pathsFromPlan(plan);
          if (!mounted) {
            _isPromptDialogOpen = false;
            return;
          }
          await Navigator.of(context, rootNavigator: true).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 600),
              reverseTransitionDuration: const Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  _MonsterPlaybackPage(
                    activityKey: helloKey,
                    plan: plan,
                    urls: paths,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          );
        }
      } catch (_) {
        // Monster hello playback error — ignore silently
      }
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

  _MonsterPlaybackUrls _pathsFromPlan(MonsterPlaybackPlan plan) {
    if (plan.type == MonsterPlaybackType.single) {
      return _MonsterPlaybackUrls(single: plan.singlePath);
    }
    return _MonsterPlaybackUrls(
      intro: plan.introPath,
      loop: plan.loopPath,
      outro: plan.outroPath,
    );
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
    if (!mounted || _bodyStatus != _HomeStepStatus.pending) return;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          content: Text(l10n.bodyTransitionPrompt),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.noLabel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.yesLabel),
            ),
          ],
        );
      },
    );
    if (!mounted || result == null) return;
    if (result) {
      // Yes → guided meditation, then body map still shows
      await _openGuidedMeditation();
      // Body map will show next via _currentView returning body
      return;
    }
    // No → skip body step
    setState(() {
      _bodyStatus = _HomeStepStatus.skipped;
    });
    await _persistDailyFlow();
  }

  Future<void> _openGuidedMeditation() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicPlayerPage(
          localeCode: Localizations.localeOf(context).languageCode,
          fallbackAssetPath: 'music/keys-of-moon-white-petals(chosic.com).mp3',
        ),
      ),
    );
  }

  Future<void> _markBodyComplete() async {
    setState(() {
      _bodyStatus = _HomeStepStatus.completed;
    });
    await _persistDailyFlow();
  }

  Future<void> _markBodySkipped() async {
    setState(() {
      _bodyStatus = _HomeStepStatus.skipped;
    });
    await _persistDailyFlow();
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
      if (_moodStatus == _HomeStepStatus.pending) {
        _moodStatus = _HomeStepStatus.skipped;
      }
      _isMoodFullscreen = false;
    });
    await _persistDailyFlow();
  }

  Future<void> _loadOrPickQuote() async {
    if (_isLoadingQuote || _quoteText != null) return;
    _isLoadingQuote = true;

    final user = FirebaseAuth.instance.currentUser;
    final locale = Localizations.localeOf(context).languageCode;
    if (user == null) {
      _pickLocalAffirmation();
      return;
    }

    final key = _todayKey();
    try {
      // Check if a quote was already saved today.
      final savedSnap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/daily_quotes/$key')
          .get();
      if (savedSnap.exists && savedSnap.value is Map) {
        final map = Map<String, dynamic>.from(savedSnap.value as Map);
        final text = map['text'] as String?;
        if (text != null && text.trim().isNotEmpty) {
          if (!mounted) return;
          setState(() {
            _quoteText = text.trim();
            _isLoadingQuote = false;
          });
          return;
        }
      }

      // Try loading from Firebase quotes collection.
      var quotesSnap = await FirebaseDatabase.instance
          .ref('quotes/$locale')
          .get();
      if (!quotesSnap.exists) {
        quotesSnap = await FirebaseDatabase.instance.ref('quotes/en').get();
      }

      String? picked;
      if (quotesSnap.exists && quotesSnap.value is List) {
        final list = List<String>.from(
          (quotesSnap.value as List).whereType<String>(),
        );
        if (list.isNotEmpty) {
          list.shuffle();
          picked = list.first;
        }
      } else if (quotesSnap.exists && quotesSnap.value is Map) {
        final map = Map<String, dynamic>.from(quotesSnap.value as Map);
        final values = map.values.whereType<String>().toList();
        if (values.isNotEmpty) {
          values.shuffle();
          picked = values.first;
        }
      }

      // Fallback to built-in affirmations if Firebase has no quotes.
      picked ??= _randomLocalAffirmation();

      // Save to user's daily quotes.
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/daily_quotes/$key')
          .set({'text': picked, 'savedAt': DateTime.now().toIso8601String()});

      if (!mounted) return;
      setState(() {
        _quoteText = picked;
        _isLoadingQuote = false;
      });
    } catch (_) {
      _pickLocalAffirmation();
    }
  }

  String _randomLocalAffirmation() {
    final l10n = AppLocalizations.of(context)!;
    final affirmations = [
      l10n.dailyAffirmation1,
      l10n.dailyAffirmation2,
      l10n.dailyAffirmation3,
      l10n.dailyAffirmation4,
      l10n.dailyAffirmation5,
      l10n.dailyAffirmation6,
      l10n.dailyAffirmation7,
      l10n.dailyAffirmation8,
      l10n.dailyAffirmation9,
      l10n.dailyAffirmation10,
      l10n.dailyAffirmation11,
      l10n.dailyAffirmation12,
      l10n.dailyAffirmation13,
      l10n.dailyAffirmation14,
      l10n.dailyAffirmation15,
      l10n.dailyAffirmation16,
      l10n.dailyAffirmation17,
      l10n.dailyAffirmation18,
      l10n.dailyAffirmation19,
      l10n.dailyAffirmation20,
      l10n.dailyAffirmation21,
      l10n.dailyAffirmation22,
      l10n.dailyAffirmation23,
      l10n.dailyAffirmation24,
      l10n.dailyAffirmation25,
      l10n.dailyAffirmation26,
      l10n.dailyAffirmation27,
      l10n.dailyAffirmation28,
      l10n.dailyAffirmation29,
      l10n.dailyAffirmation30,
      l10n.dailyAffirmation31,
      l10n.dailyAffirmation32,
      l10n.dailyAffirmation33,
      l10n.dailyAffirmation34,
      l10n.dailyAffirmation35,
      l10n.dailyAffirmation36,
      l10n.dailyAffirmation37,
      l10n.dailyAffirmation38,
      l10n.dailyAffirmation39,
      l10n.dailyAffirmation40,
      l10n.dailyAffirmation41,
      l10n.dailyAffirmation42,
      l10n.dailyAffirmation43,
      l10n.dailyAffirmation44,
      l10n.dailyAffirmation45,
      l10n.dailyAffirmation46,
      l10n.dailyAffirmation47,
      l10n.dailyAffirmation48,
      l10n.dailyAffirmation49,
      l10n.dailyAffirmation50,
      l10n.dailyAffirmation51,
      l10n.dailyAffirmation52,
      l10n.dailyAffirmation53,
      l10n.dailyAffirmation54,
      l10n.dailyAffirmation55,
      l10n.dailyAffirmation56,
      l10n.dailyAffirmation57,
      l10n.dailyAffirmation58,
      l10n.dailyAffirmation59,
      l10n.dailyAffirmation60,
      l10n.dailyAffirmation61,
      l10n.dailyAffirmation62,
      l10n.dailyAffirmation63,
      l10n.dailyAffirmation64,
      l10n.dailyAffirmation65,
      l10n.dailyAffirmation66,
      l10n.dailyAffirmation67,
      l10n.dailyAffirmation68,
      l10n.dailyAffirmation69,
      l10n.dailyAffirmation70,
      l10n.dailyAffirmation71,
      l10n.dailyAffirmation72,
      l10n.dailyAffirmation73,
      l10n.dailyAffirmation74,
      l10n.dailyAffirmation75,
      l10n.dailyAffirmation76,
      l10n.dailyAffirmation77,
      l10n.dailyAffirmation78,
      l10n.dailyAffirmation79,
      l10n.dailyAffirmation80,
      l10n.dailyAffirmation81,
      l10n.dailyAffirmation82,
      l10n.dailyAffirmation83,
      l10n.dailyAffirmation84,
      l10n.dailyAffirmation85,
      l10n.dailyAffirmation86,
      l10n.dailyAffirmation87,
      l10n.dailyAffirmation88,
      l10n.dailyAffirmation89,
      l10n.dailyAffirmation90,
      l10n.dailyAffirmation91,
      l10n.dailyAffirmation92,
      l10n.dailyAffirmation93,
      l10n.dailyAffirmation94,
      l10n.dailyAffirmation95,
      l10n.dailyAffirmation96,
      l10n.dailyAffirmation97,
      l10n.dailyAffirmation98,
      l10n.dailyAffirmation99,
      l10n.dailyAffirmation100,
      l10n.dailyAffirmation101,
      l10n.dailyAffirmation102,
      l10n.dailyAffirmation103,
      l10n.dailyAffirmation104,
      l10n.dailyAffirmation105,
      l10n.dailyAffirmation106,
      l10n.dailyAffirmation107,
      l10n.dailyAffirmation108,
      l10n.dailyAffirmation109,
      l10n.dailyAffirmation110,
      l10n.dailyAffirmation111,
      l10n.dailyAffirmation112,
      l10n.dailyAffirmation113,
      l10n.dailyAffirmation114,
      l10n.dailyAffirmation115,
      l10n.dailyAffirmation116,
      l10n.dailyAffirmation117,
      l10n.dailyAffirmation118,
      l10n.dailyAffirmation119,
      l10n.dailyAffirmation120,
    ];
    affirmations.shuffle();
    return affirmations.first;
  }

  void _pickLocalAffirmation() {
    if (!mounted) return;
    setState(() {
      _quoteText = _randomLocalAffirmation();
      _isLoadingQuote = false;
    });
  }

  Widget _buildQuoteStep() {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoadingQuote || _quoteText == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.todaysAffirmationLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Text(
                  _quoteText!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: 'PlaypenSans',
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                    OutlinedButton(
                      onPressed: _openGuidedMeditation,
                      child: Text(l10n.meditationLabel),
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
          ],
        );
      },
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
        _loadOrPickQuote();
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

enum _HomeStepStatus { pending, completed, skipped }

enum _HomeStepView { mood, body, quote }
