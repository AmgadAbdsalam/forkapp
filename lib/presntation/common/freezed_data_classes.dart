import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

//   Login
@freezed
class LoginObject with _$LoginObject{
  factory LoginObject (String useName ,String password)=_LoginObject;
}

// map parameter
@freezed
class ConfigObject with _$ConfigObject{
  factory ConfigObject (String  mapWidth ,String mapLength)=_ConfigObject;
}

// map icon state
@freezed
class HomeStateModel with _$HomeStateModel{
  factory HomeStateModel (bool  isFree ,bool isCharge,bool isBlocked)=_HomeStateModel;
}