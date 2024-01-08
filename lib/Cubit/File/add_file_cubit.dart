import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import '../../Screen/ViewFile.dart';
import '../../Screen/ViewFileContent.dart';
import '../../model/errormodel.dart';
import '../../model/getallfile.dart';
import '../../model/message.dart';
import '../../network/helper.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';

part 'add_file_state.dart';

class AddFileCubit extends Cubit<AddFileState> {
  AddFileCubit() : super(AddFileInitial());
  static AddFileCubit get(context) => BlocProvider.of(context);
  String? filePath;
  MessageModel? messageModel;
  ErrorModel? errorModel;
  GetAllFileModel? getAllFileModel;
  List<int> selectedIds = [];


  Future<void> getAllFile({
    required groupId})
 async {

    try{
      emit(LoadingState13());
      HttpHelper.getData(
        url: "file/getAllFiles/${groupId}",
      )
          .then((value) {
        getAllFileModel = GetAllFileModel.fromJson(jsonDecode(value.body));
        print("sucessssss");
        emit(SuccessState13());
      }).catchError((onError) {
        print(onError.toString());
        emit(ErrorState13());
      });
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }

  void toggleSelection(int id) {

    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
      emit(UnSelectItemState());

    } else {
      selectedIds.add(id);
      emit(SelectItemState());
    }
  }


  Future pickFile(BuildContext context, int groupId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt'],
    );
    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String fileName = result.files.single.name!;
      print('Selected file name: $fileName');
      print('File bytes: $fileBytes');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FileViewerScreen(fileBytes: fileBytes, groupId: groupId,fileName: fileName,),
        ),
      );
      // addNewFile();
    }
  }


  Future pickUpdateFile(BuildContext context, int groupId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt'],
    );
    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String fileName = result.files.single.name!;
      print('Selected file name: $fileName');
      print('File bytes: $fileBytes');

      updateFile(groupId: groupId, fileBytes: fileBytes, fileName: fileName);

      // AddFileCubit.get(context).updateFile(groupId: groupId);



    }
  }

  Future<void> updateFile({
    required int groupId,
    required Uint8List fileBytes,
    required fileName
  }) async {
    try{
      emit(LoadingStateupdate());
      String apiUrl = '${EndPoint.url}file/updateFile/$groupId';
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);

      var file = http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType('application', 'octet-stream'),
      );
      request.files.add(file);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: 'token')}';

      var response = await request.send();
      var responseBody = await response.stream.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        print("Update File Sucess");
        messageModel = MessageModel.fromJson(jsonDecode(responseBody));
        emit(SuccessStateupdate(messageModel!));

      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(responseBody));
        emit(ErrorStateupdate(errorModel!));

      }
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }




  Future<void> getFileContent({
    required groupID,
      required fileName,
    required context
}) async {

    String apiUrl = '${EndPoint.url}file/getFile/${groupID}';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };

    Map<String, dynamic> body = {
      'name': fileName,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );


      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewFileContent(text:response.body ,fileName: fileName,),
          ),
        );

      } else {
        print('error');
      }
    }
    catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');

    }
  }


  Future<void> addNewFile({
    required int groupId,
    required Uint8List fileBytes,
    required fileName
  }) async {

    try{
      emit(LoadingStateadd());
      String apiUrl = '${EndPoint.url}file/addFile/$groupId';
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);
      var file = http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType('application', 'octet-stream'),
      );
      request.files.add(file);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: 'token')}';

      var response = await request.send();
      var responseBody = await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        messageModel = MessageModel.fromJson(jsonDecode(responseBody));
        emit(SuccessStateadd(messageModel!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(responseBody));
        emit(ErrorStateadd(errorModel!));

      }
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }



  Future<void> downloadFile({
  required fileName,
    required text
  })async  {

    final blob = html.Blob([text]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = fileName
      ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();

    html.Url.revokeObjectUrl(url);
    anchor.remove();
  }




  Future<void> checkIn() async {

    String url = '${EndPoint.url}file/checkIn';

    Map<String, dynamic> data = {'file_id': selectedIds};


    try{
      emit(LoadingStatecheckin());
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        messageModel = MessageModel.fromJson(jsonDecode(response.body));
        emit(SuccessStatecheckin(messageModel!));

      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorStatecheckin(errorModel!));

      }
    }
    catch (e) {
      print('حدث خطأ أثناء التواصل مع الخادم: $e');
    }

  }





  Future<void> deleteFile({required groupId }) async {

    String url = '${EndPoint.url}file/deleteFile/${groupId}';
    Map<String, dynamic> data = {'file_id': selectedIds};

try{
  emit(LoadingStatedelfile());

  http.Response response = await http.delete(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
    },
    body: json.encode(data),
  );
  if (response.statusCode == 200) {
    messageModel = MessageModel.fromJson(jsonDecode(response.body));
    emit(SuccessStatedelfile(messageModel!));


  }

  else {

    errorModel = ErrorModel.fromJson(jsonDecode(response.body));

    emit(ErrorStatedelfile(errorModel!));

  }
}
catch (e) {
  print('حدث خطأ أثناء التواصل مع الخادم: $e');
}

  }


  Future<void> checkOut() async {

    String url = '${EndPoint.url}file/checkOut';

    Map<String, dynamic> data = {'file_id': selectedIds};

try{
  emit(LoadingStatecheckout());
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
    },
    body: json.encode(data),
  );

  if (response.statusCode == 200) {
    messageModel = MessageModel.fromJson(jsonDecode(response.body));
    emit(SuccessStatecheckout(messageModel!));


  } else {

    errorModel = ErrorModel.fromJson(jsonDecode(response.body));
    emit(ErrorStatecheckout(errorModel!));

  }
}
catch (e) {
  print('حدث خطأ أثناء التواصل مع الخادم: $e');
}

  }


  Future<void> deleteAllFileInGroup({required groupId }) async {
    String apiUrl = '${EndPoint.url}file/deleteAllFiles/${groupId}';

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
        emit(SuccessStatedeleteallfile(messageModel!));
      } else {
        errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        emit(ErrorStatedeleteallfile(errorModel!));
      }
    } catch (error) {
      print('حدث خطأ في الاتصال بالخادم: $error');

    }
  }









}
