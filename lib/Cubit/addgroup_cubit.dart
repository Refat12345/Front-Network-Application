import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/addnewgroup.dart';
import '../model/errormodel.dart';
import '../network/helper.dart';
import '../network/local/cache.dart';
import '../network/remote/http.dart';

part 'addgroup_state.dart';

class AddgroupCubit extends Cubit<AddgroupState> {
  AddgroupCubit() : super(AddgroupInitial());

  static AddgroupCubit get(context) => BlocProvider.of(context);
  Addnewgroup? addnewgroup;
  ErrorModel? errorModel;


  Future<void> addNewGroup({required groupName }) async {
    String apiUrl = '${EndPoint.url}group/addGroup';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };

    Map<String, dynamic> body = {
      'groupName': groupName,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        addnewgroup = Addnewgroup.fromJson(jsonDecode(response.body));

        print('تمت إضافة المجموعة بنجاح');
        emit(SuccessState(addnewgroup!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorState(errorModel!));
      }
    } catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');
    }
  }

}
