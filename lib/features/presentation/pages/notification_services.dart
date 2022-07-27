import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:to_do_app_phase1/features/presentation/pages/add_task/add_task.dart';
import 'package:to_do_app_phase1/features/presentation/pages/second_screen.dart';

class NotifyHelper
{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  initializeNotification()async
  {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
    //tz.setLocalLocation(tz.getLocation(timeZoneName));
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('appicon');
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );


    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload)async{
        selectNotification(payload: payload);
        });
  }

  Future selectNotification({String? payload, BuildContext? context}) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context!,
      MaterialPageRoute<void>(builder: (context) => SecondScreen(payload: payload!)),
    );
  }

  Future displayNotification({required String title, required String body})
  async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const IOSNotificationDetails iosPlatformChannelSpecifics =
    IOSNotificationDetails();
     const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  scheduledNotification(String title, String remind)async
  {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        remind,
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }


  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload, context) async
  {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondScreen(payload: 'payload'),
                ),
              );
            },
          )
        ],
      ),
    );
  }
















}