import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/use_cases/map_data_usecase.dart';
import 'package:responsive/presntation/base/base_view_model.dart';

import '../../../app/di.dart';
import '../../../domain/models/models.dart';

class HomeViewModel extends StateNotifier<HomeState>
    implements HomeViewInputs {
  HomeViewModel(this.ref, this.mapDataUseCase) : super(HomeState.initial());
  final Ref ref;
  final MapDataUseCase mapDataUseCase;

  @override
  void start(int numIconsX, int numIconsY) {

    getNodesFromFireBase();
  }


  @override
  updateIcon(int index, String dialogNodeText) {
    /*switch (dialogNodeText) {
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
    }*/
  }

  @override
 void getNodesFromFireBase() async{
    void dummy;
    state = HomeState.loading();
    final result = await mapDataUseCase.execute(dummy);

    result.fold(
          (failure) {
        state = HomeState.error(failure.message);
      },
          (data) {
        if (data.isEmpty) {
          state = HomeState.empty('No data');
        } else {
          state = HomeState.success(data);
        }
      },
    );
  }
 }

  abstract class HomeViewInputs {
  void start(int numIconsX, int numIconsY);
  getNodesFromFireBase();

  updateIcon(int index, String dialogNodeText);
}

final homeProvider = StateNotifierProvider<HomeViewModel, HomeState>(
    (ref) => HomeViewModel(ref,instance<MapDataUseCase>()));
