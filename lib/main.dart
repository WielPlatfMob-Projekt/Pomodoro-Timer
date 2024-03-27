import 'package:flutter/material.dart';
import 'dart:async';

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

  void _startTimer() {
    isCountingDown = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          if (_minutes == 0) {
            if (_isBreak) {
              _minutes = 25;
              actualCycle += 1;
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
  }

  void _resetTimer() {
    _timer.cancel();

    _minutes = 25;
    _seconds = 0;
    _isBreak = false;
    actualCycle = 1;
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
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
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: _isActive ? null : _startTimer,
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: actualCycle == cycles ? null : _skipCyclePart,
                  child: Text('Skip'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
