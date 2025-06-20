// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/resources/styles_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

import '../setting/cubit/setting_cubit.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme(BuildContext context) {
  bool darkTheme = BlocProvider.of<SettingCubit>(context).darkTheme;

// Dynamic colors based on theme
  Color primary =
      darkTheme ? ColorManager.darkPrimary : ColorManager.lightPrimary;
  Color primaryVariant = darkTheme
      ? ColorManager.darkPrimaryVariant
      : ColorManager.lightPrimaryVariant;
  Color secondary =
      darkTheme ? ColorManager.darkSecondary : ColorManager.lightSecondary;
  Color secondaryVariant = darkTheme
      ? ColorManager.darkSecondaryVariant
      : ColorManager.lightSecondaryVariant;
  Color background =
      darkTheme ? ColorManager.darkBackground : ColorManager.lightBackground;
  Color surface =
      darkTheme ? ColorManager.darkSurface : ColorManager.lightSurface;
  Color error = darkTheme ? ColorManager.darkError : ColorManager.lightError;
  Color onPrimary =
      darkTheme ? ColorManager.darkOnPrimary : ColorManager.lightOnPrimary;
  Color onSecondary =
      darkTheme ? ColorManager.darkOnSecondary : ColorManager.lightOnSecondary;
  Color onBackground = darkTheme
      ? ColorManager.darkOnBackground
      : ColorManager.lightOnBackground;
  Color onSurface =
      darkTheme ? ColorManager.darkOnSurface : ColorManager.lightOnSurface;
  Color onError =
      darkTheme ? ColorManager.darkOnError : ColorManager.lightOnError;
  Color grey = darkTheme ? ColorManager.darkGrey : ColorManager.lightGrey;
  Color lightGrey =
      darkTheme ? ColorManager.darkLightGrey : ColorManager.lightLightGrey;
  Color darkGrey =
      darkTheme ? ColorManager.darkDarkGrey : ColorManager.lightDarkGrey;

  return ThemeData(
    brightness: darkTheme ? Brightness.dark : Brightness.light,
    primaryColor: primary,
    primaryColorDark: primaryVariant,
    primaryColorLight: secondary,
    colorScheme: ColorScheme(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onSurface: onSurface,
      onError: onError,
      brightness: darkTheme ? Brightness.dark : Brightness.light,
    ),
    scaffoldBackgroundColor: background,
    disabledColor: grey,
    cardTheme: CardTheme(
      color: surface,
      shadowColor: darkGrey,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
    iconTheme: IconThemeData(
      color: primary,
    ),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: primary,
      elevation: AppSize.s4,
      shadowColor: primaryVariant,
      titleTextStyle: getRegularStyle(fontSize: FontSize.s16, color: onPrimary),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: grey,
      buttonColor: primary,
      splashColor: secondary,
    ),
    textTheme: TextTheme(
      displayLarge: getMediumStyle(color: onBackground, fontSize: FontSize.s32),
      displayMedium:
          getRegularStyle(color: onBackground, fontSize: FontSize.s14),
      displaySmall: getMediumStyle(color: onBackground, fontSize: FontSize.s14),
      bodySmall: getBoldStyle(color: onBackground, fontSize: FontSize.s16),
      bodyLarge: getRegularStyle(color: onBackground),
      bodyMedium: getRegularStyle(
          color: onBackground,
          fontSize: FontSize.s17,
          fontStyle: FontStyle.italic),
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: primary,),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: onPrimary, fontSize: FontSize.s17),
        backgroundColor: primary,
        foregroundColor: onPrimary,
        disabledForegroundColor: onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: grey, fontSize: FontSize.s14),
      labelStyle: getMediumStyle(color: onBackground, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
