import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive/presntation/resources/color_manager.dart';
import 'package:responsive/presntation/resources/font_manager.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.appName.tr().toUpperCase(),
            style: TextStyle(
                fontSize: AppSize.s64,
                fontStyle: FontStyle.normal,
                fontFamily: FontConstant.fontFamily,
                fontWeight: FontWeight.bold,
                color: ColorManager.lightPrimaryVariant),
          ),
          Text(
            AppStrings.welcome.tr().toUpperCase(),
            style: TextStyle(
                fontFamily: FontConstant.fontFamily,
                fontSize: AppSize.s28,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: ColorManager.lightOnBackground),
          ),
          const SizedBox(
            height: AppSize.s28,
          ),
        ],
      ),
    );
  }
}
