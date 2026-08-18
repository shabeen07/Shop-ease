import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/app/di/injection.dart';

import 'package:shop_ease/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:shop_ease/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:shop_ease/features/notifications/presentation/bloc/notifications_state.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        NotificationsBloc(repository: getIt())
          ..add(NotificationsLoadRequested()),
    child: Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == NotificationsStatus.success) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('No notifications found.'));
            }
            return ListView.separated(
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.isRead
                        ? Colors.grey.shade200
                        : Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.notifications_outlined,
                      color: item.isRead
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: item.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(item.message),
                  trailing: item.isRead
                      ? null
                      : Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                  onTap: () {
                    if (!item.isRead) {
                      context.read<NotificationsBloc>().add(
                        NotificationMarkAsReadRequested(item.id),
                      );
                    }
                  },
                );
              },
            );
          }
          return const Center(child: Text('Failed to load notifications.'));
        },
      ),
    ),
  );
}
