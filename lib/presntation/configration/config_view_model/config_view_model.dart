// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/use_cases/update_map_usecase.dart';
import 'package:responsive/presntation/resources/routes_manager.dart';
import '../../base/base_view_model.dart';
import '../../common/freezed_data_classes.dart';

class ConfigViewModel extends StateNotifier<ConfigStateModel>
    implements ConfigViewModelInputs {
  ConfigViewModel(this._updateMapUsecase) :super(ConfigStateModel(true, true, false));
  var configObject = ConfigObject('1', '1');
final UpdateMapUsecase _updateMapUsecase;
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
  summit(BuildContext context,WidgetRef ref) async{
  int mapWidth=double.tryParse(configObject.mapWidth)!.round() ;
  int mapLength=double.tryParse(configObject.mapLength)!.round() ;
  ref.read(flowStateMangerProvider.notifier).setLoading();
   List<NodeModel> nodes= List.generate(mapWidth* mapLength, (index) {
      return NodeModel(
          nodeId: index,
          updatedTime: Timestamp.now(),
          xAxis: index % mapWidth,
          yAxis: index ~/ mapLength,
          isFree: true,
          isCharged: false,
          isBlocked: false);
    });

  ( await _updateMapUsecase.execute(nodes)).fold((failure){
    ref.read(flowStateMangerProvider.notifier).setError(failure.message);
    print(failure.message);
    print('errrrrrrrrrrrrorrrrr');
  }, (data){
    Navigator.of(context).pushReplacementNamed(Routes.mainRoute,);
    print('amggggggggggggggggggad');
  });

  }


  bool _isMapWidthValid(String mapWidth) {
    var result=double.tryParse(mapWidth);

      state = state.copyWith(isWidthValid: mapWidth.isNotEmpty && result!=null);

    return  mapWidth.isNotEmpty && result!=null;
  }

  bool _isMapLengthValid(String mapLength) {
    var result=double.tryParse(mapLength);
      state = state.copyWith(isLengthValid: mapLength.isNotEmpty && result!=null);

  return mapLength.isNotEmpty&& result!=null;
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

  summit(BuildContext context,WidgetRef ref);
}

final configProvider = StateNotifierProvider<ConfigViewModel,
    ConfigStateModel>((ref) => ConfigViewModel(instance<UpdateMapUsecase>()));

//  provider used to send data to  homeScreen from configScreen
final mapLengthProvider=StateProvider<String>((ref)=>'4');
