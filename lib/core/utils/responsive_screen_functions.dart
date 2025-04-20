import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const MockupHeight = 844.0;
const MockupWidth = 390.0;

sHeight(BuildContext context) {
  return (dynamic height) {
  
    double screenHeight = MediaQuery.of(context).size.height;
    double result = screenHeight * (height / MockupHeight);
    return result.sp;
  };
}

sWidth(BuildContext context) {
  return (dynamic width) {
    double screenWidth = MediaQuery.of(context).size.width;
    double result = screenWidth * (width / MockupWidth);
    return result.sp;
  };
}

Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

class Screen {
  final Size screenSize;

  Screen(this.screenSize);

  double wp(percentage) {
    double result = percentage / 100 * screenSize.width;
    return result.sp;
  }

  double hp(percentage) {
    double result = percentage / 100 * screenSize.height;
    return result.sp;
  }
}
