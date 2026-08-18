import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/settings/domain/usecases/get_settings.dart';
import 'package:shop_ease/features/settings/domain/usecases/update_theme.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_event.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettings;
  final UpdateThemeUseCase updateTheme;

  SettingsBloc({required this.getSettings, required this.updateTheme})
    : super(const SettingsState()) {
    on<SettingsLoadRequested>(_onLoadRequested);
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<NotificationsEnabledChanged>(_onNotificationsChanged);
  }

  Future<void> _onLoadRequested(
    SettingsLoadRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await getSettings();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(status: SettingsStatus.loaded, settings: settings),
      ),
    );
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await updateTheme(event.themeMode);
    result.fold(
      (failure) => null, // Handle error UI if needed
      (_) => emit(
        state.copyWith(
          settings: state.settings.copyWith(themeMode: event.themeMode),
        ),
      ),
    );
  }

  Future<void> _onNotificationsChanged(
    NotificationsEnabledChanged event,
    Emitter<SettingsState> emit,
  ) async {
    // Similarly update repository...
    emit(
      state.copyWith(
        settings: state.settings.copyWith(notificationsEnabled: event.enabled),
      ),
    );
  }
}
