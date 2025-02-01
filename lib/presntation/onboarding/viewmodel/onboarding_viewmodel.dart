import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/base/base_view_model.dart';

import '../../../domain/use_cases/get_slider_data.dart';

class OnBoardingViewModel  extends StateNotifier<SliderViewObject>
    implements BaseViewModel, LoginViewModelInputs {
  OnBoardingViewModel():super(GetSliderData().getInitialState());
int currentIndex=0;
late final List<SliderObject> list;

  @override
  int goNext() {
    int nextIndex = ++currentIndex;
    if (nextIndex == list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --currentIndex;
    if (previousIndex == -1) {
      previousIndex = list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(index) {
currentIndex=index;
getSliderViewObject();

  }

  @override
  void start() {
    list=GetSliderData().execute();
    getSliderViewObject();
  }
  
 void getSliderViewObject(){
    state=SliderViewObject(list[currentIndex], list.length, currentIndex);
  }

}

abstract class LoginViewModelInputs {
void onPageChanged(index);
int goPrevious();
int goNext();
}

final onBoardingProvider =StateNotifierProvider<OnBoardingViewModel,SliderViewObject>((ref)=>OnBoardingViewModel());