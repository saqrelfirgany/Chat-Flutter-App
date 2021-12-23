import 'package:chat_app/components/primary_button.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chats_screen/chats_screen.dart';
import 'package:flutter/material.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? 'assets/images/Logo_light.png'
                    : "assets/images/Logo_dark.png",
                height: 146,
              ),
              const Spacer(),
              PrimaryButton(
                text: "Sign In",
                press: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
