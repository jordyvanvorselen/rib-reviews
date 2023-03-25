import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rib_reviews/providers/providers.dart';
import 'package:rib_reviews/screens/home_screen.dart';

import '../utils/constants.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  bool isProcessingLogin = false;
  bool showLoginError = false;

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            '970203920402-ckkm3fa3ku58k56m926k09cmeito57q1.apps.googleusercontent.com');

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
                        googleSignIn.signIn().then((account) async {
                          setState(() => isProcessingLogin = true);

                          if (account == null) {
                            setState(() {
                              isProcessingLogin = false;
                              showLoginError = true;
                            });

                            return googleSignIn.signOut();
                          }

                          final auth = await account.authentication;

                          final secureStorage =
                              ref.read(Providers.secureStorageProvider);

                          await secureStorage.write(
                            key: 'idToken',
                            value: auth.idToken,
                          );

                          final user = await ref
                              .read(Providers.userSaveServiceProvider)
                              .save(account.email, account.photoUrl,
                                  account.displayName ?? "Unknown");

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
