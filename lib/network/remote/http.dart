// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
//
// import '../../component/helper.dart';
// import '../local/cache.dart';
//
// class HttpHelper {
//
//   static Future<Response> getData({required url}) async {
//     return await http.get(Uri.parse(url), headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
//     });
//   }
//
//   static Future<Response> postData({required url, required data}) async {
//     return await http.post(Uri.parse(url), body: data, headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
//     });
//   }
//
//   static Future<Response> deleteData({
//     required url,
//     data
//   }) async {
//     return await http.delete(Uri.parse(EndPoint.url + url), headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
//     },body: data);
//   }
//
//   static Future<Response> putData({required url, required data}) async {
//     return await http.put(Uri.parse(url), body: data, headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
//     });
//   }
// }

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helper.dart';
import '../local/cache.dart';

class HttpHelper {
  // static Future<Response> getData({required url}) async {
  //   var client = http.Client();
  //
  //   return await http.get(Uri.parse(EndPoint.url + url), headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
  //   });
  // }

  static Future<http.Response> getData({required String url}) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse(EndPoint.url + url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      ).timeout(Duration(seconds: 60)); // تعيين زمن انتظار 60 ثانية
      return response;
    } finally {
      client.close();
    }
  }

  static Future<Response> postData({required url, required data}) async {
    return await http.post(Uri.parse(EndPoint.url + url), body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    });
  }

  static Future<Response> deleteData({
    required url,
    data
  }) async {
    return await http.delete(Uri.parse(EndPoint.url + url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    },body: data);
  }

  static Future<Response> putData({required url, required data}) async {
    return await http.put(Uri.parse(EndPoint.url + url), body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }
    );
  }
}

