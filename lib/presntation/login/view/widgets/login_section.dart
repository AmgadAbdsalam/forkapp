import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/login/view_model/login_view_model.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.textFormFiled,
    required this.userNameController,
    required this.result,
    required this.uerPasswordController,
    required this.buttonWidth,
    required this.ref,
    required this.height,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final double textFormFiled;
  final TextEditingController userNameController;
  final LoginStateModel result;
  final TextEditingController uerPasswordController;
  final double buttonWidth;
  final WidgetRef ref;
  final double height;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Expanded(
      flex: 1,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: height,
                // Adjust image height based on screen size
                child: const Image(image: AssetImage(ImageAssets.splashLogo)),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: SizedBox(
                width: textFormFiled.clamp(220, 840),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: userNameController,
                  decoration: InputDecoration(
                      hintText: AppStrings.id,
                      labelText: AppStrings.id,
                      errorText: (result.isUsernameValid)
                          ? null
                          : AppStrings.usernameError),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: SizedBox(
                width: textFormFiled.clamp(220, 840),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: uerPasswordController,
                  decoration: InputDecoration(
                      hintText: AppStrings.password,
                      labelText: AppStrings.password,
                      errorText: result.isPasswordValid
                          ? null
                          : AppStrings.passwordError),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            textFormFiled < 840
                ? const SizedBox(
                    width: 15,
                  )
                : const SizedBox(
                    width: 0,
                  ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                  top: AppPadding.p_5),
              child: SizedBox(
                width: buttonWidth.clamp(200, 800),
                // Adjust button width based on screen size
                child: ElevatedButton(
                  onPressed: result.isPasswordAndUserNameValid
                      ? () {
                          ref.watch(loginViewModelProvider.notifier).login();
                        }
                      : null,
                  child: const Text(
                    AppStrings.login,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            TextButton(
              child: const Text(AppStrings.forgetPassword),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
