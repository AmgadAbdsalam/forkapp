import 'package:flutter/cupertino.dart';

import '../../presntation/resources/assets_manager.dart';
import '../../presntation/resources/strings_manager.dart';
import '../models/models.dart';

class GetSliderData{
  List<SliderObject> execute() => [
    SliderObject(AppStrings.onBoardingTitle1,
        AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2,
        AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3,
        AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4,
        AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
  ];
  SliderViewObject getInitialState(){
  return SliderViewObject(execute()[0], execute().length, 0);
    }
  }
