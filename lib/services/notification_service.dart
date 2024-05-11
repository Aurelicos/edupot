import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  Future initialize() async {
    NotificationService.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: initializationSettingsAndroid,
      ),
      onDidReceiveNotificationResponse: (details) {
        final String payload = details.payload ?? '';
        final List<String> payloadParts = payload.split(' ');
        final String type = payloadParts[0];
        final String id = payloadParts[1];

        final Map<String, int> categoryMap = {
          'exam': 0,
          'task': 1,
          'project': 2,
        };

        int selectedCategory = categoryMap[type] ?? 0;

        Get.off(AddTaskPage(
          selectedCategory: selectedCategory,
          id: id,
        ));
      },
    );
  }

  NotificationService._internal();

  static Future<void> scheduleNotification(
      int id, String title, String body, tz.TZDateTime scheduledDate,
      {String channelId = "id",
      String channelName = "channel",
      String payload = ""}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  static Future<void> scheduleEntriesNotifications(
      String userId, List<ExamModel> exams, List<TaskModel> tasks) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    for (final exam in exams) {
      DateTime localExamDate = exam.finalDate.toLocal();
      tz.TZDateTime scheduleDayBefore = tz.TZDateTime.from(
          localExamDate.subtract(const Duration(days: 1)), tz.local);
      tz.TZDateTime scheduleHourBefore = tz.TZDateTime.from(
          localExamDate.subtract(const Duration(hours: 1)), tz.local);

      if (scheduleDayBefore.isAfter(now)) {
        NotificationService.scheduleNotification(exam.hashCode, "Exam Reminder",
            "Your exam ${exam.title} is due tomorrow!", scheduleDayBefore,
            payload: "exam ${exam.id}");
      }
      if (scheduleHourBefore.isAfter(now)) {
        NotificationService.scheduleNotification(exam.hashCode, "Exam Reminder",
            "Your exam ${exam.title} is due in one hour!", scheduleHourBefore,
            payload: "exam ${exam.id}");
      }
    }

    for (final task in tasks) {
      DateTime localTaskDate = task.finalDate.toLocal();
      tz.TZDateTime scheduleDayBefore = tz.TZDateTime.from(
          localTaskDate.subtract(const Duration(days: 1)), tz.local);
      tz.TZDateTime scheduleHourBefore = tz.TZDateTime.from(
          localTaskDate.subtract(const Duration(hours: 1)), tz.local);

      if (scheduleDayBefore.isAfter(now)) {
        NotificationService.scheduleNotification(task.hashCode, "Task Reminder",
            "Your task ${task.title} is due tomorrow!", scheduleDayBefore,
            payload: "task ${task.id}");
      }
      if (scheduleHourBefore.isAfter(now)) {
        NotificationService.scheduleNotification(task.hashCode, "Task Reminder",
            "Your task ${task.title} is due in one hour!", scheduleHourBefore,
            payload: "task ${task.id}");
      }
    }
  }

  static Future<void> scheduleProjectsNotifications(
      String userId, List<ProjectModel> projects) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    for (final project in projects) {
      tz.TZDateTime scheduleDayBefore = tz.TZDateTime.from(
          project.finalDate.subtract(const Duration(days: 1)), tz.local);
      tz.TZDateTime scheduleHourBefore = tz.TZDateTime.from(
          project.finalDate.subtract(const Duration(hours: 1)), tz.local);

      if (scheduleDayBefore.isAfter(now)) {
        NotificationService.scheduleNotification(
            project.hashCode,
            "Project Deadline Reminder",
            "Your project ${project.name} deadline is tomorrow!",
            scheduleDayBefore,
            payload: "project ${project.id}");
      }
      if (scheduleHourBefore.isAfter(now)) {
        NotificationService.scheduleNotification(
            project.hashCode,
            "Project Deadline Reminder",
            "Your project ${project.name} deadline is in one hour!",
            scheduleHourBefore,
            payload: "project ${project.id}");
      }
    }
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
