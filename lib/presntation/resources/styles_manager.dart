import 'package:flutter/material.dart';

import 'font_manager.dart';


TextStyle _getTextStyle (double fontSize,FontWeight fontWeigh,Color color,{FontStyle fontStyle=FontStyle.normal}){
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstant.fontFamily,
    fontStyle: fontStyle,
    fontWeight: fontWeigh,
    color: color
  );
}
// regular style
TextStyle getRegularStyle ({double fontSize=FontSize.s12,required Color color,FontStyle fontStyle=FontStyle.normal}){
  return _getTextStyle(fontSize,FontWeightManager.regular,color,fontStyle: fontStyle);
}
// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// bold style

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}