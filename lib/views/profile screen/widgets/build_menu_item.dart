import 'package:flutter/material.dart';

Widget buildMenuItem({
  required IconData icon,
  required String title,
  TextStyle? textStyle,
  Widget? trailing,
  Color? textColor,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      title,
      style: textStyle ?? TextStyle(color: textColor ?? Colors.black),
    ),
    trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}
