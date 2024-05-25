import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomodoro_timer/main.dart';
import 'package:pomodoro_timer/help_screen.dart';

void main() {
  testWidgets('PomodoroApp should run', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(PomodoroApp());
    expect(find.byType(PomodoroApp), findsOneWidget);

    tester.binding.window.clearPhysicalSizeTestValue();
  });

  testWidgets('Timer start and stop test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(PomodoroApp());

    final PomodoroTimerState timerState =
        tester.state(find.byType(PomodoroTimer));
    expect(timerState.isActive, isFalse);

    await tester.tap(find.byWidget(timerState.svgPlayR));
    await tester.pumpAndSettle();
    expect(timerState.isActive, isTrue);

    await tester.tap(find.byWidget(timerState.svgStopR));
    await tester.pumpAndSettle();
    expect(timerState.isActive, isFalse);

    tester.binding.window.clearPhysicalSizeTestValue();
  });

  testWidgets('Timer reset functionality test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(PomodoroApp());

    final PomodoroTimerState timerState =
        tester.state(find.byType(PomodoroTimer));
    await tester.tap(find.byWidget(timerState.svgPlayR));
    await tester.pumpAndSettle();
    expect(timerState.isActive, isTrue);

    await tester.tap(find.byWidget(timerState.svgReset));
    await tester.pumpAndSettle();

    expect(timerState.isActive, isFalse);
    expect(timerState.minutes, 25);
    expect(timerState.seconds, 0);

    tester.binding.window.clearPhysicalSizeTestValue();
  });

  testWidgets('Help screen opens test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(PomodoroApp());

    await tester.tap(find.byType(IconButton).last);
    await tester.pumpAndSettle();
    expect(find.byType(HelpScreen), findsOneWidget);

    tester.binding.window.clearPhysicalSizeTestValue();
  });
}
