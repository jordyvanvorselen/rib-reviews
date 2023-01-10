import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rib_reviews/screens/home_screen.dart';
import 'package:rib_reviews/services/user_save_service.dart';

import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isProcessingLogin = false;
  bool showLoginError = false;

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 125),
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
              isProcessingLogin
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 200,
                      height: 50,
                      child: SignInButton(Buttons.Google, onPressed: () async {
                        googleSignIn.signIn().then((value) async {
                          setState(() => isProcessingLogin = true);

                          if (value == null ||
                              !value.email.endsWith("@kabisa.nl")) {
                            setState(() {
                              isProcessingLogin = false;
                              showLoginError = true;
                            });
                            return;
                          }

                          final user = await UserSaveService.save(value.email,
                              value.photoUrl, value.displayName ?? "Unknown");

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomeScreen(user: user),
                            ),
                          );
                        });
                      }),
                    ),
              const SizedBox(height: 25),
              if (showLoginError)
                const Text(
                  "Login failed. Make sure to use a Kabisa email adress.",
                  style: TextStyle(color: kErrorTextColor),
                )
            ],
          ),
        ),
      ),
    );
  }
}
