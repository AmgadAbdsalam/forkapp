// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/common/state_render/state_render.dart';

import '../../../app/constant.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState{
  String getMessage();
  StateRendererType getStateRendererType();
}
// loading state (POPUP,FULL SCREEN)
class ContentHomeState extends FlowState{

  ContentHomeState();

  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

}
class LoadingState implements FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(
      {required this.stateRendererType,  this.message = AppStrings.loading});

  @override
  String getMessage() => message ;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}
// error state (POPUP,FULL SCREEN)
class ErrorState implements FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state

class ContentState implements FlowState {
  ContentState();

  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// EMPTY STATE

class EmptyState implements FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState :
        {
          print('loding a7aaaaaaa');
          dismissDialog(context);
         if(getStateRendererType() == StateRendererType.popupLoadingState){
           showPopup(context, getStateRendererType(), getMessage(),(){});
           return contentScreenWidget;
         }else{
           return StateRenderer(stateRendererType: getStateRendererType(),message: getMessage(), retryActionFunction: (){});
         }
        }
      case ErrorState :
        {
          dismissDialog(context);
          if(getStateRendererType() == StateRendererType.popupErrorState){
            showPopup(context, getStateRendererType(), getMessage(),retryActionFunction);
            return contentScreenWidget;
          }else{
            return StateRenderer(stateRendererType: getStateRendererType(), retryActionFunction:retryActionFunction,message: getMessage(),);
          }
        }
      case EmptyState :
        {
       return StateRenderer(stateRendererType: getStateRendererType(), retryActionFunction: (){},message: getMessage(),) ;
        }
      case ContentHomeState :

        {
          return contentScreenWidget;
        }
      case ContentState :
        {
          print('a7aaaaaaaa');
        dismissDialog(context);
         return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }
  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message,Function retryActionFunction) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                StateRenderer(
                    stateRendererType: stateRendererType,
                    message: message,
                    retryActionFunction: retryActionFunction)));
  }
}
//final isDismiss=StateProvider((ref)=>true);