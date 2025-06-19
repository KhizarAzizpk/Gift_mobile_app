import 'package:flutter/material.dart';
import 'package:gift_mobile_app/utils/utils.dart';

class SearchField extends StatelessWidget {
  final double width;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const SearchField(
      {super.key,
      required this.width,
      this.onChanged,
      this.controller,
      this.onTap,
      this.onTapOutside,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: kLightOrangeColor,
        borderRadius: BorderRadius.circular(11),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColor.kBlackColor,
        style: AppStyle.urbanistSemiBold14Black,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: 'Search here.....',
          hintStyle: AppStyle.urbanistSemiBold14Gray,
          prefixIcon: const Icon(
            Icons.search,
          ),
          filled: true,
          fillColor: kLightOrangeColor,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          contentPadding:
              const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 12.0, 0.0),
        ),
        onChanged: onChanged,
        onTap: onTap,
        onTapOutside: onTapOutside,
      ),
    );
  }
}
