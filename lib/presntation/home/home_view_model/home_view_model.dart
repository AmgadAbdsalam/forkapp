import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/helper_functions.dart';
import 'package:responsive/domain/use_cases/edit_node_usecase.dart';
import 'package:responsive/domain/use_cases/map_data_usecase.dart';

import '../../../app/di.dart';
import '../../../domain/models/models.dart';

class HomeViewModel extends StateNotifier<HomeState>
    implements HomeViewInputs {
  HomeViewModel(this.ref, this.mapDataUseCase, this.editNodeUseCase) : super(HomeState.initial());
  final Ref ref;
  final MapDataUseCase mapDataUseCase;
  final EditNodeUseCase editNodeUseCase;

  @override
  void start(int numIconsX, int numIconsY) {
    getNodesFromFireBase();

  }


  @override
  updateIcon(NodeModel node,String text,BuildContext context) async{
    switch (text) {
      case ('free'):
        {
      node=   node.copyWith(isFree: true, isBlocked: false, isCharged: false);
        }
      case ('charged'):
        {
        node=  node.copyWith(isFree: false, isBlocked: false, isCharged: true);
        }
      case ('blocked'):
        {
        node= node.copyWith(isFree: false, isBlocked: true, isCharged: false);
        }
    }
    state=HomeState.loading();
    Navigator.of(context).pop();
    (await editNodeUseCase.execute(node)).fold((failure){
      state=HomeState.error(failure.message);
    }, (data)async{
        getNodesFromFireBase();

    });

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
       //  state= state.copyWith(nodes: data);
        }
      },
    );
  }

  @override
  getRobotAndPath(NodeModel node,BuildContext context) async{
    state = HomeState.loading();
    Navigator.of(context).pop();
    final result = await getNearestRobot(node.xAxis, node.yAxis);
    result.fold(
            (failure){
              state = HomeState.error(failure.message);

            },

            (data){
              getNodesFromFireBase();
            });
  }



 }

  abstract class HomeViewInputs {
  void start(int numIconsX, int numIconsY);

  getNodesFromFireBase();
  updateIcon(NodeModel node,String text,BuildContext context);
getRobotAndPath(NodeModel node,BuildContext context);

}

final homeProvider = StateNotifierProvider<HomeViewModel, HomeState>(
    (ref) => HomeViewModel(ref,instance<MapDataUseCase>(),instance<EditNodeUseCase>()));
