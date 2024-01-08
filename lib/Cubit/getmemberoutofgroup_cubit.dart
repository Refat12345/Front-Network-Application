import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../model/errormodel.dart';
import '../model/getAllUserOutOfThisGroupmodel.dart';
import '../model/message.dart';
import '../network/helper.dart';
import '../network/local/cache.dart';
import '../network/remote/http.dart';

part 'getmemberoutofgroup_state.dart';

class GetmemberoutofgroupCubit extends Cubit<GetmemberoutofgroupState> {
  GetmemberoutofgroupCubit() : super(GetmemberoutofgroupInitial());

  static GetmemberoutofgroupCubit get(context) => BlocProvider.of(context);

  GetAllUserOutOfThisGroupModel? getAllUserOutOfThisGroupModel;

  MessageModel? messageModel;
  ErrorModel?  errorModel;

  Future<void> getMembersOutOfGroup(int? groupId)async {
    try{
      emit(LoadingState5());
      HttpHelper.getData(
        url: "user/getUsers/${groupId}",)
          .then((value) {
        getAllUserOutOfThisGroupModel = GetAllUserOutOfThisGroupModel.fromJson(jsonDecode(value.body));
        emit(SuccessState5());
      }).catchError((onError) {
        print(onError.toString());
        emit(LoadingState5());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }


  Future<void> addUserToGroup({required groupId,required userId }) async {
    String apiUrl = '${EndPoint.url}group/addUser';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };

    Map<String, dynamic> body = {
      'user_id': userId,
      'group_id':groupId
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        messageModel = MessageModel.fromJson(jsonDecode(response.body));

        emit(SuccessState6(messageModel!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorState6(errorModel!));
      }
    } catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');

    }
  }



}
