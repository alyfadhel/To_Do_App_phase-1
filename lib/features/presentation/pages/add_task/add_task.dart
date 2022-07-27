import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:to_do_app_phase1/core/util/bloc/bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/states.dart';
import 'package:to_do_app_phase1/features/presentation/pages/notification_services.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_button.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_form.dart';

String? color;
String? valueController;
String? minsController;

class AddTask extends StatefulWidget {
  const AddTask({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Task',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextForm(
                    controller: cubit.titleController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Title';
                      }
                      return null;
                    },
                    radius: 10.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextForm(
                    controller: cubit.dateController,
                    type: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Date';
                      }
                      return null;
                    },
                    radius: 10.0,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2025-08-31'),
                      ).then((value) {
                        cubit.dateController.text =
                            DateFormat.yMMMd().format(value!);
                        debugPrint(DateFormat.yMMMd().format(value));
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Start Time',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'End Time',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          controller: cubit.startTimeController,
                          type: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Start Date';
                            }
                            return null;
                          },
                          radius: 10.0,
                          suffix: Icons.watch_later_outlined,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.startTimeController.text =
                                  value!.format(context);
                              debugPrint(value.format(context));
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: MyTextForm(
                          controller: cubit.endTimeController,
                          type: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your End date';
                            }
                            return null;
                          },
                          radius: 10.0,
                          suffix: Icons.watch_later_outlined,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.endTimeController.text =
                                  value!.format(context);
                              debugPrint(value.format(context));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Remind',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: minsController,
                    validator: (val) {
                      if (val == null) {
                        return 'required';
                      }
                      return null;
                    },
                    items: ['1 day before', '1 hour', '30 Mins', '10 Mins', '1 Mins']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        cubit.remindController.text = val.toString();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        height: 100.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[400],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            IconButton(
                                onPressed: ()
                                {
                                  Fluttertoast.showToast(
                                      msg: "Color Selected",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  ).then((value)
                                  {
                                    if(value!){
                                      AppCubit.get(context).colorController.text= HexColor('F44336FF').toString();
                                    }
                                  });
                                },
                                icon:  Icon(
                                  Icons.circle,
                                  color: HexColor('F44336FF'),
                                  size: 40.0,
                                ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                Fluttertoast.showToast(
                                    msg: "Color Selected",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                ).then((value){
                                  if(value!){
                                    AppCubit.get(context).colorController.text= HexColor('327351').toString();
                                  }
                                });

                              },
                              icon:  Icon(
                                Icons.circle,
                                color: HexColor('327351'),
                                size: 40.0,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                Fluttertoast.showToast(
                                    msg: "Color Selected",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                ).then((value){
                                  if(value!){
                                    AppCubit.get(context).colorController.text = HexColor('FFC107FF').toString();
                                  }
                                });

                              },
                              icon: Icon(
                                Icons.circle,
                                color: HexColor('FFC107FF'),
                                size: 40.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                            'Choose Your Color',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MyButton(
                    isUpperCase: false,
                    text: 'Create a Task',
                    onPressedButton: () {
                      cubit.insertToDatabase(
                        title: cubit.titleController.text,
                        date: cubit.dateController.text,
                        startTime: cubit.startTimeController.text,
                        endTime: cubit.endTimeController.text,
                        remind: cubit.remindController.text,
                        color: cubit.colorController.text,
                        day: cubit.dayController.text,
                      ).then((value)
                      {
                        Navigator.pop(context);
                      }).then((value)
                      {
                        NotifyHelper().displayNotification(
                            title: AppCubit.get(context).titleController.text,
                            body: AppCubit.get(context).remindController.text,
                        );
                      });
                    },
                    radius: 10.0,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
