import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/notifications/domain/entities/notification_item.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationItem>>> getNotifications();
  Future<Either<Failure, void>> markAsRead(String id);
}
