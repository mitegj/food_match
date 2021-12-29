import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/widgets/home/home_body.dart';
import 'package:morning_brief/widgets/home/home_header.dart';

class HomePage extends GetWidget<IngredientController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
          child: Column(children: [
        HomeHeader(),
        //SizedBox(height: 10),
        HomeBody(),
      ])),
    );
  }
}

/*
Future<void> _showNotificationWithNoSound() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('silent channel id', 'silent channel name',
          channelDescription: 'silent channel description',
          playSound: false,
          styleInformation: DefaultStyleInformation(true, true));
  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(presentSound: false);
  const MacOSNotificationDetails macOSPlatformChannelSpecifics =
      MacOSNotificationDetails(presentSound: false);
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
      macOS: macOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'Insisti', '', platformChannelSpecifics);
}

Future<void> _scheduleDailyTenAMNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'daily scheduled notification title',
      'daily scheduled notification body',
      _nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'daily notification channel id', 'daily notification channel name',
            channelDescription: 'daily notification description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

tz.TZDateTime _nextInstanceOfTenAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 11, 18);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
*/
