import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/media_sharing_screen.dart';
import 'package:flutter_login_register_ui/screens/command_programming_screen.dart';
import 'package:flutter_login_register_ui/screens/user_profile_screen.dart';

class FirstPage extends StatelessWidget {
  final String username;
  final String email;

  const FirstPage({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Username in FirstPage: $username');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                // Implement drawer opening
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'MySmart',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {
                // Implement profile page navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      username: username,
                      email: email,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Hey, $username!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Text(
            'Welcome to MySmart',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                context,
                'Media Sharing',
                Icons.image,
                MediaSharingScreen(),
              ),
              SizedBox(width: 20),
              _buildButton(
                context,
                'Command Programming',
                Icons.code,
                CommandProgrammingScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData iconData,
      Widget nextPage,) {
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 50, color: Colors.black),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
