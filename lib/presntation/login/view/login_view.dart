import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/app_prefs.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/base/base_view_model.dart';
import 'package:responsive/presntation/common/state_render/state_render_impl.dart';
import 'package:responsive/presntation/login/view_model/login_view_model.dart';
import 'package:responsive/providers/login_provider.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController uerPasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences=instance<AppPreferences>();

  bind() {
    uerPasswordController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .setPassword(uerPasswordController.text));
    userNameController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .setUserName(userNameController.text));

  Future.microtask(()=>ref.read(loginViewModelProvider.notifier).start());

    }
    // ref.read(loginViewModelProvider.notifier).userLogin.stream.listen((event){
    //   if(event){
    //     SchedulerBinding.instance.addPostFrameCallback((_)=>Navigator.of(context).pushReplacementNamed(Routes.mainRoute));
    //   }
    // }
    // );


  @override
  void initState() {
    super.initState();
    print('initstate called');
    bind();
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget _getContentWidget() {
    final result = ref.watch(loginViewModelProvider);
    return
       LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            padding: const EdgeInsets.only(top: AppPadding.p100),
            color: ColorManager.white,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: constraints.maxWidth * 0.5,
                        // Adjust image width based on screen size
                        height: constraints.maxWidth * 0.5,
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
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: userNameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (result.isUsernameValid ?? true)
                                ? null
                                : AppStrings.usernameError),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
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
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: SizedBox(
                        width: constraints.maxWidth * 0.8,
                        // Adjust button width based on screen size
                        child: ElevatedButton(
                          onPressed: result.isPasswordAndUserNameValid
                              ? () {
                                  ref
                                      .watch(loginViewModelProvider.notifier)
                                      .login();

                                }
                              : null,
                          child: const Text(AppStrings.login),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppPadding.p8,
                          left: AppPadding.p10,
                          right: AppPadding.p28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            // Use Flexible for better responsiveness
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.forgotPasswordRoute);
                              },
                              child: Text(AppStrings.forgetPassword,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                          ),
                          Flexible(
                            // Use Flexible for better responsiveness
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.registerRoute);
                              },
                              child: Text(AppStrings.registerText,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                          ),
                        ],
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

  @override
  Widget build(BuildContext context) {
     ref.listen<LoginStateModel>(loginViewModelProvider, (previous,next){
      if(next.isUserSuccessfulLogin==true){
        _appPreferences.setUserLoggedIn();
     WidgetsBinding.instance.addPostFrameCallback((_)=>Navigator.of(context).pushReplacementNamed(Routes.mainRoute)) ;
      }
    });
    return  Scaffold(
      backgroundColor: ColorManager.white,
      body:ref
          .watch(flowStateMangerProvider)
          .getScreenWidget(context, _getContentWidget(), () {
        ref.watch(loginViewModelProvider.notifier).login();
      }),
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
