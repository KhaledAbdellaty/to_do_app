import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tasks/controller/providers/date_provider.dart';

class MyNotifications {
  MyNotifications._();
  static final MyNotifications instance = MyNotifications._();
  Future<void> init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'todo notifi',
        channelDescription: 'add new task',
        playSound: true,
        enableVibration: true,
        importance: NotificationImportance.Max,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
      NotificationChannel(
        channelKey: 'key2',
        channelName: 'schedule',
        channelDescription: 'schedule notification',
        playSound: true,
        enableVibration: true,
        importance: NotificationImportance.Max,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ]);
  }

  void createNotification({required String title, required String body}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: title,
        body: body,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Alarm,
      ),
    );
  }

  void createScheduleNotification(
      {required String title,
      required String body,
      required BuildContext context}) async {
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'key2',
        title: title,
        body: body,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Alarm,
      ),
      schedule: NotificationCalendar.fromDate(date: dateProvider.chooseDate),
    );
  }
}
