import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CareCornerPage extends StatefulWidget {
  const CareCornerPage({super.key});

  @override
  State<CareCornerPage> createState() => _CareCornerPageState();
}

class _CareCornerPageState extends State<CareCornerPage>
    with SingleTickerProviderStateMixin {
  final List<_CountryBubble> _countries = const [
    _CountryBubble('Romania', 'assets/images/flags/ro.svg'),
    _CountryBubble('Serbia', 'assets/images/flags/rs.svg'),
    _CountryBubble('Greece', 'assets/images/flags/gr.svg'),
    _CountryBubble('North Macedonia', 'assets/images/flags/mk.svg'),
    _CountryBubble('Germany', 'assets/images/flags/de.svg'),
    _CountryBubble('Turkey', 'assets/images/flags/tr.svg'),
    _CountryBubble('European Union', 'assets/images/flags/eu.svg'),
  ];

  int? _selectedIndex;
  bool _showInner = false;
  AnimationController? _controller;
  List<double> _floatPhases = const [];
  final List<double> _orbitPhases = const [0.0, 2.1, 4.2];
  List<_StarSpec> _stars = const [];
  late final Map<String, _CareCornerContent> _contentByCountry =
      _buildCareCornerContent();

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
                          tooltip: 'Back',
                          color: Colors.white,
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: _reset,
                        ),
                      ),
                    ..._buildCountryBubbles(size),
                    if (_showInner) ..._buildInnerBubbles(size),
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
      final targetOffset = _showInner && isSelected
          ? Offset.zero
          : baseOffset + Offset(dx, dy);
      final alignment = _offsetToAlignment(center + targetOffset, size);

      return AnimatedAlign(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: alignment,
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
                floatOffset: Offset.zero,
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
    return [
      _InnerBubble(
        title: 'Wellbeing',
        alignment: Alignment.center,
        offset: _orbitOffset(base + _orbitPhases[0], orbitRadius),
        onTap: () => _openSection(
          context,
          _sectionFor(country.name, _CareCornerCategory.wellbeing),
        ),
      ),
      _InnerBubble(
        title: 'Support & Services',
        alignment: Alignment.center,
        offset: _orbitOffset(base + _orbitPhases[1], orbitRadius),
        onTap: () => _openSection(
          context,
          _sectionFor(country.name, _CareCornerCategory.support),
        ),
      ),
      _InnerBubble(
        title: 'Education',
        alignment: Alignment.center,
        offset: _orbitOffset(base + _orbitPhases[2], orbitRadius),
        onTap: () => _openSection(
          context,
          _sectionFor(country.name, _CareCornerCategory.education),
        ),
      ),
    ];
  }

  Offset _orbitOffset(double angle, double radius) {
    return Offset(
      math.cos(angle) * radius,
      math.sin(angle) * radius,
    );
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
    return Alignment(
      dx.clamp(-1.0, 1.0),
      dy.clamp(-1.0, 1.0),
    );
  }

  void _openSection(BuildContext context, _CareCornerSection section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _CareCornerSectionPage(section: section),
      ),
    );
  }

  _CareCornerSection _sectionFor(
    String country,
    _CareCornerCategory category,
  ) {
    final content = _contentByCountry[country] ?? _contentByCountry.values.first;
    switch (category) {
      case _CareCornerCategory.wellbeing:
        return _CareCornerSection(
          title: 'Wellbeing',
          country: country,
          items: content.wellbeingItems,
          footer: content.wellbeingFooter,
        );
      case _CareCornerCategory.support:
        return _CareCornerSection(
          title: 'Support & Services',
          country: country,
          items: content.supportItems,
          footer: content.supportFooter,
        );
      case _CareCornerCategory.education:
        return _CareCornerSection(
          title: 'Education',
          country: country,
          items: content.educationItems,
          footer: content.educationFooter,
        );
    }
  }

  Map<String, _CareCornerContent> _buildCareCornerContent() {
    final wellbeing = [
      'Short videos about color theory',
      'Breathing exercises',
      'Guided meditation',
      'Music sessions',
      'Journaling prompts',
      'Self-care routines and mental hygiene tips',
    ];
    final support = [
      'Local NGOs and partner contacts',
      'Public & emergency services',
      'Support for youth, women, LGBTQ+, refugees, Roma',
      'Legal help and interpreter assistance',
      'Healthcare access',
    ];
    final education = [
      'What is discrimination?',
      'What is antigypsyism and racism?',
      'What are my rights?',
      'Youth and minority rights',
      'Protection, equality, inclusion, human rights',
    ];

    _CareCornerContent build(String countryLabel) {
      return _CareCornerContent(
        wellbeingItems: wellbeing,
        wellbeingFooter:
            'Search for more resources in $countryLabel if you need them.',
        supportItems: support,
        supportFooter:
            'Reach out when you need it. Support in $countryLabel is here.',
        educationItems: education,
        educationFooter:
            'Explore trusted resources in $countryLabel for deeper learning.',
      );
    }

    return {
      for (final country in _countries) country.name: build(country.name),
    };
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
            child: SvgPicture.asset(
              country.flagAsset,
              fit: BoxFit.cover,
            ),
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
                  border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
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

class _CareCornerSectionPage extends StatelessWidget {
  const _CareCornerSectionPage({required this.section});

  final _CareCornerSection section;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(section.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(section.country, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 6),
          Text(
            section.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...section.items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 8),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            section.footer,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _CountryBubble {
  const _CountryBubble(this.name, this.flagAsset);

  final String name;
  final String flagAsset;
}

class _CareCornerSection {
  const _CareCornerSection({
    required this.title,
    required this.country,
    required this.items,
    required this.footer,
  });

  final String title;
  final String country;
  final List<String> items;
  final String footer;
}

enum _CareCornerCategory { wellbeing, support, education }

class _CareCornerContent {
  const _CareCornerContent({
    required this.wellbeingItems,
    required this.wellbeingFooter,
    required this.supportItems,
    required this.supportFooter,
    required this.educationItems,
    required this.educationFooter,
  });

  final List<String> wellbeingItems;
  final String wellbeingFooter;
  final List<String> supportItems;
  final String supportFooter;
  final List<String> educationItems;
  final String educationFooter;
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
  const _StarFieldPainter({
    required this.stars,
    required this.progress,
  });

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
