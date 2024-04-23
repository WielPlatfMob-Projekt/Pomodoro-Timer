import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';

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
  int actualCycle = 1;
  bool _isBreak = false;
  bool _isActive = false;
  late Timer _timer;
  bool isCountingDown = false;

  PomodoroState currentState = PomodoroState.work;
  int _workTime = 25;
  int _shortBreakTime = 5;
  int _longBreakTime = 15;



  //svg
  final Widget svgMenu = SvgPicture.asset(
      'assets/svg/menu.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'menu button'
  );

  final Widget svgPlayR = SvgPicture.asset(
      'assets/svg/play.svg',
      width: 100,
      height: 100,
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcATop),
      semanticsLabel: 'play button'
  );

  final Widget svgPlayG = SvgPicture.asset(
      'assets/svg/play.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'play button'
  );

  final Widget svgPlayB = SvgPicture.asset(
      'assets/svg/play.svg',
      //colorFilter: const ColorFilter.mode(Color(0xFF227C9D), BlendMode.srcIn),
      semanticsLabel: 'play button'
  );

  final Widget svgQMark = SvgPicture.asset(
      'assets/svg/question_mark.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'question mark'
  );

  final Widget svgReset = SvgPicture.asset(
      'assets/svg/reset.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'reset'
  );

  final Widget svgSkip = SvgPicture.asset(
      'assets/svg/skip.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'skip'
  );

  final Widget svgStopR = SvgPicture.asset(
      'assets/svg/stop.svg',
      //colorFilter: const ColorFilter.mode(Color(0xFFCD5334), BlendMode.srcIn),
      semanticsLabel: 'stop red'
  );

  final Widget svgStopG = SvgPicture.asset(
      'assets/svg/stop.svg',
      //colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      semanticsLabel: 'stop green'
  );

  final Widget svgStopB = SvgPicture.asset(
      'assets/svg/stop.svg',
      colorFilter: const ColorFilter.mode(Color(0xFF227C9D), BlendMode.srcIn),
      semanticsLabel: 'stop blue'
  );


  //

  PomodoroState getNextState(PomodoroState currentState) {
    List<PomodoroState> values = PomodoroState.values;
    int currentIndex = values.indexOf(currentState);
    int nextIndex = (currentIndex + 1) % values.length;
    return values[nextIndex];
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
            if (_isBreak) {
              _minutes = 25;
              actualCycle += 1;
              currentState = getNextState(currentState);
              setState(() {});
            } else {
              _minutes = 5;
            }
            _isBreak = !_isBreak;

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
    _isActive = false;
    setState(() {});
  }

  void _resetTimer() {
    _isActive = false;
    _timer.cancel();

    _minutes = 25;
    _seconds = 0;
    _isBreak = false;
    actualCycle = 1;
    currentState = PomodoroState.work;
    setState(() {});
    _timer.cancel();
  }

  void _skipCyclePart(){
    _timer.cancel();

    _seconds = 0;

    if(_isBreak == true){
      _isBreak = false;
      _minutes = 25;
      actualCycle += 1;
      currentState = getNextState(currentState);
    } else {
      _isBreak = true;
      _minutes = 5;
    }
      setState(() {});
      _startTimer();

  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = _minutes < 10 ? '0$_minutes' : '$_minutes';
    String secondsStr = _seconds < 10 ? '0$_seconds' : '$_seconds';

    final Map<PomodoroState, Color> stateColors = {
      PomodoroState.work: Colors.green,
      PomodoroState.shortBreak: Colors.blue,
      PomodoroState.longBreak: Colors.purple,
    };

    return Scaffold(
      backgroundColor: stateColors[currentState],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isBreak ? 'Break Time' : 'Study Time',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              "cycle: $actualCycle",
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              '$minutesStr:$secondsStr',
              style: TextStyle(fontSize: 50.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: svgReset,
                ),
                ElevatedButton(
                  onPressed: _isActive ? _stopTimer : _startTimer,
                  child: _isActive ? svgStopR : svgPlayR,
                ),
                ElevatedButton(
                  onPressed: actualCycle == cycles ? null : _skipCyclePart,
                  child: svgSkip,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
