import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/notifications/domain/entities/notification_item.dart';

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<NotificationItem> notifications;
  final String? errorMessage;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, notifications, errorMessage];

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationItem>? notifications,
    String? errorMessage,
  }) => NotificationsState(
    status: status ?? this.status,
    notifications: notifications ?? this.notifications,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
