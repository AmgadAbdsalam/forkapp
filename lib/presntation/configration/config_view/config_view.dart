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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: yLine,
                  decoration: InputDecoration(
                      hintText: AppStrings.mapLength,
                      labelText: AppStrings.configError,
                      errorText: (result.isLengthValid) ? null : AppStrings.configError),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100,right: 100,left: 100),
                child:TextFormField(
                  keyboardType: TextInputType.text,
                  controller: xLine,
                  decoration: InputDecoration(
                      hintText: AppStrings.mapWidth,
                      labelText: AppStrings.configError,
                      errorText: (result.isWidthValid)
                          ? null :
                      AppStrings.configError),
                )),
                //   customTextFormFiled(
              //       textEditingController: xLine,
              //       hintText: AppStrings.mapWidth,
              //       errorText: AppStrings.configError,
              //       isValid: result.isWidthValid),
              // ),
              ElevatedButton(
                onPressed: result.isWidthAndLengthValid
                    ? () {
                  ref.watch(configProvider.notifier).summit(context);
                }
                    : null,
                child: const Text(AppStrings.summit),
              )
            ],
          ),
      ),
    );

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

}
