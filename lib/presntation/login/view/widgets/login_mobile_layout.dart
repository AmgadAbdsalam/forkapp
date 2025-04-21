import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/login/view_model/login_view_model.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class LoginMobileLayout extends StatelessWidget {
  const LoginMobileLayout({
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
        double buttonWidth = constraints.maxWidth * .8;
        double textFormFiled = constraints.maxWidth * .9;
        return Container(
          padding: const EdgeInsets.only(top: AppPadding.p100),
          // color: ColorManager.lightOnPrimary,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: constraints.maxHeight * .15,
                      // Adjust image height based on screen size
                      child: const Image(
                          image: AssetImage(ImageAssets.splashLogo)),
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
                    height: AppSize.s8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(AppStrings.forgetPassword),
                        onPressed: () {},
                      ),
                      textFormFiled < 840
                          ? const SizedBox(
                              width: 15,
                            )
                          : const SizedBox(
                              width: 0,
                            ),
                    ],
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
                                ref
                                    .watch(loginViewModelProvider.notifier)
                                    .login();
                              }
                            : null,
                        child: const Text(
                          AppStrings.login,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:responsive/app/di.dart';
// import 'package:responsive/presntation/login/view_model/login_view_model.dart';
// import 'package:responsive/providers/login_provider.dart';
//
// import '../../resources/assets_manager.dart';
// import '../../resources/color_manager.dart';
// import '../../resources/routes_manager.dart';
// import '../../resources/strings_manager.dart';
// import '../../resources/values_manager.dart';
//
// class LoginView extends ConsumerStatefulWidget {
//   const LoginView({super.key});
//
//   @override
//   LoginViewState createState() => LoginViewState();
// }
//
// class LoginViewState extends ConsumerState<LoginView> {
//
//   final TextEditingController uerPasswordController=TextEditingController();
//   final TextEditingController userNameController=TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   bind(){
//     uerPasswordController.addListener(()=>ref.watch(loginViewModelProvider.notifier).setPassword(uerPasswordController.text));
//     userNameController.addListener(()=>ref.watch(loginViewModelProvider.notifier).setUserName(userNameController.text));
//   }
//   @override
//   void initState() {
//     super.initState();
//     bind();
//   }
//   @override
//   void dispose() {
//     super.dispose();
//   }
//   Widget _getContentWidget() {
//     final result=ref.watch(loginViewModelProvider);
//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       body: Container(
//         padding: const EdgeInsets.only(top: AppPadding.p100),
//         color: ColorManager.white,
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Center(
//                     child: Image(image: AssetImage(ImageAssets.splashLogo))),
//                 const SizedBox(
//                   height: AppSize.s28,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: AppPadding.p28, right: AppPadding.p28),
//                   child: TextFormField(
//                     keyboardType: TextInputType.emailAddress,
//                     controller: userNameController,
//                     decoration: InputDecoration(
//                         hintText: AppStrings.username,
//                         labelText: AppStrings.username,
//                         errorText: (result.isUsernameValid ?? true)
//                             ? null
//                             : AppStrings.usernameError),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: AppSize.s28,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: AppPadding.p28, right: AppPadding.p28),
//                   child: TextFormField(
//                     keyboardType: TextInputType.visiblePassword,
//                     controller: uerPasswordController,
//                     decoration: InputDecoration(
//                         hintText: AppStrings.password,
//                         labelText: AppStrings.password,
//                         errorText: result.isPasswordValid
//                             ? null
//                             : AppStrings.passwordError),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: AppSize.s28,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: AppPadding.p28, right: AppPadding.p28),
//                   child: ElevatedButton(onPressed:
//                      result.isPasswordAndUserNameValid  ? (){
//                     ref.watch(loginViewModelProvider.notifier).login();
//                   }:null,
//                       child: const Text(AppStrings.login)),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         top: AppPadding.p8,
//                         left: AppPadding.p10,
//                         right: AppPadding.p28),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pushReplacementNamed(
//                                 context, Routes.forgotPasswordRoute);
//                           },
//                           child: Text(AppStrings.forgetPassword,
//                               style: Theme.of(context).textTheme.titleMedium),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pushReplacementNamed(
//                                 context, Routes.registerRoute);
//                           },
//                           child: Text(AppStrings.registerText,
//                               style: Theme.of(context).textTheme.titleMedium),
//                         )
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return _getContentWidget();
//   }
// }
