import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gift_mobile_app/main.dart';

class CustomAssetsImage extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final BoxFit boxFit;

  const CustomAssetsImage({
    super.key,
    required this.imagePath,
    this.height = 20,
    this.width = 20,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    String extension = imagePath.split(".").last;

    switch (extension) {
      case 'svg':
        return SvgPicture.asset(
          imagePath,
          width: width.w,
          height: height.h,
          fit: boxFit,
        );
      case 'jpg':
      case 'png':
        return Image.asset(
          imagePath,
          width: width.w,
          height: height.h,
          fit: boxFit,
        );
      default:
        throw FormatException("Image format $extension is not supported");
    }
  }
}
