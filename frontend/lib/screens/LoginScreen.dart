import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rib_reviews/screens/HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 200,
            height: 50,
            child: SignInButton(Buttons.Google, onPressed: () {
              googleSignIn.signIn().then((value) {
                if (value == null || value.displayName == null) {
                  return;
                }

                String username = value!.displayName!;
                String? photoUrl = value!.photoUrl;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      username: username,
                      photoUrl: photoUrl,
                    ),
                  ),
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}
