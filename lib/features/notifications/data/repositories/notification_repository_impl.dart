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
      title: 'Flash Sale',
      message: 'Electronics are 30% off for the next 6 hours!',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
    ),
    NotificationItem(
      id: '3',
      title: 'Welcome',
      message: 'Welcome to Shop Ease! Enjoy your first purchase.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
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
