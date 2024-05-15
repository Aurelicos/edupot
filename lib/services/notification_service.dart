import 'dart:convert';

import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/services/shared_preferences_service.dart';
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

        Get.to(AddTaskPage(
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
      if (localExamDate.isAfter(DateTime.now())) {
        tz.TZDateTime scheduleDayBefore = tz.TZDateTime.from(
            localExamDate.subtract(const Duration(days: 1)), tz.local);
        tz.TZDateTime scheduleHourBefore = tz.TZDateTime.from(
            localExamDate.subtract(const Duration(hours: 1)), tz.local);

        bool dayNotificationScheduled =
            SharedPreferencesService.value("exam_day_${exam.id}");
        bool hourNotificationScheduled =
            SharedPreferencesService.value("exam_hour_${exam.id}");

        if (!dayNotificationScheduled && scheduleDayBefore.isAfter(now)) {
          NotificationService.scheduleNotification(
              stableNotificationId(exam.id!, 'day'),
              "Exam Reminder",
              "Your exam ${exam.title} is due tomorrow!",
              scheduleDayBefore,
              payload: "exam ${exam.id}");
          SharedPreferencesService.setValue("exam_day_${exam.id}", true);
        }

        if (!hourNotificationScheduled && scheduleHourBefore.isAfter(now)) {
          NotificationService.scheduleNotification(
              stableNotificationId(exam.id!, 'hour'),
              "Exam Reminder",
              "Your exam ${exam.title} is due in one hour!",
              scheduleHourBefore,
              payload: "exam ${exam.id}");
          SharedPreferencesService.setValue("exam_hour_${exam.id}", true);
        }
      }
    }

    for (final task in tasks) {
      if (!task.done!) {
        DateTime localTaskDate = task.finalDate.toLocal();
        if (localTaskDate.isAfter(DateTime.now())) {
          tz.TZDateTime scheduleDayBefore = tz.TZDateTime.from(
              localTaskDate.subtract(const Duration(days: 1)), tz.local);
          tz.TZDateTime scheduleHourBefore = tz.TZDateTime.from(
              localTaskDate.subtract(const Duration(hours: 1)), tz.local);

          bool dayNotificationScheduled =
              SharedPreferencesService.value("task_day_${task.id}");

          bool hourNotificationScheduled =
              SharedPreferencesService.value("task_hour_${task.id}");

          if (!dayNotificationScheduled && scheduleDayBefore.isAfter(now)) {
            NotificationService.scheduleNotification(
                stableNotificationId(task.id!, 'day'),
                "Task Reminder",
                "Your task ${task.title} is due tomorrow!",
                scheduleDayBefore,
                payload: "task ${task.id}");
            SharedPreferencesService.setValue("task_day_${task.id}", true);
          }

          if (!hourNotificationScheduled && scheduleHourBefore.isAfter(now)) {
            NotificationService.scheduleNotification(
                stableNotificationId(task.id!, 'hour'),
                "Task Reminder",
                "Your task ${task.title} is due in one hour!",
                scheduleHourBefore,
                payload: "task ${task.id}");
            SharedPreferencesService.setValue("task_hour_${task.id}", true);
          }
        }
      }
    }
  }

  static Future<void> scheduleProjectsNotifications(
      String userId, List<ProjectModel> projects) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    for (final project in projects) {
      DateTime localProjectDate = project.finalDate.toLocal();
      tz.TZDateTime scheduleDayBefore = tz.TZDateTime.from(
          localProjectDate.subtract(const Duration(days: 1)), tz.local);
      tz.TZDateTime scheduleHourBefore = tz.TZDateTime.from(
          localProjectDate.subtract(const Duration(hours: 1)), tz.local);

      if (now.difference(scheduleDayBefore).inDays == 0) {
        NotificationService.scheduleNotification(
            stableNotificationId(project.id!, 'day'),
            "Project Deadline Reminder",
            "Your project ${project.name} deadline is tomorrow!",
            scheduleDayBefore,
            payload: "project ${project.id}");
      }
      if (now.difference(scheduleHourBefore).inHours == 0 &&
          now.minute == scheduleHourBefore.minute) {
        NotificationService.scheduleNotification(
            stableNotificationId(project.id!, 'hour'),
            "Project Deadline Reminder",
            "Your project ${project.name} deadline is in one hour!",
            scheduleHourBefore,
            payload: "project ${project.id}");
      }
    }
  }

  static int stableNotificationId(String baseId, String type) {
    final bytes = utf8.encode(baseId + type);
    int hash = 0;
    for (var byte in bytes) {
      hash = (hash + byte) % (1 << 31);
    }
    return hash;
  }

  static Future<void> cancelAllNotificationsForEvent(String eventId) async {
    List<String> notificationTypes = ['day', 'hour'];
    for (var type in notificationTypes) {
      int notificationId = stableNotificationId(eventId, type);
      await flutterLocalNotificationsPlugin.cancel(notificationId);
    }
  }
}
