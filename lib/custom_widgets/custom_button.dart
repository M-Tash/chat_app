import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  const CustomButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xff2B475E),
          fixedSize: Size(372.7, 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: () {
        //todo:login
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Color(0xff2B475E),
          fontSize: 21,
        ),
      ),
    );
  }
}
