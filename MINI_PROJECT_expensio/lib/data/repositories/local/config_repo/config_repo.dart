import 'package:flutter/material.dart';

import '../../app_repository.dart';

abstract class ConfigRepository {
  ///It gives the persisted [dark_mode] or [light_mode] of the app
  Future<ThemeMode> getThemeMode();

  ///It helps in persisting [dark_mode] or [light_mode] of the app
  Future<void> setThemeMode(ThemeMode themeMode);

  ///It gives persisted databaseType for use;
  Future<DatabaseType> getDataBaseType();

  ///It helps in persisting [dark_mode] or [light_mode] of the app
  Future<void> setDatabaseType(DatabaseType type);
}
