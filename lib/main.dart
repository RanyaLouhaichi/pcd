import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCw4FYqVPVCzvEFFiHIcFeByFKpJk1rVU0", appId: "1:281780973054:web:59c70a5c9832d0b4f3a4af", messagingSenderId: "281780973054", projectId: "mysmart-a4f78"));
  }
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Custom color
  static const primaryColor = Color.fromARGB(255, 27, 42, 74);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Stoman',
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'GeneralSans',
      ),
      home: const HomeScreen(),
    );
  }
}
