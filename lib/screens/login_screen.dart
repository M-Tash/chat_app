import 'package:chat_app/constants.dart';
import 'package:chat_app/custom_widgets/custom_button.dart';
import 'package:chat_app/custom_widgets/custom_snack_bar.dart';
import 'package:chat_app/custom_widgets/custom_text_field.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 0.8,
      color: Colors.transparent,
      progressIndicator: const CircularProgressIndicator(color: Colors.white),
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: Column(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomFormTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    obscureText: false,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your email';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                    labelText: 'Email',
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomFormTextField(
                    onChanged: (data) {
                      password = data;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your password';
                      }
                      if (text.length < 6) {
                        return 'please enter a valid password';
                      }
                      return null;
                    },
                    icon: true,
                    labelText: 'Password',
                  )),
              CustomButton(
                buttonText: 'Login',
                onTap: () {
                  LoginUser();
                },
              ),
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
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, ChatScreen.routeName,
            arguments: email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'Wrong email');
        } else if (e.code == 'wrong-password') {
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'Wrong password');
        } else if (e.code == 'invalid-credential') {
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'Wrong email or password');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'error');
      }
      isLoading = false;
      setState(() {});
    }
  }
}
