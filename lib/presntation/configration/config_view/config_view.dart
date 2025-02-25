import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/configration/config_view_model/config_view_model.dart';

import '../../resources/strings_manager.dart';

class ConfigView extends ConsumerStatefulWidget {
  const ConfigView({super.key});

  @override
  ConfigViewState createState() =>ConfigViewState();
}
class ConfigViewState extends ConsumerState<ConfigView>{
  final TextEditingController yLine = TextEditingController();
  final TextEditingController xLine = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bind(){
    yLine.addListener(() => ref.read(configProvider.notifier).setMapLength(yLine.text));
    xLine.addListener(() => ref.read(configProvider.notifier).setMapWidth(xLine.text));
  }

  @override
  void initState() {
    super.initState();
    bind();
  }

  @override
  Widget build(BuildContext context ){
    final result=ref.watch(configProvider);
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: customTextFormFiled(
                    textEditingController: yLine,
                    hintText: AppStrings.mapLength,
                    errorText: AppStrings.configError,
                    isValid: result.isLengthValid),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100,right: 100,left: 100),
                child: customTextFormFiled(
                    textEditingController: xLine,
                    hintText: AppStrings.mapWidth,
                    errorText: AppStrings.configError,
                    isValid: result.isWidthValid),
              ),
              ElevatedButton(
                onPressed: result.isWidthAndLengthValid
                    ? () {
                  ref.read(configProvider.notifier).summit(context);
                }
                    : null,
                child: const Text(AppStrings.summit),
              )
            ],
          ),
        ),
      );

  }
}

Widget customTextFormFiled(
    {required TextEditingController textEditingController,
    required String hintText,
    required String errorText,
    required bool isValid}) {
  return TextFormField(
    keyboardType: TextInputType.number,
    controller: textEditingController,
    decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        errorText: (isValid) ? null : AppStrings.configError),
  );
}
