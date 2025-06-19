import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double space;

  const VSpace(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(height: screenHeight * space);
  }
}

class HSpace extends StatelessWidget {
  final double space;

  const HSpace(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(width: screenWidth * space);
  }
}
