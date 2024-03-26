part of 'config_bloc.dart';

abstract class ConfigEvent {}

class ConfigThemeModeChangeEvent extends ConfigEvent {
  final ThemeMode? themeMode;
  final DatabaseType? database;
  ConfigThemeModeChangeEvent({this.themeMode, this.database});
}

class ConfigGetEvent extends ConfigEvent {}
