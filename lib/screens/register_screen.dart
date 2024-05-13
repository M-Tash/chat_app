import 'package:chat_app/constants.dart';
import 'package:chat_app/custom_widgets/custom_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  String? confirmPassword;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 0.8,
      color: Colors.transparent,
      progressIndicator: CircularProgressIndicator(color: Colors.white),
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 90, bottom: 40),
                  child: Image.asset('assets/images/scholar.png')),
              const Text(
                'Scholar Chat',
                style: TextStyle(
                    color: Colors.white, fontSize: 24, fontFamily: 'pacifico'),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomFormTextField(
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
                    onChanged: (data) {
                      email = data;
                    },
                    labelText: 'Email',
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomFormTextField(
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
                    onChanged: (data) {
                      password = data;
                    },
                    labelText: 'Password',
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomFormTextField(
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your password';
                      }

                      if (text != password) {
                        return "password doesn't match";
                      }
                      return null;
                    },
                    icon: true,
                    onChanged: (data) {
                      confirmPassword = data;
                    },
                    labelText: 'Confirm Password',
                  )),
              CustomButton(
                buttonText: 'Register',
                onTap: () async {
                  await registerUser();
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Already have an account ?",
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

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, ChatScreen.routeName,
            arguments: email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'Weak Password');
        } else if (e.code == 'email-already-in-use') {
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'The account already exists for that email.');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, e.toString());
      }
      isLoading = false;
      setState(() {});
    }
  }
}
