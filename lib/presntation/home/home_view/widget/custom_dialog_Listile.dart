import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/home/home_view_model/home_view_model.dart';

class CustomDialogLisTile extends ConsumerWidget {
 const  CustomDialogLisTile(this.textNodeType, this.nodeModel, {super.key});
final String textNodeType;
final NodeModel nodeModel;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  ListTile(
      leading: TextButton(onPressed: () {
      // ref.read(homeProvider.notifier).updateIcon(nodeModel.nodeId, textNodeType);
       Navigator.of(context).pop();
      }, child:  Text(textNodeType)),
      trailing:(nodeModel.isFree==true && textNodeType =='free')||
    (nodeModel.isCharged==true && textNodeType =='charged') ||
    (nodeModel.isBlocked==true && textNodeType =='blocked')?const Icon(Icons.check):const SizedBox());
  }
}
