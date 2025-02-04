part of 'setting_cubit.dart';

sealed class SettingState {}

final class SettingInitial extends SettingState {}
final class ChangeThemeMode extends SettingState {}
final class ChangeLanguage extends SettingState {}
final class ChangeNotificationAllaw extends SettingState {}
final class ChangeSoundsAllaw extends SettingState {}
final class ChangeVibrationAllaw extends SettingState {}
final class ChangeAppSetting extends SettingState {}


