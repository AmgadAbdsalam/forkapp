// ignore_for_file: constant_identifier_names

enum LanguageType{
  ENGLISH,ARABIC
  }
   const String  English='en';
   const String  ARABIC='ar';
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