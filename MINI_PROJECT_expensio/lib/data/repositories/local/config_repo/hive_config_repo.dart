import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '/core/utils/colored_log.dart';
import '/data/repositories/app_repository.dart';
import '/data/repositories/local/config_repo/config_repo.dart';

class HiveConfigRepository implements ConfigRepository {
  static const configBox = 'configs';

  @override
  Future<DatabaseType> getDataBaseType() async {
    var box = Hive.box(configBox);
    String? databaseType = await box.get('databaseType');
    ColoredLog(databaseType, name: 'DatabaseType');

    if (FirebaseAuth.instance.currentUser == null) {
      return DatabaseType.local;
    } else if (databaseType == 'local') {
      return DatabaseType.local;
    } else if (databaseType == 'remote') {
      return DatabaseType.remote;
    } else if (FirebaseAuth.instance.currentUser != null) {
      return DatabaseType.remote;
    } else {
      return DatabaseType.local;
    }
  }

  @override
  Future<void> setDatabaseType(DatabaseType type) async {
    var box = Hive.box(configBox);
    if (type == DatabaseType.local) {
      await box.put('databaseType', 'local');
    } else if (type == DatabaseType.remote) {
      await box.put('databaseType', 'remote');
    }
    ColoredLog.blue(type, name: 'SetDbType');
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      var box = Hive.box(configBox);
      String theme;

      if (themeMode == ThemeMode.light) {
        theme = 'light';
      } else if (themeMode == ThemeMode.dark) {
        theme = 'dark';
      } else {
        theme = 'system';
      }
      ColoredLog.yellow(theme, name: 'setTheme');

      await box.put('theme', theme);
    } catch (e) {
      ColoredLog.red(e, name: 'SetThemeMode');
    }
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    var box = Hive.box(configBox);
    String? theme = await box.get('theme');
    ColoredLog(theme, name: 'getTheme');

    if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'system') {
      return ThemeMode.system;
    } else {
      return ThemeMode.dark;
    }
  }
}
