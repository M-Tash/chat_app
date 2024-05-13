import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  CustomButton({super.key, this.onTap, required this.buttonText});
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: kPrimaryColor,
          fixedSize: const Size(372.7, 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: kPrimaryColor,
          fontSize: 21,
        ),
      ),
    );
  }
}
