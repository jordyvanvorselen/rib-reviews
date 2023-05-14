import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

import '../providers/providers.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  bool isProcessingLogin = false;
  bool showLoginError = false;

  void signOut(GoogleSignIn googleSignIn) {
    setState(() {
      isProcessingLogin = false;
      showLoginError = true;
    });

    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      setState(() {
        isProcessingLogin = true;
      });

      if (account == null) {
        signOut(googleSignIn;
        return;
      }

      final secureStorage = ref.read(Providers.secureStorageProvider);

      final auth = await account.authentication;

      await secureStorage.write(
        key: 'idToken',
        value: auth.idToken,
      );

      try {
        final userSaveService = ref.read(Providers.userSaveServiceProvider);
        final user = await userSaveService.save(
            account.email, account.photoUrl, account.displayName ?? "Unknown");

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(user: user),
          ),
        );
      } catch (e, s) {
        debugPrint('Exception: ${e.toString()}');
        debugPrint('Stacktrace: ${s.toString()}');
        signOut(googleSignIn);
        return;
      }
    });

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
                      child: (GoogleSignInPlatform.instance
                              as web.GoogleSignInPlugin)
                          .renderButton()),
              const SizedBox(height: 25),
              if (showLoginError)
                Text(
                  "Login failed. Make sure to use a Kabisa email adress.",
                  style: const TextStyle(color: kErrorTextColor),
                )
            ],
          ),
        ),
      ),
    );
  }
}
