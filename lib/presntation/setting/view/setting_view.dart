import 'package:flutter/material.dart';
import 'package:responsive/presntation/setting/view/widgets/save_button.dart';
import 'package:responsive/presntation/setting/view/widgets/setting_selection.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [Expanded(child: SettingSelection()), SaveButton()],
      ),
    );
  }
}