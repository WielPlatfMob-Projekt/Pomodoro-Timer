import 'package:flutter/material.dart';


class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // change this icon to your preferred icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('Help Screen'),
      ),
    );
  }
}
