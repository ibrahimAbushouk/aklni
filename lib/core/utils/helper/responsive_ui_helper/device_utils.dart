import 'package:aklni/core/utils/helper/responsive_ui_helper/size_helper_extensions.dart';
import 'package:flutter/material.dart';

class DeviceUtils{
  static bool isMobile(BuildContext context){
    return context.scaleWidth < 600;

  }

  static bool isTablet(BuildContext context){
    return context.scaleWidth >= 600 && context.scaleWidth  < 1200;

  }

  static bool isDesktop(BuildContext context){
    return  context.scaleWidth  >= 1200;

  }

  static T valueDecider<T>(BuildContext context ,{
    required T  onMobile,
    T? onTablet,
    T? onDesktop,
    T? others
  }){
    if(isMobile(context)){
      return onMobile;
    }else if(isTablet(context) && onTablet != null){
      return onTablet;
    }else if(isDesktop(context) && onDesktop != null){
      return onDesktop;
    }
    return others ?? onMobile;
  }
}