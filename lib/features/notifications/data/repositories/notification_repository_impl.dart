import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/notifications/domain/entities/notification_item.dart';
import 'package:shop_ease/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final List<NotificationItem> _mockNotifications = [
    NotificationItem(
      id: '1',
      title: 'Order Shipped',
      message: 'Your order #12345 has been shipped and is on its way.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: '2',
      title: 'Flash Sale — 30% OFF!',
      message: "Electronics are 30% off for the next 6 hours. Don't miss out!",
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    NotificationItem(
      id: '3',
      title: 'Welcome to Shop Ease',
      message: 'Enjoy 10% off your first purchase with code WELCOME10.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      title: 'Security Alert',
      message: 'Your password was successfully changed.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      isRead: true,
    ),
  ];

  @override
  Future<Either<Failure, List<NotificationItem>>> getNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return Right(List.from(_mockNotifications));
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = _mockNotifications[index].copyWith(
        isRead: true,
      );
    }
    return const Right(null);
  }
}
