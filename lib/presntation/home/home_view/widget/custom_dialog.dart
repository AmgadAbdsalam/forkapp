import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import 'custom_dialog_listile.dart';

class CustomDialog extends ConsumerWidget {
  const CustomDialog({super.key, required this.nodeModel});
  final NodeModel nodeModel;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
      List<String> dialogText=[AppStrings.free.tr(),AppStrings.charged.tr(),AppStrings.blocked.tr(),AppStrings.product.tr()];
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.lightOnPrimary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        height: 250,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomDialogLisTile(dialogText[0],nodeModel),
            CustomDialogLisTile(dialogText[1],nodeModel),
            CustomDialogLisTile(dialogText[2],nodeModel),
            CustomDialogLisTile(dialogText[3],nodeModel),

            // Center(child: ElevatedButton(onPressed: (){
            //   ref.read(homeProvider.notifier).getRobotAndPath(nodeModel,context);
            // }, child: const Text('target'))),
          ],
        ),
      ),
    );
  }
}
