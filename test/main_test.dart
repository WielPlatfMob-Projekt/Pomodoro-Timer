import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomodoro_timer/main.dart';
import 'package:pomodoro_timer/help_screen.dart';


    // Fetch the current state of PomodoroTimer
    import 'package:pomodoro_timer/main.dart';

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

    // Ensure the timer is initially inactive
    expect(timerState._isActive, isFalse);

    // Tap the play button and verify the timer starts
    await tester.tap(find.byWidget(timerState.svgPlayR));
    await tester.pumpAndSettle();
    expect(timerState._isActive, isTrue);

    // Tap the stop button and verify the timer stops
    await tester.tap(find.byWidget(timerState.svgStopR));
    await tester.pumpAndSettle();
    expect(timerState._isActive, isFalse);

    tester.binding.window.clearPhysicalSizeTestValue();
  });

  testWidgets('Timer reset functionality test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(PomodoroApp());

    // Fetch the current state of PomodoroTimer
    final PomodoroTimerState timerState =
        tester.state(find.byType(PomodoroTimer));

    // Tap the play button to start the timer
    await tester.tap(find.byWidget(timerState.svgPlayR));
    await tester.pumpAndSettle();
    expect(timerState._isActive, isTrue);

    // Tap the reset button to reset the timer
    await tester.tap(find.byWidget(timerState.svgReset));
    await tester.pumpAndSettle();

    // Ensure the timer is inactive and reset to the initial time
    expect(timerState._isActive, isFalse);
    expect(timerState._minutes, 25);
    expect(timerState._seconds, 0);

    tester.binding.window.clearPhysicalSizeTestValue();
  });

  testWidgets('Help screen opens test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(PomodoroApp());

    // Tap the help icon button to navigate to the help screen
    await tester.tap(find.byIcon(Icons.help_outline));  // Assuming help icon button has an Icon widget
    await tester.pumpAndSettle();
    expect(find.byType(HelpScreen), findsOneWidget);

    tester.binding.window.clearPhysicalSizeTestValue();
  });
}
