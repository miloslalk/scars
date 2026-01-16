import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 64});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Image.asset(
          'assets/images/logo_horizontal.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
