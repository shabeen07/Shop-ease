import 'package:equatable/equatable.dart';

enum AppThemeMode { system, light, dark }

class AppSettings extends Equatable {
  final AppThemeMode themeMode;
  final bool notificationsEnabled;

  const AppSettings({
    required this.themeMode,
    required this.notificationsEnabled,
  });

  @override
  List<Object?> get props => [themeMode, notificationsEnabled];

  AppSettings copyWith({AppThemeMode? themeMode, bool? notificationsEnabled}) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      );
}
