import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notificationList = [];

  getAllNotifications() {
    DbHelper.getAllNotifications().listen((snapshot) {
      notificationList = List.generate(snapshot.docs.length,
          (index) => NotificationModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> updateNotificationStatus(String notId) =>
      DbHelper.updateNotificationStatus(notId);

  int get totalUnreadMessage {
    int total = 0;
    for (final n in notificationList) {
      if (!n.status) {
        total += 1;
      }
    }
    return total;
  }
}
