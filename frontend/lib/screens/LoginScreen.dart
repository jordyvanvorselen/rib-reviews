import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/screens/HomeScreen.dart';

import '../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              SizedBox(
                width: 150,
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: 75),
              Column(
                children: const [
                  Text(
                    "Welcome to",
                    style: TextStyle(color: kSecondaryTextColor, fontSize: 24),
                  ),
                  Text(
                    "The Eat Guild",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Container(
                width: 200,
                height: 50,
                child: SignInButton(Buttons.Google, onPressed: () {
                  googleSignIn.signIn().then((value) {
                    if (value == null || value.displayName == null) {
                      return;
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          user: User(
                            id: "0",
                            email: value.email,
                            photoUrl: value.photoUrl,
                            displayName: value.displayName!,
                          ),
                        ),
                      ),
                    );
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
