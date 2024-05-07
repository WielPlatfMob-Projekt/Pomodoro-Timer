import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  final Function(int) updateWorkTime;
  final Function(int) updateShortBreakTime;
  final Function(int) updateLongBreakTime;

  int workTime = 25;
  int shortBreakTime = 5;
  int longBreakTime = 15;

  Color color = Colors.white;

  OptionScreen(
      {required this.updateWorkTime,
      required this.updateShortBreakTime,
      required this.updateLongBreakTime,
      required this.workTime,
      required this.shortBreakTime,
      required this.longBreakTime,
      required this.color});

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32,
          ), // change this icon to your preferred icon
          onPressed: () {
            widget.updateWorkTime(widget.workTime);
            widget.updateShortBreakTime(widget.shortBreakTime);
            widget.updateLongBreakTime(widget.longBreakTime);
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.workTime =
                          widget.workTime > 1 ? widget.workTime - 1 : 1;
                    });
                  },
                ),
                Text(
                  'Work Time: ${widget.workTime.toString()}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.workTime++;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.shortBreakTime = widget.shortBreakTime > 1
                          ? widget.shortBreakTime - 1
                          : 1;
                    });
                  },
                ),
                Text(
                  'Short Break Time: ${widget.shortBreakTime.toString()}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.shortBreakTime++;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.longBreakTime = widget.longBreakTime > 1
                          ? widget.longBreakTime - 1
                          : 1;
                    });
                  },
                ),
                Text(
                  'Long Break Time: ${widget.longBreakTime.toString()}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.longBreakTime++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
