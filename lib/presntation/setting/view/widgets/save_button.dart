import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive/presntation/resources/color_manager.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s16),
                    topRight: Radius.circular(AppSize.s16)))),
            fixedSize: WidgetStateProperty.all(
                Size(MediaQuery.sizeOf(context).width, 92)),
            foregroundColor: WidgetStateProperty.all(ColorManager.lightOnPrimary)),
        onPressed: () {},
        child:  Text(AppStrings.save.tr()));
  }
}
