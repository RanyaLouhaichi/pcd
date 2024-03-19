import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/register_screen.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 1000,
              height: 300,
              child: Image.asset('assets/images/img.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
              child: Text(
                "Explorez l'univers de MySmart",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                width: 320,
                height: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    primary: Colors.black87,
                    textStyle: const TextStyle(fontSize: 18),
                    side: const BorderSide(color: Colors.white, width: 1),
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Join now',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'GeneralSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

