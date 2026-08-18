import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
  @override
  List<Object?> get props => [];
}

class NotificationsLoadRequested extends NotificationsEvent {}

class NotificationMarkAsReadRequested extends NotificationsEvent {
  final String id;
  const NotificationMarkAsReadRequested(this.id);
  @override
  List<Object?> get props => [id];
}
