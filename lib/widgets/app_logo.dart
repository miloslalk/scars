import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 64});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/images/logo_horizontal.png',
          height: height * 0.9,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
