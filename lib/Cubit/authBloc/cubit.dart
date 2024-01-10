import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:networkapplication/Cubit/authBloc/state.dart';
import 'package:networkapplication/model/errormodel.dart';

import '../../model/Admin/registeradminmodel.dart';
import '../../model/loginmodel.dart';
import '../../model/registermodel.dart';
import '../../network/helper.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoginInitState());

  static AuthCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel ;
  RegisterModel? registerModel;
  RegisterAdminModel? registerModelAdmin;

  ErrorModel? errorModel;


//   Future<void> login({
//     required username, required password
// }) async {
//     final url = Uri.parse('${EndPoint.url}auth/login');
//
//     final body = jsonEncode({
//       'username': username,
//       'password': password,
//     });
//     emit(AuthLoginLoadingState());
//     final headers = {'Content-Type': 'application/json'};
//     try {
//       final response = await http.post(url, body: body, headers: headers);
//
//       if (response.statusCode == 200) {
//         loginModel = LoginModel.fromJson(jsonDecode(response.body));
//         emit(AuthLoginSuccessState(loginModel!));
//       } else {
//         errorModel = ErrorModel.fromJson(jsonDecode(response.body));
//         emit(AuthLoginErrorState(errorModel!));
//       }
//     } catch (e) {
//       print('حدث خطأ أثناء التواصل مع الخادم: $e');
//     }
//   }
  Future<void> login({
    required username, required password
  }) async {
    var client = http.Client();

    final body = jsonEncode({
      'username': username,
      'password': password,
    });
    final headers = {'Content-Type': 'application/json'};
    try {

      final url = Uri.parse('${EndPoint.url}auth/login');
      final response = await client.post(url,body: body,headers: headers).timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(jsonDecode(response.body));
        emit(AuthLoginSuccessState(loginModel!));

      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(AuthLoginErrorState(errorModel!));
      }
    } catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }finally {
      client.close();
    }
  }


  Future<void> register({
    required username, required password, required confirmPassword
  }) async {
    var client = http.Client();

    final url = Uri.parse('${EndPoint.url}auth/register');

    final body = jsonEncode({
      'username': username,
      'password': password,
      'confirm_password':confirmPassword
    });
    final headers = {'Content-Type': 'application/json'};
    try {

      final response = await client.post(url, body: body, headers: headers).timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        registerModel = RegisterModel.fromJson(jsonDecode(response.body));
        emit(AuthRegisterSuccessState(registerModel!));
        print('تم تسجيل الدخول بنجاح');
      } else {
        print('حدث خطأ في عملية تسجيل الدخول');
      }
    } catch (e) {
      emit(AuthRegisterErrorState());
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }
    finally {
      client.close();
    }
  }


  Future<void> registerAdmin({
    required username, required password, required confirmPassword,required verificationCode
  }) async {
    final url = Uri.parse('${EndPoint.url}auth/registerAsAdmin');
    var client = http.Client();

    final body = jsonEncode({
      'username': username,
      'password': password,
      'confirm_password':confirmPassword,
      'verificationCode': verificationCode
    });
    final headers = {'Content-Type': 'application/json'};
    try {

      final response = await client.post(url, body: body, headers: headers).timeout(Duration(seconds: 60));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print('sucess admin register');
        registerModelAdmin = RegisterAdminModel.fromJson(jsonDecode(response.body));
        emit(AuthRegisterSuccessState1(registerModelAdmin!));
        print('تم تسجيل الدخول بنجاح');
      } else {
        print('حدث خطأ في عملية تسجيل الدخول');
      }
    } catch (e) {
      emit(AuthRegisterErrorState());
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }
    finally {
      client.close();
    }
  }








  bool status = true;

  void change() {
    status = !status;
    emit(ChangeState());
  }
}
