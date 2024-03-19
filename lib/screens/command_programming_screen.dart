import 'package:flutter/material.dart';

class CommandProgrammingScreen extends StatelessWidget {
  const CommandProgrammingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Command Programming'),
      ),
      body: Center(
        child: Text(
          'This is the Command Programming Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
