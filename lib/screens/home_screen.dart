import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/widgets/app_banner.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Custom color
  static const customBgColor = Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customBgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 27.0,
            ),
            child: Text('',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'GeneralSans',
                  fontWeight: FontWeight.w500,
                )),
          ),
          elevation: 0.0,
          centerTitle: false,
        ),
        body: Column(
          children: const <Widget>[
            AppBanner(),
          ],
        ));
  }
}
