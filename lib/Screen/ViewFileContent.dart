import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/File/add_file_cubit.dart';


class ViewFileContent extends StatelessWidget {

  final String text;
  final String fileName;

  ViewFileContent({required this.text, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFileCubit(),
      child: BlocConsumer<AddFileCubit, AddFileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('File Content'),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'll') {
                      AddFileCubit.get(context).downloadFile(
                          text: this.text, fileName: fileName);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'll',
                        child: Text('Download_File'),
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
                    text
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}