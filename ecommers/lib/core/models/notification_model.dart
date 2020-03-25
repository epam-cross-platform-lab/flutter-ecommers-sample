import 'dart:ui';

class NotificationModel {
  final String orderNumber;
  final String notificationUsualText;
  final String statusText;
  final bool isCheckedItem;
  final Color backgroundColor;
  final Color shadowColor;
  final String imgPath;
  final DateTime day;

  NotificationModel({
    this.orderNumber,
    this.notificationUsualText,
    this.isCheckedItem,
    this.statusText,
    this.backgroundColor,
    this.shadowColor,
    this.imgPath,
    this.day,
  });
}
