import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:pomodoro_timer/help_screen.dart';
import 'package:pomodoro_timer/option_screen.dart';

enum PomodoroState {
  work,
  shortBreak,
  longBreak,
}

void main() => runApp(PomodoroApp());

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: PomodoroTimer(),
    );
  }
}

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _minutes = 25;
  int _seconds = 0;
  int cycles = 4;
  bool _isActive = false;
  late Timer _timer;
  bool isCountingDown = false;

  PomodoroState currentState = PomodoroState.work;
  int _workTime = 25;
  int _shortBreakTime = 5;
  int _longBreakTime = 15;

  void _updateWorkTime(int newTime) {
    print('Updating work time to $newTime');
    setState(() {
      _workTime = newTime;
      sessionTime[PomodoroState.work] = newTime;
    });
  }

  void _updateShortBreakTime(int newTime) {
    print('Updating short break time to $newTime');
    setState(() {
      _shortBreakTime = newTime;
      sessionTime[PomodoroState.shortBreak] = newTime;
    });
  }

  void _updateLongBreakTime(int newTime) {
    print('Updating long break time to $newTime');
    setState(() {
      _longBreakTime = newTime;
      sessionTime[PomodoroState.longBreak] = newTime;
    });
  }

  static const double padding = 30;
  static const double icon_size = 50;

  static const Color workColor = Color(0xFFCD5334);
  static const Color sbreakColor = Color(0xFF1D7235);
  static const Color lbreakColor = Color(0xFF227C9D);

  //svg
  final Widget svgMenu = SvgPicture.asset('assets/svg/menu.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'menu button');

  final Widget svgPlayR = Container(
      padding: const EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset('assets/svg/play.svg',
          width: icon_size,
          height: icon_size,
          colorFilter: const ColorFilter.mode(workColor, BlendMode.srcATop),
          semanticsLabel: 'play button'));

  final Widget svgPlayG = Container(
      padding: const EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset('assets/svg/play.svg',
          width: icon_size,
          height: icon_size,
          colorFilter: const ColorFilter.mode(sbreakColor, BlendMode.srcIn),
          semanticsLabel: 'play button'));

  final Widget svgPlayB = Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset('assets/svg/play.svg',
          width: icon_size,
          height: icon_size,
          colorFilter: const ColorFilter.mode(lbreakColor, BlendMode.srcIn),
          semanticsLabel: 'play button'));

  final Widget svgQMark = SvgPicture.asset('assets/svg/question_mark.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'question mark');

  final Widget svgReset = SvgPicture.asset('assets/svg/reset.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'reset');

  final Widget svgSkip = SvgPicture.asset('assets/svg/skip.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'skip');

  final Widget svgStopR = Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset('assets/svg/stop.svg',
          width: icon_size,
          height: icon_size,
          colorFilter: const ColorFilter.mode(workColor, BlendMode.srcIn),
          semanticsLabel: 'stop red'));

  final Widget svgStopG = Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset('assets/svg/stop.svg',
          width: icon_size,
          height: icon_size,
          colorFilter: const ColorFilter.mode(sbreakColor, BlendMode.srcIn),
          semanticsLabel: 'stop green'));

  final Widget svgStopB = Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset('assets/svg/stop.svg',
          width: icon_size,
          height: icon_size,
          colorFilter: const ColorFilter.mode(lbreakColor, BlendMode.srcIn),
          semanticsLabel: 'stop blue'));

  //

  List<PomodoroState> stateCycle = [
    PomodoroState.work,
    PomodoroState.shortBreak,
    PomodoroState.work,
    PomodoroState.longBreak,
  ];

  late Map<PomodoroState, int> sessionTime = {
    PomodoroState.work: _workTime,
    PomodoroState.shortBreak: _shortBreakTime,
    PomodoroState.longBreak: _longBreakTime,
  };

  int cycleIndex = 0;

  PomodoroState getNextState() {
    cycleIndex = (cycleIndex + 1) % stateCycle.length;
    return stateCycle[cycleIndex];
  }

  resetState() {
    cycleIndex = 0;
  }

  //

  void _startTimer() {
    setState(() {
      _isActive = true;
    });
    isCountingDown = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          if (_minutes == 0) {
            _seconds = 0;
            currentState = getNextState();
            _minutes = sessionTime[currentState]!;
            setState(() {});
            return;
          } else {
            _minutes -= 1;
          }
          _seconds = 59;
        } else {
          _seconds -= 1;
        }
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _isActive = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _isActive = false;
      _timer.cancel();

      _seconds = 0;
      currentState = PomodoroState.work;
      _minutes = sessionTime[currentState]!;
      resetState();

      _timer.cancel();
    });
  }

  void _skipCyclePart() {
    _timer.cancel();

    setState(() {
      currentState = getNextState();
      _seconds = 0;
      _minutes = sessionTime[currentState]!;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = _minutes < 10 ? '0$_minutes' : '$_minutes';
    String secondsStr = _seconds < 10 ? '0$_seconds' : '$_seconds';

    final Map<PomodoroState, Color> stateColors = {
      PomodoroState.work: workColor,
      PomodoroState.shortBreak: sbreakColor,
      PomodoroState.longBreak: lbreakColor,
    };

    final Map<PomodoroState, Widget> svgPlay = {
      PomodoroState.work: svgPlayR,
      PomodoroState.shortBreak: svgPlayG,
      PomodoroState.longBreak: svgPlayB
    };

    final Map<PomodoroState, Widget> svgStop = {
      PomodoroState.work: svgStopR,
      PomodoroState.shortBreak: svgStopG,
      PomodoroState.longBreak: svgStopB,
    };

    final Map<PomodoroState, String> sessionText = {
      PomodoroState.work: 'Work Time',
      PomodoroState.shortBreak: 'Short Break',
      PomodoroState.longBreak: 'Long Break',
    };

    ButtonStyle transparentButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    return Stack(children: <Widget>[
      Scaffold(
        backgroundColor: stateColors[currentState],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 250.0, // adjust the size as needed
                    height: 250.0, // adjust the size as needed
                    child: CircularProgressIndicator(
                      value: ((_minutes * 60 + _seconds) /
                          (sessionTime[currentState]! * 60)),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.white.withOpacity(0.2),
                      strokeWidth: 5.0,
                    ),
                  ),
                  Text(
                    '$minutesStr:$secondsStr' '',
                    style: TextStyle(fontSize: 82.0, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                sessionText[currentState]!,
                style: TextStyle(fontSize: 32.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(
                    4,
                    (index) => Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        color: index < cycleIndex + 1
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 150.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _resetTimer,
                    style: transparentButtonStyle.copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors
                              .transparent; // Use transparent color for all states
                        },
                      ),
                    ),
                    child: svgReset,
                  ),
                  ElevatedButton(
                    onPressed: _isActive ? _stopTimer : _startTimer,
                    style: transparentButtonStyle.copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors
                              .transparent; // Use transparent color for all states
                        },
                      ),
                    ),
                    child: _isActive
                        ? svgStop[currentState]
                        : svgPlay[currentState],
                  ),
                  ElevatedButton(
                    onPressed: _skipCyclePart,
                    style: transparentButtonStyle.copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors
                              .transparent; // Use transparent color for all states
                        },
                      ),
                    ),
                    child: svgSkip,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: AppBar(
          leading: IconButton(
            icon: svgMenu,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OptionScreen(
                          updateWorkTime: _updateWorkTime,
                          updateShortBreakTime: _updateShortBreakTime,
                          updateLongBreakTime: _updateLongBreakTime,
                          workTime: _workTime,
                          shortBreakTime: _shortBreakTime,
                          longBreakTime: _longBreakTime,
                          color: stateColors[currentState]!,
                        )),
              );
              setState(() {});
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: svgQMark,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen(color: stateColors[currentState]!)),
                );
                setState(() {});
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    ]);
  }
}
