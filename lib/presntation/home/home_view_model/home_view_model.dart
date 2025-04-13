import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di.dart';
import '../../../domain/models/models.dart';

class HomeViewModel extends StateNotifier<List<NodeModel>>
    implements HomeViewInputs {
  HomeViewModel() : super([]);

  @override
  void start(int numIconsX, int numIconsY) {

    initUpdateMapModule();
    state = List.generate(numIconsX * numIconsY, (index) {
      return NodeModel(
          nodeId: index,
          updatedTime: Timestamp.now(),
          xAxis: index % numIconsX,
          yAxis: index ~/ numIconsX,
          isFree: true,
          isCharged: false,
          isBlocked: false);
    });
  }

  @override
  updateIcon(int index, String dialogNodeText) {
    switch (dialogNodeText) {
      case ('free'):
        {
          state[index] = state[index]
              .copyWith(isFree: true, isBlocked: false, isCharged: false);
        }
      case ('charged'):
        {
          state[index] = state[index]
              .copyWith(isFree: false, isBlocked: false, isCharged: true);
        }
      case ('blocked'):
        {
          state[index] = state[index]
              .copyWith(isFree: false, isBlocked: true, isCharged: false);
        }
    }
  }
}

abstract class HomeViewInputs {
  void start(int numIconsX, int numIconsY);

  updateIcon(int index, String dialogNodeText);
}

final homeProvider = StateNotifierProvider<HomeViewModel, List<NodeModel>>(
    (ref) => HomeViewModel());
