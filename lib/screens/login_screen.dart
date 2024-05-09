import 'package:chat_app/custom_widgets/custom_button.dart';
import 'package:chat_app/custom_widgets/custom_text_field.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B475E),
      body: Column(
        children: [
          const Spacer(flex: 2),
          Image.asset('assets/images/scholar.png'),
          const Text(
            'Scholar Chat',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontFamily: 'pacifico'),
          ),
          const Spacer(flex: 1),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomTextField(labelText: 'Email',)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomTextField(labelText: 'Password',)),
          CustomButton(buttonText: 'Login'),
          GestureDetector(
            onTap: () {
             Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: const Text(
              "or create new account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
