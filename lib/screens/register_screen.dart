import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/login_screen.dart';
import 'package:flutter_login_register_ui/screens/first_page_screen.dart';
import 'package:flutter_login_register_ui/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const customBgColor = Color.fromARGB(255, 255, 255, 255);

  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 0, 0, 0),
      elevation: 5.0,
      padding: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'GeneralSans',
          fontWeight: FontWeight.w500));

  Widget _buildFullNameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Full Name',
        contentPadding: const EdgeInsets.only(top: 10.0, left: 10.0),
        hintText: 'Enter full name',
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(131, 177, 177, 177),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        contentPadding: const EdgeInsets.only(top: 10.0, left: 10.0),
        hintText: 'Enter your email',
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(131, 177, 177, 177),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        contentPadding: const EdgeInsets.only(top: 10.0, left: 10.0),
        hintText: 'Enter your password',
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(131, 177, 177, 177),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginInsteadButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
        },
        child: const Text('Already have an account? Login instead',
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'GeneralSans',
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 23, 23, 23))),
      ),
    );
  }

  Widget _buildRememberMeCheckBox() {
    return Container(
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
                unselectedWidgetColor: Color.fromARGB(255, 177, 177, 177)),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.white,
              activeColor: const Color.fromARGB(221, 23, 23, 23),
              onChanged: (bool? value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text('Remember me',
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'GeneralSans',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(221, 23, 23, 23)))
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        style: btnStyle,
        onPressed: _register,
        child: const Text(
          'Join now',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GeneralSans',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String username = _usernameController.text.trim(); // Get username

    if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
      try {
        await _auth.signUpWithEmail(email, password); // Sign up with email and password

        // Add user data to Firestore
        await FirebaseFirestore.instance.collection('users').add({
          'username': username,
          'email': email,
        });

        // Navigate to FirstPage with empty email
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstPage(username: username, email: '')),
        );
      } catch (e) {
        print("Error signing up: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error signing up: $e"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Please enter email, password, and username"),
        backgroundColor: Colors.red,
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            top: 33.0,
          ),
        ),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Padding(
            padding: EdgeInsets.only(
              top: 21.0,
              left: 25.0,
            ),
            child: Icon(
              Icons.chevron_left,
              color: Color.fromARGB(221, 23, 23, 23),
              size: 35,
            ),
          ),
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Text('Create an account',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'GeneralSans',
                            fontSize: 26.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildFullNameField(),
                          const SizedBox(height: 20.0),
                          _buildEmailField(),
                          const SizedBox(height: 20.0),
                          _buildPasswordField(),
                          _buildLoginInsteadButton(),
                          const SizedBox(height: 20.0),
                          _buildRememberMeCheckBox(),
                          const SizedBox(height: 35.0),
                          _buildSignInButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
