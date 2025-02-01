 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/common/state_render/state_render_impl.dart';

import '../common/state_render/state_render.dart';

abstract class BaseViewModel implements  BaseViewModelInputs  {
@override
  void start() {}
}

abstract class BaseViewModelInputs {
  void start();
}
/////////////////////////////////////////////
 //  flow state manger
 class FlowStateManger extends StateNotifier<FlowState>{
  FlowStateManger():super(ContentState());
  void setLoading(){
    state= LoadingState(stateRendererType: StateRendererType.popupLoadingState);
  }
  void setError(String message){
    state= ErrorState( StateRendererType.popupErrorState,message);
  }
  void setContent(){
    state= ContentState();
  }
  void setEmpty(String message){
    state= EmptyState(message);
  }
 }
 final flowStateMangerProvider=StateNotifierProvider<FlowStateManger,FlowState>((ref)=>FlowStateManger());
