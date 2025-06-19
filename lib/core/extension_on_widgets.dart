import 'package:flutter/material.dart';

extension CenteredExtention on Widget {
  Widget get Centered => Center(child: this);
}

extension WidgetExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingOnly(
          {double left = 0.0,
          double top = 0.0,
          double right = 0.0,
          double bottom = 0.0}) =>
      Padding(
          padding: EdgeInsets.only(
              left: left, top: top, right: right, bottom: bottom),
          child: this);

  Widget paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: this);
}
