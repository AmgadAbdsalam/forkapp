
import 'package:flutter/material.dart';

const String  English='en';
const String  ARABIC='ar';
const String ASSET_PATH_LOCALISATIONS = "assets/translations";

const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");
enum LanguageType{
  ENGLISH,ARABIC
}

extension LanguageMangerExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return English;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}