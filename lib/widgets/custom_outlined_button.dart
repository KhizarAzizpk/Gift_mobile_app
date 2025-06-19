import 'package:flutter/material.dart';
import 'package:gift_mobile_app/utils/utils.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final double radius;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.width = 100,
    this.height = 50,
    this.radius = 10,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Text(
          text,
          style: AppStyle.urbanistSemiBold10Black,
        ),
      ),
    );
  }
}
