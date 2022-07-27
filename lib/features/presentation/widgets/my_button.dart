import 'package:flutter/material.dart';
import 'package:to_do_app_phase1/features/presentation/pages/add_task/add_task.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double radius;
  final Function()? onPressedButton;
  final bool isUpperCase;
  final String text;
  final TextStyle? style;
  const MyButton({
    Key? key,
    this.width = double.infinity,
    this.radius = 0.0,
    required this.onPressedButton,
    required this.text,
    this.isUpperCase = true,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius,),
            color: Colors.green
        ),
        child: MaterialButton(
          onPressed: onPressedButton,
          child:  Text(
            isUpperCase? text : text,
            style: style,
          ),
        ),
      ),
    );
  }
}
