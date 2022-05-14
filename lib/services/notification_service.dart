import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> initAwesomeNotification() async {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_notification',
      [
        NotificationChannel(
          channelKey: 'main_channel',
          channelName: 'Task Reminders',
          channelDescription: 'Task Reminders',
          enableLights: true,
          importance: NotificationImportance.Max,
        )
      ],
    );
  }

  Future<void> requestPermission() async {
    AwesomeNotifications().isNotificationAllowed().then((allowed) {
      if (!allowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> showNotification(
      int id, String channelKey, String title, String body) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
      ),
    );
  }

  Future<void> showScheduledNotification(int id, String channelKey,
      String title, String body, int interval) async {
    String localTZ = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
        ),
        schedule: NotificationInterval(
          interval: interval,
          timeZone: localTZ,
          repeats: false,
        ));
  } //scheduled notifications

  Future<void> showReminder(
      int id,
      String channelKey,
      String title,
      String body,
      int _year,
      int _month,
      int _day,
      int _hour,
      int _minute) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
        ),
        schedule: NotificationCalendar(
          year: _year,
          month: _month,
          day: _day,
          hour: _hour,
          minute: _minute,
          second: 0,
          millisecond: 0,
        ));
  } //show reminder

  Future<void> cancelNotification(int _id) async {
    await AwesomeNotifications().cancel(_id);
  } //cancel notification
}
