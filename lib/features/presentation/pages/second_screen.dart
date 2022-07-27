import 'package:flutter/material.dart';
import 'package:to_do_app_phase1/features/presentation/pages/on_board/on_board_screen.dart';

class SecondScreen extends StatefulWidget {
  final String payload;
  const SecondScreen({Key? key,required this.payload}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  String payload = '';

  @override
  void initState() {
    super.initState();
    payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return const OnBoardScreen();
  }
}
