import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/app_prefs.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/presntation/resources/color_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';
import 'package:responsive/providers/on_boarding_provider.dart';
import '../../common/adaptive_layout.dart';
import '../../resources/constant_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingView extends ConsumerStatefulWidget {
  const OnBoardingView({super.key});

  @override
  OnBoardingViewState createState() => OnBoardingViewState();
}

class OnBoardingViewState extends ConsumerState<OnBoardingView> {
  final PageController pageController = PageController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    Future.microtask(() =>
        ref.read(onBoardingHelperProvider).onBoardingAccessMethod().start());
    _appPreferences.setOnBoardingScreenViewed();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: AdaptiveLayout(
          mobileLayout: (BuildContext context) =>  DeskTopOnBoardingPage(pageController),
          tabletLayout: (BuildContext context) =>  DeskTopOnBoardingPage(pageController),
          desktopLayout: (BuildContext context) =>
              DeskTopOnBoardingPage(pageController),
        ));
  }
}

class DeskTopOnBoardingPage extends ConsumerWidget {
  final PageController pageController;

  const DeskTopOnBoardingPage(this.pageController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onBoardingHelper = ref.watch(onBoardingHelperProvider);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                ref
                    .watch(onBoardingHelperProvider)
                    .onBoardingAccessMethod()
                    .onPageChanged(index);
              },
              itemCount: ref
                  .watch(onBoardingHelperProvider)
                  .onBoardingReadState()
                  .numOfSlides,
              itemBuilder: (context, index) =>
                  getPage(context, ref, pageController)),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                    onPressed: () {
                      pageController.animateToPage(
                          onBoardingHelper.onBoardingAccessMethod().goPrevious(),
                          duration: const Duration(
                              milliseconds: ConstantManager.sliderAnimationTime),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                // ...[0,1,2,3].map((e) => (currentIndex==e?const Icon(Icons.star):buildContainer())),
                for (int i = 0;
                    i < onBoardingHelper.onBoardingWatchState().numOfSlides;
                    i++)
                  onBoardingHelper.onBoardingWatchState().currentIndex == i
                      ? buildContainer(ColorManager.darkError)
                      : buildContainer(ColorManager.darkGrey),

                IconButton(
                    onPressed: () {
                      pageController.animateToPage(
                          onBoardingHelper.onBoardingAccessMethod().goNext(),
                          duration: const Duration(
                              milliseconds: ConstantManager.sliderAnimationTime),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
            ),
          ],
        )
      ],
    );
  }
}

    Widget getPage(
    BuildContext context, WidgetRef ref, PageController pageController) {
  final onBoardingHelper = ref.watch(onBoardingHelperProvider);
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Image.asset(
          onBoardingHelper.onBoardingWatchState().sliderObject.image,
        ),
      ),
      Text(
        textAlign: TextAlign.center,
        onBoardingHelper.onBoardingWatchState().sliderObject.title.tr(),
        style: Theme.of(context).textTheme.displayLarge,
      ),
      Text(
        textAlign: TextAlign.center,
        onBoardingHelper.onBoardingWatchState().sliderObject.subTitle.tr(),
        style: Theme.of(context).textTheme.displayMedium,
      ),
      // Flexible(child: SizedBox(height: height* 1/4,),),
      //  Flexible(child: SizedBox(height: height* 1/5)),
    ],
  );
}

Widget buildContainer(Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,),
    child: Container(
      height: AppSize.s12,
      width: AppSize.s12,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.s12)),
    ),
  );
}
Widget getElevatedButton(BuildContext context,String text){
  return      ElevatedButton(
      style: ButtonStyle(
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSize.s16),
                 ))),
          minimumSize: WidgetStateProperty.all(
              Size(MediaQuery.sizeOf(context).width * 3 / 7, 50)),
          maximumSize: WidgetStateProperty.all(
              Size(MediaQuery.sizeOf(context).width*3/5, 82)),
          foregroundColor:
          WidgetStateProperty.all(ColorManager.lightOnPrimary)),
      onPressed: () {},
      child:  Text(text));
}