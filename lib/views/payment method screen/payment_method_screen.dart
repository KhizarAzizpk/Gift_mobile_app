import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/core/services/Payment_Services.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/widgets.dart';

class PaymentMethodsScreen extends StatefulWidget {
   PaymentMethodsScreen({super.key});


  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  Map<String,dynamic>? paymentIntent;
  PaymentServices paymentService = PaymentServices();
  String? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: "Payment Methods",
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kGap16,
            const CustomText(
              text: 'Select the payment method you want to use.',
              style: AppStyle.urbanistMedium16Black,
            ),
            kGap25,
            _buildPaymentOption('PayPal', Assets.assetsIconsPaypalIcon),
            kGap10,
            _buildPaymentOption('Google Pay', Assets.assetsIconsGoogleIcon),
            kGap10,
            _buildPaymentOption('Apple Pay', Assets.assetsIconsAppleIcon),
            kGap10,
            _buildPaymentOption(
                '*************** 4679', Assets.assetsIconsMasterCardIcon),
            const Spacer(),
            CommonElevatedButton(
              text: AppString.confirmPayment,
              elevation: 0.0,
              borderRadius: 50,
              width: 372.w,
              style: AppStyle.urbanistBold16White,
              onPressed: () {

                makePayment();
                // Get.toNamed("/handler-screen");
                },
            ),
            kGap16
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String iconPath) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: CustomAssetsImage(
        imagePath: iconPath,
        height: 25,
        width: 25,
        boxFit: BoxFit.contain,
      ),
      title: CustomText(
        text: title,
        style: AppStyle.urbanistBold18Black,
      ),
      trailing: Radio<String>(
        value: title,
        activeColor: kBlackColor,
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value;
          });
        },
      ),
      onTap: () {
        setState(() {
          _selectedMethod = title;
        });
      },
    );
  }



  //payment method


 Future<void>makePayment()async{
  try{

    if(_selectedMethod == 'Google pay' || _selectedMethod!.contains('4679')) {
      paymentIntent = await paymentService.createPaymentIntent('140', 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            googlePay: PaymentSheetGooglePay(
                merchantCountryCode: "US", testEnv: true, currencyCode: "USD"),
            merchantDisplayName: "Khizar Khan",
          ));
      displayPaymentSheet();
    }else if (_selectedMethod == 'Apple Pay') {
      Get.snackbar(
        'Unsupported Method',
        'Apple Pay is not supported yet in this app.',
        snackPosition: SnackPosition.TOP,
      );

    } else if (_selectedMethod == 'PayPal') {
      Get.snackbar("Usupported Method",'PayPal payment integration is not available.',);
    } else {
      Get.snackbar('Select a Payment Method',"Select one payment method atleast");
    }
  } catch (e) {
    print("error $e");
   Get.snackbar('Payment failed: $e',"There is an issue processing payment method");
  }
 }

  displayPaymentSheet()async{
    try{
      await Stripe.instance.presentPaymentSheet();

    }catch(e){
     print("error $e");
    }
  }

}
