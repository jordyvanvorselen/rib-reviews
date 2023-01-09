import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rib_reviews/screens/home_screen.dart';
import 'package:rib_reviews/services/user_save_service.dart';

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
              const SizedBox(height: 100),
              SizedBox(
                width: 150,
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(height: 75),
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
              const SizedBox(height: 50),
              SizedBox(
                width: 200,
                height: 50,
                child: SignInButton(Buttons.Google, onPressed: () async {
                  googleSignIn.signIn().then((value) {
                    if (value == null) {
                      return;
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FutureBuilder(
                          future: UserSaveService.save(value.email,
                              value.photoUrl, value.displayName ?? "Unknown"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return HomeScreen(user: snapshot.data!);
                            } else {
                              return const LoginScreen();
                            }
                          },
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
