import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:morning_brief/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notification {
  void initState() {
    //_requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _repeatNotification();
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification);
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      print(payload);
    });
  }

  Future<void> _repeatNotification() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String dinnerTime = prefs.getString("dinnerTime") ?? "";

      // dinnerTime != ""
      if (dinnerTime != "") {
        tz.initializeTimeZones();
        final String? timeZoneName =
            await FlutterNativeTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timeZoneName!));

        String sendTime =
            "${DateTime.now().toString().split(' ')[0]} " + dinnerTime;
        try {
          flutterLocalNotificationsPlugin.zonedSchedule(
              0,
              'foodmatch',
              'NOTIFICATIONBODY'.tr,
              tz.TZDateTime.parse(tz.local, sendTime),
              //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
              const NotificationDetails(
                  android: AndroidNotificationDetails(
                      'full screen channel id', 'full screen channel name',
                      channelDescription: 'full screen channel description',
                      priority: Priority.high,
                      importance: Importance.high,
                      fullScreenIntent: true)),
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);
        } catch (e) {}
      }
    } catch (e) {}
  }
}
