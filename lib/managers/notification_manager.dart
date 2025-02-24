import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SoundNotificationManager {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Иконка для уведомлений

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showNotification(String title, String body, int id) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'bluetooth_scanner_channel_id', // ID канала
      'bluetooth_scanner_channel_name', // Имя канала
      channelDescription: 'bluetooth_scanner_channel_description', // Описание канала
      importance: Importance.max,
      priority: Priority.max,
      playSound: true, // Включить звук
      fullScreenIntent: true,
      // sound: RawResourceAndroidNotificationSound('notification_sound'), // Звук уведомления
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      id, // ID уведомления
      title, // Заголовок уведомления
      body, // Текст уведомления
      platformChannelSpecifics,
    );
  }
}
