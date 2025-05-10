import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/app_prefs.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/base/base_view_model.dart';
import 'package:responsive/presntation/common/adaptive_layout.dart';
import 'package:responsive/presntation/common/state_render/state_render_impl.dart';
import 'package:responsive/presntation/login/view/widgets/login_desktop_layout.dart';
import 'package:responsive/presntation/login/view/widgets/login_mobile_layout.dart';
import 'package:responsive/presntation/login/view_model/login_view_model.dart';

import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController uerPasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  bind() {
    uerPasswordController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .setPassword(uerPasswordController.text));
    userNameController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .setUserName(userNameController.text));

    Future.microtask(() => ref.read(loginViewModelProvider.notifier).start());
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
    debugPrint('initstate called');
    bind();
  }

  Widget _getContentWidget() {
    final result = ref.watch(loginViewModelProvider);
    return Scaffold(
        body: AdaptiveLayout(
      desktopLayout: (context) => LoginDesktopLayout(
          formKey: _formKey,
          userNameController: userNameController,
          result: result,
          uerPasswordController: uerPasswordController,
          ref: ref),
      tabletLayout: (context) => LoginDesktopLayout(
          formKey: _formKey,
          userNameController: userNameController,
          result: result,
          uerPasswordController: uerPasswordController,
          ref: ref),
      mobileLayout: (context) => LoginMobileLayout(
          formKey: _formKey,
          userNameController: userNameController,
          result: result,
          uerPasswordController: uerPasswordController,
          ref: ref),
    ));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginStateModel>(loginViewModelProvider, (previous, next) {
      if (next.isUserSuccessfulLogin == true) {
        _appPreferences.setUserLoggedIn();
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            Navigator.of(context).pushReplacementNamed(Routes.mainRoute));
      }
    });
    return Scaffold(
      backgroundColor: ColorManager.lightOnPrimary,
      body: ref
          .watch(flowStateMangerProvider)
          .getScreenWidget(context, _getContentWidget(), () {
        ref.read(loginViewModelProvider.notifier).login();
      }),
    );
  }
}
