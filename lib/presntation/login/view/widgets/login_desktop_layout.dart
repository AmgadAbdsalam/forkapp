import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/login/view/widgets/login_section.dart';
import 'package:responsive/presntation/login/view/widgets/welcome_widget.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class LoginDesktopLayout extends StatelessWidget {
  const LoginDesktopLayout({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.userNameController,
    required this.result,
    required this.uerPasswordController,
    required this.ref,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController userNameController;
  final LoginStateModel result;
  final TextEditingController uerPasswordController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double buttonWidth = constraints.maxWidth * .2;
        double textFormFiled = constraints.maxWidth * .3;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s64),
            child: Row(
              children: [
                const WelcomeWidget(),
                LoginSection(
                  height: constraints.maxHeight * .3,
                  formKey: _formKey,
                  textFormFiled: textFormFiled,
                  userNameController: userNameController,
                  result: result,
                  uerPasswordController: uerPasswordController,
                  buttonWidth: buttonWidth,
                  ref: ref,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
