import 'package:flutter/material.dart';
import 'package:responsive/presntation/setting/view/widgets/setting_selection.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingSelection()
    );
  }
}
