import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  final List<String> languagesList = [AppStrings.english, AppStrings.arabic];
  bool _darkTheme = false;
  int _languageIndex = 0;
  bool _showNotification = true;
  bool _enableSounds = true;
  bool _enableVibrations = true;

  bool get darkTheme {
    emit(ChangeThemeMode());
    return _darkTheme;
  }

  set darkTheme(value) => _darkTheme = value;

  int get languageIndex {
    emit(ChangeLanguage());
    return _languageIndex;
  }

  set languageIndex(int value) => _languageIndex = value;

  bool get showNotification {
    emit(ChangeNotificationAllaw());
    return _showNotification;
  }

  set showNotification(bool value) => _showNotification = value;

  bool get enableSounds {
    emit(ChangeSoundsAllaw());
    return _enableSounds;
  }

  set enableSounds(bool value) => _enableSounds = value;

  bool get enableVibrations {
    emit(ChangeVibrationAllaw());
    return _enableVibrations;
  }

  set enableVibrations(bool value) => _enableVibrations = value;
}
