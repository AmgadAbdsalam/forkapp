
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/use_cases/update_map_usecase.dart';
import '../../base/base_view_model.dart';
import '../../common/freezed_data_classes.dart';

class ConfigViewModel extends StateNotifier<ConfigStateModel>
    implements ConfigViewModelInputs, BaseViewModel {
  ConfigViewModel(
    this._updateMapUseCase,
  ) : super(ConfigStateModel(true, true, false));
   var configObject = ConfigObject('', '');
  HomeStateFinalResult homeStateFinalResult =
      HomeStateFinalResult(width: 0, length: 0);
  final UpdateMapUsecase _updateMapUseCase;

  @override
  void start() {
    state = state.copyWith(isWidthAndLengthValid: false);
  }

  @override
  setMapLength(String? mapLength) {
    configObject = configObject.copyWith(mapLength: mapLength);
    _isMapLengthValid(mapLength) == false
        ? state = state.copyWith(isLengthValid: false)
        : state = state.copyWith(isLengthValid: true);
    _isMapLengthAndMapWidthValid();
  }

  @override
  setMapWidth(String? mapWidth) {
    configObject = configObject.copyWith(mapWidth: mapWidth);
    _isMapWidthValid(mapWidth) == false
        ? state = state.copyWith(isWidthValid: false)
        : state = state.copyWith(isWidthValid: true);
    _isMapLengthAndMapWidthValid();
  }

  @override
  summit(BuildContext context, WidgetRef ref) async {
    ref.read(flowStateMangerProvider.notifier).setLoading();
    int mapWidth = homeStateFinalResult.width;
    int mapLength = homeStateFinalResult.length;
    List<NodeModel> nodes = List.generate(mapWidth * mapLength, (index) {
      return NodeModel(
          nodeId: index,
          updatedTime: Timestamp.now(),
          xAxis: index % mapWidth,
          yAxis: index ~/ mapWidth,
          isFree: true,
          isCharged: false,
          isBlocked: false);
    });

    (await _updateMapUseCase.execute(nodes)).fold((failure) {
      ref.read(flowStateMangerProvider.notifier).setError(failure.message);
    }, (data) {

      ref.read(flowStateMangerProvider.notifier).setContent();
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => Navigator.of(context).pop(true));
      dismissDialog(context);
    });
  }

  bool _isMapWidthValid(String? mapWidth) {
    if (mapWidth == null || mapWidth.trim().isEmpty) return false;
    final positiveIntRegex = RegExp(r'^\d+$');

    if (!positiveIntRegex.hasMatch(mapWidth)) return false;
    try {
      int value = int.parse(mapWidth);
      homeStateFinalResult = homeStateFinalResult.copyWith(width: value);
      state = state.copyWith(isWidthValid: true);
      return value >= 0;
    } catch (_) {
      state = state.copyWith(isWidthValid: false);
      return false;
    }
  }

  bool _isMapLengthValid(String? mapLength) {
    if (mapLength == null || mapLength.trim().isEmpty) return false;
    final positiveIntRegex = RegExp(r'^\d+$');

    if (!positiveIntRegex.hasMatch(mapLength)) return false;
    try {
      int value = int.parse(mapLength);
      homeStateFinalResult = homeStateFinalResult.copyWith(length: value);
      state = state.copyWith(isLengthValid: true);
      return value >= 0;
    } catch (_) {
      state = state.copyWith(isLengthValid: false);
      return false;
    }
  }

  bool _isMapLengthAndMapWidthValid() {
    bool result = _isMapWidthValid(configObject.mapWidth) &&
        _isMapLengthValid(configObject.mapLength);
    state = state.copyWith(isWidthAndLengthValid: result);
    return result;
  }
}
_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;
dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

abstract class ConfigViewModelInputs {
  setMapWidth(String? mapWidth);

  setMapLength(String? mapLength);

  summit(BuildContext context, WidgetRef ref);
}

final configProvider = StateNotifierProvider<ConfigViewModel, ConfigStateModel>(
    (ref) => ConfigViewModel(instance<UpdateMapUsecase>()));


//  provider used to send data to  homeScreen from configScreen
