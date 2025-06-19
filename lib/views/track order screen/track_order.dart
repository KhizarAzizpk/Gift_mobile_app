import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gift_mobile_app/models/order_model.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_string.dart';

class TrackOrderScreen extends StatefulWidget {
  final OrderModel order;

  const TrackOrderScreen({super.key, required this.order});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late int currentStep;
  Timer? refreshTimer;

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.currentStep;

    refreshTimer = Timer.periodic(Duration(seconds: 30), (_) async {
      final doc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.order.orderId)
          .get();

      setState(() {
        currentStep = doc.data()?['currentStep'] ?? currentStep;
      });
    });
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  String getStepIcon(String grayAsset, String blackAsset, int stepIndex) {
    return currentStep >= stepIndex ? blackAsset : grayAsset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backgroundColor: Colors.white,
        title: AppString.TrackOrder,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.order.image,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product: ${widget.order.title}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "In Delivery",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Steps + ticks + lines
            Column(
              children: [
                // Step icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      getStepIcon(
                        Assets.assetsIconsBoxIconGray,
                        Assets.assetsIconsBoxIconBlack,
                        0,
                      ),
                      key: ValueKey('step_icon_0_$currentStep'),
                    ),
                    SvgPicture.asset(
                      getStepIcon(
                        Assets.assetsIconsCourierIconGray,
                        Assets.assetsIconsCourierIconBlack,
                        1,
                      ),
                      key: ValueKey('step_icon_1_$currentStep'),
                    ),
                    SvgPicture.asset(
                      getStepIcon(
                        Assets.assetsIconsBoxCarryIconGray,
                        Assets.assetsIconsBoxCarryIconBlack,
                        2,
                      ),
                      key: ValueKey('step_icon_2_$currentStep'),
                    ),
                    SvgPicture.asset(
                      getStepIcon(
                        Assets.assetsIconsOpenBoxIconGray,
                        Assets.assetsIconsOpenBoxIconBlack,
                        3,
                      ),
                      key: ValueKey('step_icon_3_$currentStep'),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Ticks and lines row
                Row(
                  children: List.generate(4, (index) {
                    return Expanded(
                      child: Column(
                        children: [
                          // Tick below each icon
                          SvgPicture.asset(
                            currentStep >= index
                                ? Assets.assetsfilledtickblack
                                : Assets.assetsfilledtickGray,
                            height: 24,
                            width: 24,
                          ),

                          // Line between ticks (not after the last tick)
                          if (index < 3)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: SvgPicture.asset(
                                currentStep > index
                                    ? Assets.assetsBlacklines
                                    : Assets.assetsGraylines,
                                height: 4,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // You can optionally add text labels for each step here
          ],
        ),
      ),
    );
  }
}
