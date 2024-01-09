
 import 'dart:convert';
import 'dart:io';
 import 'dart:typed_data';

 import 'package:flutter/material.dart';
 import 'package:file_picker/file_picker.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/File/add_file_cubit.dart';
import '../network/helper.dart';
import 'getAllFile.dart';
import 'getAllGroup.dart';


class FileViewerScreen extends StatelessWidget {
  final Uint8List fileBytes;
  int groupId;
  var fileName;

  FileViewerScreen({required this.fileBytes, required this.groupId,required this.fileName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFileCubit(),
      child: BlocConsumer<AddFileCubit, AddFileState>(
        listener: (context, state) {
          if(state is SuccessStateadd)
          {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => GetAllFilePage(groupId: groupId)),
            );




            flutterToast( state.messageModel.message??'s', "Sucess");

          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('File Viewer'),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                     if (value == 'Addfile') {
                       AddFileCubit.get(context).addNewFile(fileBytes: fileBytes, groupId: groupId,fileName: this.fileName);
                     }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'Addfile',
                        child: Text('Add-File'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                //  String.fromCharCodes(fileBytes,),
                  Utf8Decoder().convert(fileBytes),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}