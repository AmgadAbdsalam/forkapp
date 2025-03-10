// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/resources/routes_manager.dart';

import '../../common/freezed_data_classes.dart';

class ConfigViewModel extends StateNotifier<ConfigStateModel>
    implements ConfigViewModelInputs {
  ConfigViewModel() :super(ConfigStateModel(true, true, false));
  var configObject = ConfigObject('1', '1');

  @override
  setMapLength(String mapLength) {
    configObject= configObject.copyWith(mapLength: mapLength);

    _isMapLengthValid(mapLength);
    _isMapLengthAndMapWidthValid();

  }

  @override
  setMapWidth(String mapWidth) {
    configObject= configObject.copyWith(mapWidth: mapWidth);
    _isMapWidthValid(mapWidth);
   _isMapLengthAndMapWidthValid();
  }

  @override
  summit(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.mainRoute,);
  }

  bool _isMapWidthValid(String mapWidth) {
   // var result=double.tryParse(mapWidth);

      state = state.copyWith(isWidthValid: mapWidth.isNotEmpty);

    return  mapWidth.isNotEmpty;
  }

  bool _isMapLengthValid(String mapLength) {
  //  var result=double.tryParse(mapLength);
      state = state.copyWith(isLengthValid: mapLength.isNotEmpty);

  return mapLength.isNotEmpty;
  }

  bool _isMapLengthAndMapWidthValid() {
    bool result=_isMapWidthValid(configObject.mapWidth)&&_isMapLengthValid(configObject.mapLength);
    state=state.copyWith(isWidthAndLengthValid: result);
    return result;
  }
  //  String  sendMapLength(WidgetRef ref){
  //   ref.read(mapLengthProvider.notifier).state=configObject.mapLength;
  //   return ref.read(mapLengthProvider.notifier).state;
  // }


}

abstract class ConfigViewModelInputs {
  setMapWidth(String mapWidth);

  setMapLength(String mapLength);

  summit(BuildContext context);
}

final configProvider = StateNotifierProvider<ConfigViewModel,
    ConfigStateModel>((ref) => ConfigViewModel());

//  provider used to send data to  homeScreen from configScreen
final mapLengthProvider=StateProvider<String>((ref)=>'4');
