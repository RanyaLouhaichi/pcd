import 'package:flutter/material.dart';

class MediaSharingScreen extends StatelessWidget {
  const MediaSharingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Sharing'),
      ),
      body: Center(
        child: Text(
          'This is the Media Sharing Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
