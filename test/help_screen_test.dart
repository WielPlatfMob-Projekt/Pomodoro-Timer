import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/help_screen.dart';

void main() {
  testWidgets('Help Screen navigation works', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HelpScreen(color: Colors.white),
    ));
    expect(find.byType(HelpScreen), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.byType(HelpScreen), findsNothing);
  });

  testWidgets('HelpScreen texts display test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HelpScreen(color: Colors.white)));
    expect(find.text('What is pomodoro?'), findsOneWidget);
    expect(
        find.text(
            'The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. The technique uses a timer to break down work into intervals, traditionally 25 minutes in length, separated by short breaks.'),
        findsOneWidget);
  });
}
