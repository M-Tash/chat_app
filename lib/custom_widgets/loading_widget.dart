import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 0.8,
      color: Colors.transparent,
      progressIndicator: const CircularProgressIndicator(color: kPrimaryColor),
      inAsyncCall: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/scholar.png',
                  height: 60,
                ),
                const Text(
                  'Chat',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
