import 'dart:math';

import 'package:flutter/material.dart';

class SizeConfig {
  SizeConfig();

  static Size designSize = const Size(390, 844);
  static late Size deviceSize;


  static void setSize(MediaQueryData media) {
    deviceSize = Size(media.size.width, media.size.height);
  }

  static double quotient(double dim1, double dim2) {
    return dim1 > dim2 ? dim1 / dim2 : dim2 / dim1;
  }

  static double percentWidth(double p) {
    return deviceSize.width * p / 100;
  }

  static double percentHeight(double p) {
    return deviceSize.height * p / 100;
  }

  static ContextDimensions Function(BuildContext) of = (BuildContext ctx) {
    return ContextDimensions(ctx);
  };

  static double dx(double x) {
    final double deviceRatio = hypotenuse(deviceSize);
    final double designRatio = hypotenuse(designSize);
    final double ratio = deviceRatio / designRatio;
    return ratio * x;
  }

  static double propHeight(double h) {
    return (h / designSize.height) * deviceSize.height;
  }

  static double propWidth(double w) {
    return (w / designSize.width) * deviceSize.width;
  }

  static double hypotenuse(Size size) {
    return sqrt(pow(size.height, 2) + pow(size.width, 2));
  }
}

class ContextDimensions {
  const ContextDimensions(this._context);

  final BuildContext _context;

  double get width {
    return _context.size!.width;
  }

  double get height {
    return _context.size!.height;
  }
}

extension AdaptiveSize on double {
  double get ph => SizeConfig.propHeight(this);

  double get pw => SizeConfig.propWidth(this);

  double get pth => SizeConfig.percentHeight(this);

  double get ptw => SizeConfig.percentWidth(this);
}

extension AdaptiveIntSize on int {
  double get ph => SizeConfig.propHeight(toDouble());

  double get pw => SizeConfig.propWidth(toDouble());

  double get pth => SizeConfig.percentHeight(toDouble());

  double get ptw => SizeConfig.percentWidth(toDouble());
}
