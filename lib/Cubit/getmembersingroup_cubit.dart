import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/errormodel.dart';
import '../model/getmembermodel.dart';
import '../model/message.dart';
import '../network/helper.dart';
import '../network/local/cache.dart';
import '../network/remote/http.dart';

part 'getmembersingroup_state.dart';

class GetmembersingroupCubit extends Cubit<GetmembersingroupState> {
  GetmembersingroupCubit() : super(GetmembersingroupInitial());

  static GetmembersingroupCubit get(context) => BlocProvider.of(context);
  GetMemberModel? getmembersmodle;
  ErrorModel? errorModel;
  MessageModel? messageModel;

  Future<void> getMembers(int? id) async {
    try{
      emit(LoadingState4());
      HttpHelper.getData(
        url: "group/getMembers/${id}",)

          .then((value) {
        print(value.statusCode);
        getmembersmodle = GetMemberModel.fromJson(jsonDecode(value.body));
        print("sucessssss");
        emit(SuccessState4(getmembersmodle!));
      }).catchError((onError) {
        print(onError.toString());
        emit(ErrorState4());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }
  }



  Future<void> deleteUser({required groupId, required userId }) async {
    String apiUrl = '${EndPoint.url}group/deleteUser';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };

    Map<String, dynamic> body = {
      'userId': userId,
      'groupId':groupId
    };

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        messageModel = MessageModel.fromJson(jsonDecode(response.body));

        emit(SuccessStateedel(messageModel!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorStateedel(errorModel!));
      }
    } catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');

    }
  }


}
