import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../model/errormodel.dart';
import '../model/getmygroupmodel.dart';
import '../model/message.dart';
import '../network/helper.dart';
import '../network/local/cache.dart';
import '../network/remote/http.dart';

part 'get_my_group_state.dart';

class GetMyGroupCubit extends Cubit<GetMyGroupState> {
  GetMyGroupCubit() : super(GetMyGroupInitial());

  static GetMyGroupCubit get(context) => BlocProvider.of(context);
  GetMyGroupModel? getMyGroupModel;
  MessageModel? messageModel;
  ErrorModel? errorModel;


  Future<void> getMyGroup()async {

    try{
      emit(LoadingStateee());
      HttpHelper.getData(
        url: "group/getMyGroup",
      )

          .then((value) {
        getMyGroupModel = GetMyGroupModel.fromJson(jsonDecode(value.body));
        emit(SuccessStateee());
      }).catchError((onError) {
        print(onError.toString());
        emit(ErrorStateee());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }

  Future<void> deleteGroup({required groupID }) async {
    String apiUrl = '${EndPoint.url}group/deleteGroup/${groupID}';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };



    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        messageModel = MessageModel.fromJson(jsonDecode(response.body));
        emit(SuccessStatedeletegroup1(messageModel!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorStatedeletegroup1(errorModel!));
      }
    } catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');
    }
  }


}
