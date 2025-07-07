
import 'package:easy_localization/easy_localization.dart';

import '../../presntation/resources/assets_manager.dart';
import '../../presntation/resources/strings_manager.dart';
import '../models/models.dart';

class GetSliderData{
  List<SliderObject> execute() => [
    SliderObject(AppStrings.onBoardingTitle1.tr(),
        AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onboardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2.tr(),
        AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onboardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3.tr(),
        AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onboardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4.tr(),
        AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onboardingLogo4),
  ];
  SliderViewObject getInitialState(){
  return SliderViewObject(execute()[0], execute().length, 0);
    }
  }
