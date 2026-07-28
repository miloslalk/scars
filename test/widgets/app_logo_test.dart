import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:when_scars_become_art/widgets/app_logo.dart';

void main() {
  testWidgets('AppLogo renders its image', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppLogo())));
    expect(find.byType(Image), findsOneWidget);
  });
}
