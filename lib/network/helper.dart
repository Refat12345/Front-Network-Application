import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


// Future<void> flutterToast(String message, String type) async {
//   Color backgroundColor = Colors.green;
//
//   if (type == 'error') {
//     backgroundColor = Colors.red;
//   }
//
//   await Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: backgroundColor,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }

//
// Future flutterToastt(dynamic message, String type,double height,String gravity) {
//   return Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: gravity=="pin"?ToastGravity.CENTER:ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: type=="error"?Colors.red:green,
//       textColor: Colors.white,
//       fontSize: height*0.027);
// }




class EndPoint {

  //static String imageShopUrl="http://192.168.1.105:8000/image_shop/";

  static String url = "http://192.168.116.142:8080/api/";

  //static String  baseUrl = "http://192.168.116.156:8080";
  //static String imageUrl="http://192.168.1.104:8000/";
}
Future<void> flutterToast(String message, String type) async {
  Color backgroundColor = Colors.green;

  if (type == 'error') {
    backgroundColor = Colors.red;
  }

  await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}