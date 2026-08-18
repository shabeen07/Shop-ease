import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_ease/app/di/injection.dart';
import 'package:shop_ease/app/router/route_names.dart';
import 'package:shop_ease/features/notifications/domain/entities/notification_item.dart';
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
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackButton(onPressed: () => context.goNamed(RouteNames.home)),
        actions: [
          IconButton(
            onPressed: () {}, // Mark all as read visual only
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == NotificationsStatus.failure) {
            return _ErrorState(
              onRetry: () => context.read<NotificationsBloc>().add(
                NotificationsLoadRequested(),
              ),
            );
          }

          if (state.notifications.isEmpty) {
            return const _EmptyState();
          }

          final grouped = _groupNotifications(state.notifications);

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final item = grouped[index];
              if (item is String) {
                return _SectionHeader(title: item);
              } else {
                return _NotificationTile(item: item as NotificationItem);
              }
            },
          );
        },
      ),
    ),
  );

  List<dynamic> _groupNotifications(List<NotificationItem> notifications) {
    final grouped = <dynamic>[];
    final now = DateTime.now();

    final today = notifications
        .where(
          (n) =>
              n.timestamp.day == now.day &&
              n.timestamp.month == now.month &&
              n.timestamp.year == now.year,
        )
        .toList();

    final yesterday = notifications.where((n) {
      final yest = now.subtract(const Duration(days: 1));
      return n.timestamp.day == yest.day &&
          n.timestamp.month == yest.month &&
          n.timestamp.year == yest.year;
    }).toList();

    if (today.isNotEmpty) {
      grouped
        ..add('Today')
        ..addAll(today);
    }

    if (yesterday.isNotEmpty) {
      grouped
        ..add('Yesterday')
        ..addAll(yesterday);
    }

    // Handle older if any
    final older = notifications
        .where((n) => !today.contains(n) && !yesterday.contains(n))
        .toList();
    if (older.isNotEmpty) {
      grouped
        ..add('Older')
        ..addAll(older);
    }

    return grouped;
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
    ),
  );
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: item.isRead
            ? colorScheme.surfaceContainerLow
            : colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          if (!item.isRead) {
            context.read<NotificationsBloc>().add(
              NotificationMarkAsReadRequested(item.id),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(context),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: item.isRead
                            ? FontWeight.w500
                            : FontWeight.w600,
                        color: item.isRead
                            ? colorScheme.onSurface
                            : colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.message,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: item.isRead
                            ? colorScheme.onSurfaceVariant
                            : colorScheme.onPrimaryContainer.withValues(
                                alpha: 0.8,
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTimestamp(item.timestamp),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (!item.isRead)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final IconData iconData;
    if (item.title.contains('Order')) {
      iconData = Icons.local_shipping;
    } else if (item.title.contains('Flash')) {
      iconData = Icons.sell;
    } else if (item.title.contains('Welcome')) {
      iconData = Icons.celebration;
    } else {
      iconData = Icons.notifications;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: item.isRead ? colorScheme.primaryContainer : colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 20,
        color: item.isRead ? colorScheme.onPrimaryContainer : Colors.white,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inHours < 24 && timestamp.day == now.day) {
      return '${difference.inHours} hours ago';
    } else if (timestamp.day == now.subtract(const Duration(days: 1)).day) {
      return 'Yesterday';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.mark_email_read,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'All caught up!',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('You have no new notifications.'),
      ],
    ),
  );
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Couldn't load notifications",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please check your connection and try again.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    ),
  );
}
