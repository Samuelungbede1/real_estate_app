import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/app_colors.dart';

import 'config/size_config.dart';

class FWt {
  FWt();

  static FontWeight thin = FontWeight.w100;
  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}

class AppText {
   static const String _fontFamily = 'Poppins';
  AppText();

static TextSpan spanExtraLight(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    String fontFamily = _fontFamily,
    VoidCallback? recognizer,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      children: children,
      recognizer: TapGestureRecognizer()..onTap = recognizer,
      text: text,
      style: TextStyle(
        overflow: overflow,
        fontSize: fontSize ?? 10.0,
        fontWeight: FWt.extraLight,
        color: color ?? AppColors.black,
        height: height,
        fontStyle: fontStyle,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static Text extraLight(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    String fontFamily = _fontFamily,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 10.0,
        fontWeight: FWt.extraLight,
        color: color ?? AppColors.black,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static TextSpan spanLight(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    String fontFamily = _fontFamily,
    VoidCallback? recognizer,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      children: children,
      recognizer: TapGestureRecognizer()..onTap = recognizer,
      text: text,
      style: TextStyle(
        overflow: overflow,
        fontSize: fontSize ?? 12.0,
        fontWeight: FWt.light,
        color: color ?? AppColors.black,
        height: height,
        fontStyle: fontStyle,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static Text light(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    String fontFamily = _fontFamily,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 12.0,
        fontWeight: FWt.light,
        color: color ?? AppColors.black,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static TextSpan spanRegular(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    String fontFamily = _fontFamily,
    VoidCallback? recognizer,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      children: children,
      recognizer: TapGestureRecognizer()..onTap = recognizer,
      text: text,
      style: TextStyle(
        overflow: overflow,
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.regular,
        color: color ?? AppColors.black,
        height: height,
        fontStyle: fontStyle,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static Text regular(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    String fontFamily = _fontFamily,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 12.0,
        fontWeight: FWt.regular,
        color: color ?? AppColors.black,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static TextSpan spanMedium(
    String? text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
    GestureRecognizer? recognizer,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      children: children,
      recognizer: recognizer,
      text: text,
      style: TextStyle(
        overflow: overflow,
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.medium,
        color: color ?? AppColors.black,
        height: height,
        fontStyle: fontStyle,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: _fontFamily,
      ),
    );
  }

  static Text medium(String text,
      {double? fontSize,
      Color? color,
      TextAlign? align,
      double? height,
      bool strike = false,
      int? lines,
      TextOverflow? overflow,
      bool underline = false,
      String fontFamily = _fontFamily,
      bool? softWrap}) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.medium,
        color: color ?? AppColors.black,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static Text semiBold(
    String text, {
    double? fontSize,
    Color? color,
    TextOverflow? overflow,
    TextAlign? align,
    double? height,
    bool? strike = false,
    bool underline = false,
    int? lines,
    String fontFamily = _fontFamily,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.semiBold,
        color: color ?? AppColors.black,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike!
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static TextSpan spanSemiBold(
    String? text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    double? height,
    String fontFamily = _fontFamily,
    GestureRecognizer? recognizer,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      children: children,
      recognizer: recognizer,
      text: text,
      style: TextStyle(
          fontSize: fontSize ?? 14.0,
          fontWeight: FWt.semiBold,
          color: color ?? AppColors.black,
          height: height,
          decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
          fontFamily: fontFamily),
    );
  }

  static TextSpan spanBold(
    String? text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    double? height,
    GestureRecognizer? recognizer,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      children: children,
      recognizer: recognizer,
      text: text,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.bold,
        color: color ?? AppColors.black,
        height: height,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: _fontFamily,
      ),
    );
  }

  static Text bold(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    double? height,
    bool? softWrap,
    bool underline = false,
    String fontFamily = _fontFamily,
  
  }) {
    return Text(
      
      text,
  
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: SizeConfig.propWidth(fontSize ?? 14.0),
        fontWeight: FWt.bold,
        color: color ?? AppColors.black,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }

  static Text extraBold(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    int? lines,
    bool strike = false,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.extraBold,
        color: color ?? AppColors.black,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: _fontFamily,
      ),
    );
  }

  static Text black(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    int? lines,
    bool strike = false,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: FWt.black,
        color: color ?? AppColors.black,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: _fontFamily,
      ),
    );
  }

  static WidgetSpan subscriptText({
    required String text,
    required TextStyle style,
    double textScaleFactor = 0.6,
    Offset textOffset = const Offset(0.7, 1.399),
  }) {
    return WidgetSpan(
      child: Transform.translate(
        offset: textOffset,
        child: Text(
          text,
          textScaleFactor: textScaleFactor,
          style: style,
        ),
      ),
    );
  }

  static WidgetSpan widgetsSpan(Widget widget) {
    return WidgetSpan(child: widget, alignment: PlaceholderAlignment.middle);
  }
}
