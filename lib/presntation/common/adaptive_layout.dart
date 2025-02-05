import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget{
  final WidgetBuilder mobileLayout;
  final WidgetBuilder tabletLayout;
  final WidgetBuilder desktopLayout;

  const AdaptiveLayout({super.key, required this.mobileLayout, required this.tabletLayout, required this.desktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
      if(constrains.maxWidth<600){
        return mobileLayout(context);
      }else if(constrains.maxWidth<900){
        return tabletLayout(context);
      }else{
        return desktopLayout(context);
      }
    });
  }

}
