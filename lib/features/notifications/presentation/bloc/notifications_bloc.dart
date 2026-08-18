import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/notifications/domain/repositories/notification_repository.dart';

import 'package:shop_ease/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:shop_ease/features/notifications/presentation/bloc/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository repository;

  NotificationsBloc({required this.repository})
    : super(const NotificationsState()) {
    on<NotificationsLoadRequested>(_onLoadRequested);
    on<NotificationMarkAsReadRequested>(_onMarkAsReadRequested);
  }

  Future<void> _onLoadRequested(
    NotificationsLoadRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: NotificationsStatus.loading));
    final result = await repository.getNotifications();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotificationsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notifications) => emit(
        state.copyWith(
          status: NotificationsStatus.success,
          notifications: notifications,
        ),
      ),
    );
  }

  Future<void> _onMarkAsReadRequested(
    NotificationMarkAsReadRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    await repository.markAsRead(event.id);
    final updatedList = state.notifications.map((n) {
      if (n.id == event.id) return n.copyWith(isRead: true);
      return n;
    }).toList();
    emit(state.copyWith(notifications: updatedList));
  }
}
