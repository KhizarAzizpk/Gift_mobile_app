import 'dart:convert';

import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:http/http.dart' as http;
class PaymentServices{
 createPaymentIntent(String amount, String currency)async{
   try{
   Map<String,dynamic> body={
     'amount':(int.parse(amount)*100).toString(),
      'currency': currency,
      'payment_method_types[]':'card',
   };
   var secreteKey = AppString.Secretkey;
   var response = await http.post(
     Uri.parse('https://api.stripe.com/v1/payment_intents'),
     headers: {
       'Authorization': 'Bearer $secreteKey',
       'Content-Type' : 'application/x-www-form-urlencoded'
     },
     body: body,
   );

   return jsonDecode(response.body);

   }catch (e){
     print("error $e");

   }




 }
}