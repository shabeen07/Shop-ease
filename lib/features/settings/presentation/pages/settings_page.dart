import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_event.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ListView(
      children: [
        _buildAppearanceSection(context),
        const Divider(),
        _buildNotificationsSection(context),
        const Divider(),
        _buildAboutSection(context),
      ],
    ),
  );

  Widget _buildAppearanceSection(BuildContext context) =>
      BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Theme'),
              subtitle: Text(state.settings.themeMode.name.toUpperCase()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () =>
                  _showThemeSelector(context, state.settings.themeMode),
            ),
          ],
        ),
      );

  void _showThemeSelector(BuildContext context, AppThemeMode currentMode) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Theme',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioGroup<AppThemeMode>(
              groupValue: currentMode,
              onChanged: (newMode) {
                if (newMode != null) {
                  context.read<SettingsBloc>().add(ThemeModeChanged(newMode));
                  Navigator.pop(context);
                }
              },
              child: Column(
                children: AppThemeMode.values
                    .map(
                      (mode) => RadioListTile<AppThemeMode>(
                        title: Text(mode.name.toUpperCase()),
                        value: mode,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(BuildContext context) =>
      BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.notifications_active_outlined),
              title: const Text('Push Notifications'),
              value: state.settings.notificationsEnabled,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                  NotificationsEnabledChanged(value),
                );
              },
            ),
          ],
        ),
      );

  Widget _buildAboutSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'About',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final version = snapshot.data?.version ?? '1.0.0';
          return ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Version'),
            trailing: Text(version),
          );
        },
      ),
      const ListTile(
        leading: Icon(Icons.shield_outlined),
        title: Text('Privacy Policy'),
        trailing: Icon(Icons.chevron_right),
      ),
    ],
  );
}
