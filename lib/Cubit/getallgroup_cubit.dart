import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/errormodel.dart';
import '../model/getallgroupmodel.dart';
import '../model/message.dart';
import '../network/helper.dart';
import '../network/local/cache.dart';
import '../network/remote/http.dart';

part 'getallgroup_state.dart';

class GetallgroupCubit extends Cubit<GetallgroupState> {
  GetallgroupCubit() : super(GetallgroupInitial());


  static GetallgroupCubit get(context) => BlocProvider.of(context);
  GetAllGroupmodel? getAllGroupmodel;
  MessageModel? messageModel;
  ErrorModel? errorModel;

  Future<void> getAllGroups() async{

    try{
      emit(LoadingState());
      HttpHelper.getData(
        url: "group/getAllGroups",
      )
          .then((value) {
        getAllGroupmodel = GetAllGroupmodel.fromJson(jsonDecode(value.body));
        emit(SuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(ErrorState());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }


  Future<void> leaveGroup({required groupID }) async {
    String apiUrl = '${EndPoint.url}group/leaveGroup/${groupID}';

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
        emit(SuccessStateleavegroup(messageModel!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorStateleavegroup(errorModel!));
      }
    } catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');
    }
  }

}
