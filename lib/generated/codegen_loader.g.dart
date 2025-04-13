// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "app_name": "فورك آب",
  "welcome_message": "مرحبًا بك في فورك آب!",
  "login": "تسجيل الدخول",
  "logout": "تسجيل الخروج",
  "settings": "الإعدادات",
  "language": "اللغة",
  "error": {
    "network": "خطأ في الشبكة. يرجى المحاولة مرة أخرى.",
    "unknown": "حدث خطأ غير معروف."
  }
};
static const Map<String,dynamic> _en = {
  "app_name": "ForkApp",
  "welcome_message": "Welcome to ForkApp!",
  "login": "Login",
  "logout": "Logout",
  "settings": "Settings",
  "language": "Language",
  "error": {
    "network": "Network error. Please try again.",
    "unknown": "An unknown error occurred."
  }
};


static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
