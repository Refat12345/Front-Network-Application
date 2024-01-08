import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:networkapplication/Cubit/authBloc/state.dart';
import 'package:networkapplication/model/errormodel.dart';

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

  ErrorModel? errorModel;


  Future<void> login({
    required username, required password
}) async {
    final url = Uri.parse('${EndPoint.url}auth/login');

    final body = jsonEncode({
      'username': username,
      'password': password,
    });
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(jsonDecode(response.body));
        emit(AuthLoginSuccessState(loginModel!));

      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(AuthLoginErrorState(errorModel!));
      }
    } catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }
  }


  Future<void> register({
    required username, required password, required confirmPassword
  }) async {
    final url = Uri.parse('${EndPoint.url}auth/register');

    final body = jsonEncode({
      'username': username,
      'password': password,
      'confirm_password':confirmPassword
    });
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        registerModel = RegisterModel.fromJson(jsonDecode(response.body));
        emit(AuthRegisterSuccessState(registerModel!));
        print('تم تسجيل الدخول بنجاح');
      } else {
        print('حدث خطأ في عملية تسجيل الدخول');
      }
    } catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }
  }

  bool status = true;

  void change() {
    status = !status;
    emit(ChangeState());
  }
}
