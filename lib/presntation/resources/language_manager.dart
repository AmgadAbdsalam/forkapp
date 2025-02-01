enum LanguageType{
  ENGLISH,ARABIC
  }
   const String  English='en';
   const String  ARABIC='en';
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