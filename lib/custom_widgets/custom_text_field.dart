import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?)?;

class CustomFormTextField extends StatefulWidget {
  CustomFormTextField(
      {super.key,
      this.onChanged,
      required this.labelText,
      required this.validator,
      this.icon = false,
      this.obscureText});
  final String labelText;
  Function(String)? onChanged;
  MyValidator validator;
  bool? icon;
  bool? obscureText;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? !passwordVisible,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: widget.icon != false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
