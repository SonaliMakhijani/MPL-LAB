part of 'config_bloc.dart';

abstract class ConfigState {
  final ThemeMode themeMode;
  final DatabaseType database;

  ConfigState({required this.database, required this.themeMode});
}

class ConfigInitialState extends ConfigState {
  ConfigInitialState()
      : super(themeMode: ThemeMode.system, database: DatabaseType.local);
}

class ConfigLoadedState extends ConfigState {
  ConfigLoadedState({required super.themeMode, required super.database});
}
