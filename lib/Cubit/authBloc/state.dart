import 'package:networkapplication/model/errormodel.dart';
import 'package:networkapplication/model/loginmodel.dart';

import '../../model/Admin/registeradminmodel.dart';
import '../../model/registermodel.dart';

abstract class AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  LoginModel loginModel;
  AuthLoginSuccessState(this.loginModel);

}

class AuthLoginErrorState extends AuthState {
  ErrorModel? errorModel;

  AuthLoginErrorState(this.errorModel);
}

class AuthLoginInitState extends AuthState {}

class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  RegisterModel registerModel;
  AuthRegisterSuccessState(this.registerModel);
}

class AuthRegisterErrorState extends AuthState {}

class ChangeState extends AuthState {}


class AuthRegisterLoadingState1 extends AuthState {}

class AuthRegisterSuccessState1 extends AuthState {
  RegisterAdminModel registerModelAdmin;
  AuthRegisterSuccessState1(this.registerModelAdmin);
}

class AuthRegisterErrorState1 extends AuthState {}