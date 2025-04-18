// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/app_colors.dart';
import 'package:real_estate_app/core/utils/config/size_config.dart';
import 'package:flutter_svg/svg.dart';


class CustomIcon extends StatelessWidget {
  const CustomIcon(this.icon,
      {Key? key,
      this.width,
      this.height,
      this.showImage = false,
      this.color,
      this.size = 20,
      this.fit,
      this.onTap})
      : super(key: key);
  final String icon;
  final Color? color;
  final double size;
  final double? width;
  final double? height;
  final Function()? onTap;
  final BoxFit? fit;
  final bool showImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Builder(builder: (context) {
          if (showImage) {
            return Image.asset(
              icon,
              height: SizeConfig.propHeight(height ?? size),
              width: SizeConfig.propWidth(width ?? size),
              fit: fit,
              color: color,
              errorBuilder: (context, _, __) => Icon(
                Icons.error_outline,
                color: color ?? AppColors.white,
              ),
            );
          }
          return SvgPicture.asset(
            icon,
            height: SizeConfig.propHeight(height ?? size),
            width: SizeConfig.propWidth(width ?? size),
            color: color,
            // theme: SvgTheme(currentColor: color),
            placeholderBuilder: (context) => const Icon(Icons.error_outline),
          );
        }));
  }
}
