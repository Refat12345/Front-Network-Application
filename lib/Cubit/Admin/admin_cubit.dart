import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:networkapplication/model/Admin/logmodel.dart';
import 'package:networkapplication/model/loginmodel.dart';

import '../../model/Admin/getallusermodel.dart';
import '../../network/remote/http.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);

  GetAllUserModel? getAllUserModel;
  LogModel? logModel;
  LogModel? logModell;

  Future<void> getAllUser()async {
    try{
      emit(AdminLoadinga());
      HttpHelper.getData(
        url: "user/getAllUsers",)
          .then((value) {
        getAllUserModel = GetAllUserModel.fromJson(jsonDecode(value.body));
        emit(AdminSucessa());
      }).catchError((onError) {
        print(onError.toString());
        emit(AdminErrora());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }


  Future<void> getLog({
    required userId
})async {
    try{
      emit(AdminLoadingaa());
      HttpHelper.getData(
        url: "user/getUserLogs/$userId",)
          .then((value) {
        logModel = LogModel.fromJson(jsonDecode(value.body));
        emit(AdminSucessaa());
      }).catchError((onError) {
        print(onError.toString());
        emit(AdminErroraa());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }



  Future<void> getUserLock()async {
    try{
      emit(AdminLoadinga());
      HttpHelper.getData(
        url: "user/getUsersWithFaultCount",)
          .then((value) {
        getAllUserModel = GetAllUserModel.fromJson(jsonDecode(value.body));
        emit(AdminSucessa());
      }).catchError((onError) {
        print(onError.toString());
        emit(AdminErrora());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }



  Future<void> getfilereport({required fileId})async {
    try{
      emit(LoadingState1345());
      HttpHelper.getData(
        url: "user/getUserFileLogs/${fileId}",)
          .then((value) {
        logModell = LogModel.fromJson(jsonDecode(value.body));
        emit(SuccessState1345());
      }).catchError((onError) {
        print(onError.toString());
        emit(ErrorState1345());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }



}
