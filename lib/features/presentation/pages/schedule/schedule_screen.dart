import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_widget/task_widget.dart';



class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children:
          [
            Container(
              margin: const EdgeInsets.only(top: 20.0,left: 20.0),
              child: DatePicker(
                DateTime.now(),
                height: 100.0,
                width: 50.0,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.green,
                selectedTextColor: Colors.white,
                dateTextStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const TaskWidget(),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

