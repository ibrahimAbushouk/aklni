import 'dart:math';
import 'package:aklni/core/utils/helper/responsive_ui_helper/size_provider.dart';
import 'package:flutter/material.dart';

extension SizeHelperExtensions on BuildContext{

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;


  SizeProvider get sizeProvider => SizeProvider.of(this);
  double get scaleWidth => sizeProvider.width / sizeProvider.baseSize.width;
  double get scaleHeight => sizeProvider.height / sizeProvider.baseSize.height;


  double setWidth(num w){
    return w * scaleWidth;
  }
  double setHeight(num h){
    return h * scaleHeight;
  }

  double setSp(num fontSize) {
    final scale = isLandscape
        ? scaleWidth * 0.85
        : min(scaleWidth, scaleHeight);
    final textScaler = MediaQuery.of(this).textScaler;
    return textScaler.scale(fontSize * scale);
  }

  double setMinSize(num size) {
    if (isLandscape) {
      return size * scaleWidth * 0.85;
    }
    return size * min(scaleWidth, scaleHeight);
  }


}