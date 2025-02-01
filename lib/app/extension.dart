import 'package:flutter/cupertino.dart';
import 'package:responsive/app/constant.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constant.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constant.zero;
    } else {
      return this!;
    }
  }
}

  //     extension on font size
double getScaleFactor(BuildContext context){
  double width=MediaQuery.sizeOf(context).width;
  if(width<600){
    return width /400;
  }else if(width < 900){
    return width /700;
  }else{
    return width/1000;
  }
}

extension ResponsiveFontSize on num {
  double  getResponsive(BuildContext context) {
    double scaleFactor=getScaleFactor(context);
    double responsiveFontSize=this * scaleFactor;
    double lowerLimit=this *.8;
    double upperLimit=this *1.2;
    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }
}