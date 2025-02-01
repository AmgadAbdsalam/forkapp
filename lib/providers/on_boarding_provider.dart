import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';

import '../presntation/onboarding/viewmodel/onboarding_viewmodel.dart';


final onBoardingHelperProvider=Provider<AccessOnBoardingProviders>((ref)=>AccessOnBoardingProviders(ref));
class AccessOnBoardingProviders{
  final Ref ref;
  AccessOnBoardingProviders(this.ref);
  OnBoardingViewModel  onBoardingAccessMethod(){
    return ref.read(onBoardingProvider.notifier);
  }
  SliderViewObject  onBoardingWatchState(){
    return ref.watch(onBoardingProvider);
  }
  SliderViewObject  onBoardingReadState(){
    return ref.read(onBoardingProvider);
  }
}