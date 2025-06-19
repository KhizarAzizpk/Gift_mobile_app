import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gift_mobile_app/utils/constants/app_assets.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/views/track%20order%20screen/track_order.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';

import '../../controllers/order_controller.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, //two screens

        child: Scaffold(
          appBar: CustomAppBar(
            title: AppString.orders,
            titleStyle: AppStyle.urbanistBold24Black,
            elevation: 0,
            bottom: const TabBar(
                labelColor: Colors.black, //selected one will have lable below the text
                unselectedLabelColor: Colors.grey, //unselected one will have default or grey color
                indicatorColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                tabs: [
                  Tab(text: AppString.ongoing,
                  ),
                  Tab(text: AppString.Completed,),
                ]),
          ),
          body: const TabBarView(children: [
            OngoingOrders(),
            ComletedorderScreen(),

          ]),

        ));
  }
}

// class OngoingOrders extends StatelessWidget {
//   const OngoingOrders({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 180.0),
//         child: Column(
//           children: [
//             SvgPicture.asset(Assets.assetsFrame,width: 430,height: 220,),
//             SizedBox(height: 30,),
//             Text("You don't have an order yet",style: TextStyle(color: Colors.black,fontSize:22,fontWeight: FontWeight.w500, ),),
//             SizedBox(height: 20,),
//             Text("You don't have an ongoing order at this time",style: TextStyle(fontSize: 17),),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
 // Adjust the import as needed

class OngoingOrders extends StatelessWidget {
  const OngoingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();

    // Make sure orders are only fetched once per screen rebuild
    if (orderController.ongoingOrders.isEmpty && orderController.isloading.value) {
      orderController.fetchOrdersFromFirestore();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppString.ongoingOrder,
          style: AppStyle.urbanistBold24Black,
        ),
      ),
      body: Obx(() {
        if (orderController.isloading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (orderController.ongoingOrders.isEmpty) {
          return const Center(
            child: Text("You don't have any ongoing orders yet."),
          );
        }

        return ListView.builder(
          itemCount: orderController.ongoingOrders.length,
          itemBuilder: (context, index) {
            final order = orderController.ongoingOrders[index];

            return Card(
              color: Colors.white,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  Get.to(() => TrackOrderScreen(order: order));
                },
                leading: Image.network(
                  order.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
                ),
                title: Text(
                  order.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: Assets.assetsFontsUrbanistBlack,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: CustomText(
                  text:
                  // 'Price: \$${order.price.toStringAsFixed(2)}'
                      '\nRatings: ${order.ratings} ⭐',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  '${order.timestamp.day}/${order.timestamp.month}/${order.timestamp.year}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}



//completed order screen
class ComletedorderScreen extends StatelessWidget {
  const ComletedorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completed Orders",style: TextStyle(fontSize: 20,color: Colors.black),),
    );
  }
}
