import 'package:flutter/material.dart';
import 'package:responsive/domain/models/models.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import 'custom_dialog_Listile.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.nodeModel});
  final NodeModel nodeModel;
 static const List<String> dialogText=['free','charged','blocked'];
  @override
  Widget build(BuildContext context) {
      List<String> dialogText=['free','charged','blocked'];
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
          ],
        ),
      ),
    );
  }
}
