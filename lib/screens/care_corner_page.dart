import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/models/care_corner_data.dart';
import 'package:when_scars_become_art/screens/care_corner/education_page.dart';
import 'package:when_scars_become_art/screens/care_corner/support_page.dart';
import 'package:when_scars_become_art/screens/care_corner/wellbeing_page.dart';
import 'package:when_scars_become_art/services/care_corner_service.dart';

class CareCornerPage extends StatefulWidget {
  const CareCornerPage({super.key});

  @override
  State<CareCornerPage> createState() => _CareCornerPageState();
}

class _CareCornerPageState extends State<CareCornerPage>
    with SingleTickerProviderStateMixin {
  final List<_CountryBubble> _countries = const [
    _CountryBubble('ro', 'assets/images/flags/ro.svg'),
    _CountryBubble('rs', 'assets/images/flags/rs.svg'),
    _CountryBubble('gr', 'assets/images/flags/gr.svg'),
    _CountryBubble('mk', 'assets/images/flags/mk.svg'),
    _CountryBubble('de', 'assets/images/flags/de.svg'),
    _CountryBubble('tr', 'assets/images/flags/tr.svg'),
    _CountryBubble('eu', 'assets/images/flags/eu.svg'),
  ];

  int? _selectedIndex;
  bool _showInner = false;
  bool _openingCategory = false;
  AnimationController? _controller;
  List<double> _floatPhases = const [];
  final List<double> _orbitPhases = const [0.0, 2.1, 4.2];
  List<_StarSpec> _stars = const [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
    _ensureAnimationState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _selectCountry(int index) {
    setState(() {
      _selectedIndex = index;
      _showInner = true;
    });
  }

  void _reset() {
    setState(() {
      _showInner = false;
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? const [Color(0xFF2E2940), Color(0xFF1A1624)]
        : const [Color(0xFF745CA3), Color(0xFFBBA6D6)];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: background,
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            _ensureAnimationState();
            return AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _StarFieldPainter(
                          stars: _stars,
                          progress: _controller!.value,
                        ),
                      ),
                    ),
                    if (_showInner)
                      Positioned(
                        top: 12,
                        left: 8,
                        child: IconButton(
                          tooltip: l10n.showBackLabel,
                          color: Colors.white,
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: _reset,
                        ),
                      ),
                    ..._buildCountryBubbles(size),
                    if (_showInner) ..._buildInnerBubbles(size),
                    if (_showInner &&
                        _selectedIndex != null &&
                        _countries[_selectedIndex!].id == 'eu')
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            l10n.careCornerEuNationalPrompt,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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

  List<Widget> _buildCountryBubbles(Size size) {
    final floatProgress = (_controller?.value ?? 0.0) * 2 * math.pi;
    final phases = _floatPhases.isEmpty
        ? List<double>.filled(_countries.length, 0.0)
        : _floatPhases;
    final radius = size.shortestSide * 0.56;
    final center = Offset(size.width / 2, size.height / 2);
    return List.generate(_countries.length, (index) {
      final country = _countries[index];
      final isSelected = _selectedIndex == index;
      final angleStep = (2 * math.pi) / _countries.length;
      final angle = angleStep * index - (math.pi / 2);
      final baseOffset = Offset(
        math.cos(angle) * radius,
        math.sin(angle) * radius,
      );
      final opacity = !_showInner || isSelected ? 1.0 : 0.0;
      final scale = _showInner && !isSelected ? 0.7 : 1.0;
      final phase = phases[index];
      final dy = math.sin(floatProgress + phase) * 6;
      final dx = math.cos(floatProgress + phase) * 6;
      final baseAlignment = _offsetToAlignment(
        center + (_showInner && isSelected ? Offset.zero : baseOffset),
        size,
      );
      final floatOffset = _showInner && isSelected
          ? Offset.zero
          : Offset(dx, dy);

      return AnimatedAlign(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: baseAlignment,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 400),
            scale: scale,
            child: IgnorePointer(
              ignoring: _showInner,
              child: _CountryBubbleView(
                country: country,
                onTap: _showInner ? null : () => _selectCountry(index),
                floatOffset: floatOffset,
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildInnerBubbles(Size size) {
    final orbitRadius = size.shortestSide * 0.33;
    final base = (_controller?.value ?? 0.0) * 2 * math.pi;
    final country = _selectedIndex == null
        ? _countries.first
        : _countries[_selectedIndex!];
    final l10n = lookupAppLocalizations(_countryLocale(country.id));
    return [
      _InnerBubble(
        title: l10n.careCornerWellbeingTitle,
        alignment: Alignment.center,
        offset: _orbitOffset(base + _orbitPhases[0], orbitRadius),
        onTap: () => _openCategory(country.id, 'wellbeing'),
      ),
      _InnerBubble(
        title: l10n.careCornerSupportTitle,
        alignment: Alignment.center,
        offset: _orbitOffset(base + _orbitPhases[1], orbitRadius),
        onTap: () => _openCategory(country.id, 'support'),
      ),
      _InnerBubble(
        title: l10n.careCornerEducationTitle,
        alignment: Alignment.center,
        offset: _orbitOffset(base + _orbitPhases[2], orbitRadius),
        onTap: () => _openCategory(country.id, 'education'),
      ),
    ];
  }

  Offset _orbitOffset(double angle, double radius) {
    return Offset(math.cos(angle) * radius, math.sin(angle) * radius);
  }

  void _ensureAnimationState() {
    _controller ??= AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
    if (_floatPhases.isEmpty) {
      _floatPhases = List<double>.generate(
        _countries.length,
        (index) => (index + 1) * 0.7,
      );
    }
    if (_stars.isEmpty) {
      _stars = _buildStars();
    }
  }

  List<_StarSpec> _buildStars() {
    final random = math.Random(7);
    return List<_StarSpec>.generate(
      36,
      (index) => _StarSpec(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: 1.5 + random.nextDouble() * 2.5,
        phase: random.nextDouble() * 2 * math.pi,
      ),
    );
  }

  Alignment _offsetToAlignment(Offset point, Size size) {
    final dx = (point.dx / size.width) * 2 - 1;
    final dy = (point.dy / size.height) * 2 - 1;
    return Alignment(dx.clamp(-1.0, 1.0), dy.clamp(-1.0, 1.0));
  }

  Future<void> _openCategory(String countryId, String category) async {
    // Double-tap during the awaited load would push the page twice.
    if (_openingCategory) return;
    _openingCategory = true;
    final CareCornerCountryData data;
    try {
      data = await CareCornerService.instance.loadCountry(countryId);
    } catch (_) {
      _openingCategory = false;
      // A missing/malformed country JSON must not turn the tap into a
      // silent no-op (EU data is still pending, so this path is real).
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.genericLoadFailed)));
      return;
    }
    _openingCategory = false;

    if (data.isRedirectOnly) return;
    if (!mounted) return;

    final locale = _countryLocale(countryId);
    final countryL10n = lookupAppLocalizations(locale);
    final countryLabel = _countryLabel(countryId, countryL10n);

    Widget? page;
    switch (category) {
      case 'wellbeing':
        if (data.wellbeing != null) {
          page = WellbeingPage(
            wellbeing: data.wellbeing!,
            country: countryLabel,
            countryLocale: locale,
          );
        }
      case 'support':
        if (data.support != null) {
          page = SupportPage(
            support: data.support!,
            country: countryLabel,
            countryLocale: locale,
          );
        }
      case 'education':
        if (data.education != null) {
          page = EducationPage(
            education: data.education!,
            country: countryLabel,
            countryLocale: locale,
          );
        }
    }

    if (page != null && mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
    } else if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.careCornerNotAvailableMessage)),
      );
    }
  }

  static Locale _countryLocale(String countryId) {
    switch (countryId) {
      case 'ro':
        return const Locale('ro');
      case 'rs':
        return const Locale('sr');
      case 'gr':
        return const Locale('el');
      case 'mk':
        return const Locale('mk');
      case 'de':
        return const Locale('de');
      case 'tr':
        return const Locale('tr');
      default:
        return const Locale('en');
    }
  }

  String _countryLabel(String countryId, AppLocalizations l10n) {
    switch (countryId) {
      case 'ro':
        return l10n.careCornerCountryRomania;
      case 'rs':
        return l10n.careCornerCountrySerbia;
      case 'gr':
        return l10n.careCornerCountryGreece;
      case 'mk':
        return l10n.careCornerCountryNorthMacedonia;
      case 'de':
        return l10n.careCornerCountryGermany;
      case 'tr':
        return l10n.careCornerCountryTurkey;
      case 'eu':
        return l10n.careCornerCountryEuropeanUnion;
    }
    return countryId;
  }
}

class _CountryBubbleView extends StatelessWidget {
  const _CountryBubbleView({
    required this.country,
    required this.onTap,
    required this.floatOffset,
  });

  final _CountryBubble country;
  final VoidCallback? onTap;
  final Offset floatOffset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.translate(
        offset: floatOffset,
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipOval(
            child: SvgPicture.asset(country.flagAsset, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class _InnerBubble extends StatelessWidget {
  const _InnerBubble({
    required this.title,
    required this.alignment,
    required this.offset,
    required this.onTap,
  });

  final String title;
  final Alignment alignment;
  final Offset offset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      alignment: alignment,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        scale: 1.0,
        child: Transform.translate(
          offset: offset,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryBubble {
  const _CountryBubble(this.id, this.flagAsset);

  final String id;
  final String flagAsset;
}

class _StarSpec {
  const _StarSpec({
    required this.x,
    required this.y,
    required this.radius,
    required this.phase,
  });

  final double x;
  final double y;
  final double radius;
  final double phase;
}

class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter({required this.stars, required this.progress});

  final List<_StarSpec> stars;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final base = progress * 2 * math.pi;
    for (final star in stars) {
      final twinkle = (math.sin(base + star.phase) + 1) / 2;
      final opacity = 0.2 + twinkle * 0.6;
      final paint = Paint()..color = Colors.white.withValues(alpha: opacity);
      final dx = star.x * size.width;
      final dy = star.y * size.height;
      canvas.drawCircle(Offset(dx, dy), star.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.stars != stars;
  }
}
