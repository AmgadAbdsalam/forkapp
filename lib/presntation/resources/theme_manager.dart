import 'package:flutter/material.dart';
import 'package:responsive/presntation/resources/styles_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';


import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme(){
 return ThemeData(
    // main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
    // card view theme
      cardTheme: CardTheme(
      color: ColorManager.grey,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4),
    // app bar theme
   appBarTheme: AppBarTheme(
       centerTitle: true,
       color: ColorManager.primary,
       elevation: AppSize.s4,
       shadowColor: ColorManager.lightPrimary,
       titleTextStyle: getRegularStyle(
           fontSize: FontSize.s16, color: ColorManager.white)),
    // button theme
   buttonTheme: ButtonThemeData(
       shape: const StadiumBorder(),
       disabledColor: ColorManager.grey1,
       buttonColor: ColorManager.primary,
       splashColor: ColorManager.lightPrimary),
    // text theme
   textTheme: TextTheme(
       displayLarge:
       getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
       displayMedium: getRegularStyle(       
           color: ColorManager.darkGrey, fontSize: FontSize.s14),
       displaySmall: getMediumStyle(       //subtitle1
           color: ColorManager.lightGrey, fontSize: FontSize.s14),
       bodySmall: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s16),
       bodyLarge: getRegularStyle(color: ColorManager.grey)
   ),
   // elevated button them
   elevatedButtonTheme: ElevatedButtonThemeData(
       style: ElevatedButton.styleFrom(
           textStyle: getRegularStyle(
               color: ColorManager.white, fontSize: FontSize.s17),
           backgroundColor: ColorManager.primary,
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(AppSize.s12)))
   ),

   // input decoration theme (text form field)
   inputDecorationTheme: InputDecorationTheme(
     // content padding
     contentPadding: const EdgeInsets.all(AppPadding.p8),
     // hint style
     hintStyle:
     getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
     // label style
     labelStyle: getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
     // error style
     errorStyle: getRegularStyle(color: ColorManager.error),
     // enabled border style
     enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
     // focused border style
     focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
     // error border style
     errorBorder: OutlineInputBorder(
         borderSide:
         BorderSide(color: ColorManager.error, width: AppSize.s1_5),
         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
       // focused error border style
       focusedErrorBorder: OutlineInputBorder(
           borderSide:
           BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
           borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

   ),

  );

}