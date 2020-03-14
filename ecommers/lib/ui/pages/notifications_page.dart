import 'package:ecommers/core/models/notification_model.dart';
import 'package:ecommers/generated/i18n.dart';
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

  static final DateTime thirdDate = DateTime.utc(2020, 10, 15);
  static final DateTime fourthDate = DateTime.utc(2020, 09, 20);

  final String formattedThirdDate = formatter.format(thirdDate);
  final String formattedFourthDate = formatter.format(fourthDate);

  List<NotificationModel> get _notifications => [
        NotificationModel(
          backgroundColor: BackgroundForNotifications.orderBackgroundColor,
          shadowColor:
              BackgroundForNotifications.orderBackgroundColor.withOpacity(0.40),
          imgPath: Assets.order,
          day: DateFormat.jm()
              .format(DateTime(2020, 10, 20, 09, 20, 00))
              .toString(),
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
          day: 'Yesterday',
          statusText: 'shipped',
          notificationUsualText: 'marked your order',
          orderNumber: '#1982984',
        ),
        NotificationModel(
          backgroundColor: BackgroundForNotifications.discountBackgroundColor,
          shadowColor: BackgroundForNotifications.discountBackgroundColor
              .withOpacity(0.40),
          imgPath: Assets.discount,
          day: formattedThirdDate,
          statusText: 'shipped',
          notificationUsualText: 'marked your order',
          orderNumber: '#1982984',
        ),
        NotificationModel(
          backgroundColor: BackgroundForNotifications.tagBackgroundColor,
          shadowColor:
              BackgroundForNotifications.tagBackgroundColor.withOpacity(0.40),
          imgPath: Assets.tagIcon,
          day: formattedFourthDate,
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
              Insets.x6, Insets.x0, Insets.x5, Insets.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                I18n.of(context).notificationsTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
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
      padding:
          const EdgeInsets.fromLTRB(Insets.x0, Insets.x0, Insets.x0, Insets.x0),
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
          day: currentNotification.day,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              Insets.x0, Insets.x3, Insets.x0, Insets.x0),
          child: Divider(
            color: BrandingColors.secondary.withOpacity(0.4),
            indent: _notificationDeviderIndent,
          ),
        );
      },
    );
  }
}
