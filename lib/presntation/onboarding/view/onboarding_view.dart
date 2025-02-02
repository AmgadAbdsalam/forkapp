import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/app_prefs.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/presntation/resources/color_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';
import 'package:responsive/providers/on_boarding_provider.dart';
import '../../resources/constant_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OnBoardingView extends ConsumerStatefulWidget {
  const OnBoardingView({super.key});

  @override
  OnBoardingViewState createState() => OnBoardingViewState();
}

class OnBoardingViewState extends ConsumerState<OnBoardingView> {

 final PageController _pageController = PageController();
final AppPreferences _appPreferences=instance<AppPreferences>();

 @override
  void initState() {
   Future.microtask(()=>ref.read(onBoardingHelperProvider).onBoardingAccessMethod().start());
   _appPreferences.setOnBoardingScreenViewed();
   super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
      elevation: 0,
        backgroundColor: ColorManager.white,
        systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index){
          ref.watch(onBoardingHelperProvider).onBoardingAccessMethod().onPageChanged(index);
        },
        itemCount:ref.watch(onBoardingHelperProvider).onBoardingReadState().numOfSlides,
        itemBuilder: (context,index){
          return OnBoardingPage(_pageController);
        },
      ),

    );
  }
}

class OnBoardingPage extends ConsumerWidget{

  final  PageController _pageController;
    const OnBoardingPage( this._pageController,{super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final onBoardingHelper=ref.watch(onBoardingHelperProvider);
   return Column(
     children: [
       Text(
         onBoardingHelper.onBoardingWatchState().sliderObject.title,
         style: Theme.of(context).textTheme.displayLarge,
       ),
       Padding(
         padding: EdgeInsets.all(height *.1/8),
         child: Text(
           textAlign: TextAlign.center,
           onBoardingHelper.onBoardingWatchState().sliderObject.subTitle,
           style: Theme.of(context).textTheme.displayMedium,
         ),
       ),
       Flexible(child: SizedBox(height: height* 1/4,),),
       SvgPicture.asset(onBoardingHelper.onBoardingWatchState().sliderObject.image,),
       Flexible(child: SizedBox(height: height* 1/5)),
       Container(
         width: width,
         color: ColorManager.white,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.end,
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         Padding(
           padding: const EdgeInsets.all(AppPadding.p8),
           child: TextButton(onPressed: (){
             Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
           }, child:  Text(AppStrings.skip,style: Theme.of(context).textTheme.bodySmall,)),
         ),
         Container(
           height: height*1/18,
           width: width,
           color: ColorManager.primary,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               IconButton(
                   onPressed: (){
                     _pageController.animateToPage(onBoardingHelper.onBoardingAccessMethod().goPrevious(),
                         duration: const Duration(
                             milliseconds: ConstantManager.sliderAnimationTime),
                         curve: Curves.bounceInOut);
                   },
                   icon: const Icon(Icons.arrow_back_ios_new)
               ),
              // ...[0,1,2,3].map((e) => (currentIndex==e?const Icon(Icons.star):buildContainer())),
               for(int i=0;i<onBoardingHelper.onBoardingWatchState().numOfSlides;i++)
                 onBoardingHelper.onBoardingWatchState().currentIndex==i?const Icon(Icons.star):buildContainer(),

               IconButton(
                   onPressed: (){
                     _pageController.animateToPage(onBoardingHelper.onBoardingAccessMethod().goNext(), duration: const Duration(
                         milliseconds: ConstantManager.sliderAnimationTime), curve:  Curves.bounceInOut);
                   },
                   icon: const Icon(Icons.arrow_forward_ios_rounded)),
             ]
           ),
         ),
       ],
         ),
       )

     ],
   );
  }

}

Widget buildContainer(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
    child: Container(
      height: AppSize.s15,
      width: AppSize.s15,
      decoration: BoxDecoration(
          color: ColorManager.grey,
        borderRadius: BorderRadius.circular(AppSize.s12)
      ),
    ),
  );
}

