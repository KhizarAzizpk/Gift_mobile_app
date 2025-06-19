import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.titleStyle,
    this.actions,
    this.backgroundColor = Colors.white,
    this.elevation = 0.0,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title != null
          ? Text(
              title!,
              style: titleStyle ?? const TextStyle(color: Colors.black),
            )
          : null,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height);
}
