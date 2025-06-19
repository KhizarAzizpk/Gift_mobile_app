import 'package:flutter/material.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints?
      prefixIconConstraints; // Added for prefix icon customization
  final BoxConstraints?
      suffixIconConstraints; // Added for suffix icon customization
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color? borderColor;
  final Color? courserColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final void Function(String)? onChanged;


  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconConstraints, // Initialize prefix icon constraints
    this.suffixIconConstraints, // Initialize suffix icon constraints
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderColor,
    this.courserColor,
    this.focusedBorderColor,
    this.borderRadius = 8.0,
    this.validator,
    this.onSaved,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      cursorColor: courserColor,
      style: style,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ?? const TextStyle(color: kGrayColor),
        hintText: hintText,
        hintStyle:
            hintStyle ?? const TextStyle(color: kGrayColor, fontSize: 14),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints ??
            const BoxConstraints(
              minWidth: 40, // Default width
              minHeight: 40, // Default height
            ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints ??
            const BoxConstraints(
              minWidth: 40, // Default width
              minHeight: 40, // Default height
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor ?? Colors.blue),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
