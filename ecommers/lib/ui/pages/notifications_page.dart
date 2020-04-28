import 'package:ecommers/core/models/notification_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/backgrounds_for_notifications.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/notification/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  static const _notificationDeviderIndent = 70.0;

  static final DateFormat formatter = DateFormat('d MMM');

  String _formatDate(DateTime date) {
    if (date.day == DateTime.now().day) {
      return DateFormat.jm().format(date).toString();
    }
    if (DateTime.now().month == date.month &&
        (DateTime.now().day - date.day) >= 1) {
      return localization.yesterday;
    } else {
      return formatter.format(date);
    }
  }

  List<NotificationModel> get _notifications => [
        NotificationModel(
          backgroundColor: BackgroundForNotifications.orderBackgroundColor,
          shadowColor:
              BackgroundForNotifications.orderBackgroundColor.withOpacity(0.40),
          imgPath: Assets.order,
          day: DateTime.now(),
          statusText: 'shipped',
          notificationUsualText: 'marked your order',
          orderNumber: '#1982984',
        ),
        NotificationModel(
          backgroundColor:
              BackgroundForNotifications.locationPinBackgroundColor,
          shadowColor: BackgroundForNotifications.locationPinBackgroundColor
              .withOpacity(0.40),
          imgPath: Assets.locationPin,
          day: DateTime.utc(2020, 03, 13),
          statusText: 'shipped',
          notificationUsualText: 'marked your order',
          orderNumber: '#1982984',
        ),
        NotificationModel(
          backgroundColor: BackgroundForNotifications.discountBackgroundColor,
          shadowColor: BackgroundForNotifications.discountBackgroundColor
              .withOpacity(0.40),
          imgPath: Assets.discount,
          day: DateTime.utc(2020, 10, 15),
          statusText: 'shipped',
          notificationUsualText: 'marked your order',
          orderNumber: '#1982984',
        ),
        NotificationModel(
          backgroundColor: BackgroundForNotifications.tagBackgroundColor,
          shadowColor:
              BackgroundForNotifications.tagBackgroundColor.withOpacity(0.40),
          imgPath: Assets.tagIcon,
          day: DateTime.utc(2020, 09, 20),
          statusText: 'shipped',
          notificationUsualText: 'marked your order',
          orderNumber: '#1982984',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return CloseablePage(
      child: BackgroundedSafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Insets.x6,
            Insets.x0,
            Insets.x5,
            Insets.x4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                localization.notificationsTitle,
                style: textTheme.headline6,
              ),
              const SizedBox(height: Insets.x5),
              Expanded(
                child: _buildNotificationListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationListView() {
    return ListView.separated(
      itemCount: _notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final currentNotification = _notifications[index];
        return NotificationWidget(
          isCheckedItem: currentNotification.isCheckedItem,
          orderNumberText: currentNotification.orderNumber,
          richText: currentNotification.statusText,
          usualText: currentNotification.notificationUsualText,
          backgroundColor: currentNotification.backgroundColor,
          shadowColor: currentNotification.shadowColor,
          imagePath: currentNotification.imgPath,
          day: _formatDate(currentNotification.day),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            Insets.x0,
            Insets.x3,
            Insets.x0,
            Insets.x0,
          ),
          child: Divider(
            color: BrandingColors.secondary.withOpacity(0.4),
            indent: _notificationDeviderIndent,
          ),
        );
      },
    );
  }
}
