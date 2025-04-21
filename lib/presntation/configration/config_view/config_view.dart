import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/common/state_render/state_render_impl.dart';
import 'package:responsive/presntation/configration/config_view_model/config_view_model.dart';

import '../../base/base_view_model.dart';
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
    Future.microtask(()=>ref.read(configProvider.notifier).start()) ;


  }

  @override
  void initState() {
    super.initState();
    bind();
  }
  Widget _getContentWidget(){
    final result=ref.watch(configProvider);
    return  SingleChildScrollView(
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
                ref.read(configProvider.notifier).summit(context,ref);
              }
                  : null,
              child: const Text(AppStrings.summit),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context ){

    return Scaffold(
      body: ref.watch(flowStateMangerProvider).getScreenWidget(context, _getContentWidget(), () {
        ref.read(configProvider.notifier).summit(context, ref);
      })
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
