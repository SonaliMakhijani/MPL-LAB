import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/colored_log.dart';
import '/data/repositories/app_repository.dart';
import '/data/repositories/local/config_repo/config_repo.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepository _repo = AppRepository().configRepository;

  ThemeMode themeMode = ThemeMode.dark;
  DatabaseType databaseType = DatabaseType.local;

  ConfigBloc() : super(ConfigInitialState()) {
    on<ConfigThemeModeChangeEvent>(_configChangeEvent);
    on<ConfigGetEvent>(_configGetEvent);
  }
  _configGetEvent(ConfigGetEvent event, Emitter<ConfigState> emit) async {
    ColoredLog.yellow('ConfigInitialThemeEvent');
    themeMode = await _repo.getThemeMode();
    databaseType = await _repo.getDataBaseType();
    AppRepository.dbType = databaseType;
    ColoredLog.green(themeMode, name: 'Get ThemeMode form local DB');
    emit(ConfigLoadedState(themeMode: themeMode, database: databaseType));
  }

  _configChangeEvent(
      ConfigThemeModeChangeEvent event, Emitter<ConfigState> emit) async {
    if (event.database != null) {
      databaseType = event.database!;
      AppRepository.dbType = event.database!;
    }
    if (event.themeMode != null) {
      themeMode = event.themeMode!;
    }

    emit(ConfigLoadedState(themeMode: themeMode, database: databaseType));
    await _repo.setDatabaseType(databaseType);
    await _repo.setThemeMode(themeMode);
  }
}
