import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/option_screen.dart';

void main() {
  testWidgets('Option Screen work time increment and decrement test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: OptionScreen(
      updateWorkTime: (int newTime) {},
      updateShortBreakTime: (int newTime) {},
      updateLongBreakTime: (int newTime) {},
      workTime: 25,
      shortBreakTime: 5,
      longBreakTime: 15,
      color: Colors.white,
    )));

    // Test for 'Work Time'
    await tester.tap(find.text('+').first);
    await tester.pump();
    expect(find.text('Work Time: 26'), findsOneWidget);

    await tester.tap(find.text('-').first);
    await tester.pump();
    expect(find.text('Work Time: 25'), findsOneWidget);

    // Test for 'Short Break Time'
    await tester.tap(find.text('+').at(1));
    await tester.pump();
    expect(find.text('Short Break Time: 6'), findsOneWidget);

    await tester.tap(find.text('-').at(1));
    await tester.pump();
    expect(find.text('Short Break Time: 5'), findsOneWidget);

    // Test for 'Long Break Time'
    await tester.tap(find.text('+').last);
    await tester.pump();
    expect(find.text('Long Break Time: 16'), findsOneWidget);

    await tester.tap(find.text('-').last);
    await tester.pump();
    expect(find.text('Long Break Time: 15'), findsOneWidget);
  });
}
