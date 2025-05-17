import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/home/home_view_model/home_view_model.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import 'custom_dialog_listile.dart';

class CustomDialog extends ConsumerWidget {
  const CustomDialog({super.key, required this.nodeModel});
  final NodeModel nodeModel;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
      List<String> dialogText=['free','charged','blocked','robot target'];
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

            Center(child: ElevatedButton(onPressed: (){
              ref.read(homeProvider.notifier).getRobotAndPath(nodeModel,context);
            }, child: const Text('target'))),
          ],
        ),
      ),
    );
  }
}
