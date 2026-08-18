import 'package:equatable/equatable.dart';

class NotificationItem extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, title, message, timestamp, isRead];

  NotificationItem copyWith({bool? isRead}) => NotificationItem(
    id: id,
    title: title,
    message: message,
    timestamp: timestamp,
    isRead: isRead ?? this.isRead,
  );
}
