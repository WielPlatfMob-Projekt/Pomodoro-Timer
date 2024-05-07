import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // change this icon to your preferred icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('Options Screen'),
      ),
    );
  }
}