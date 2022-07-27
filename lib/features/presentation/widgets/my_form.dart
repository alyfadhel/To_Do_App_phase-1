import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? type;
  final FormFieldValidator<String>?validator;
  final GestureTapCallback?onTap;
  final double radius;
  final IconData? suffix;
  final Function()? suffixPressed;
  const MyTextForm({
    Key? key,
    required this.controller,
    this.type,
    required this.validator,
    this.onTap,
    this.radius = 0.0,
    this.suffix,
    this.suffixPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed,icon: Icon(suffix)) : null,
      ),
    );
  }
}
