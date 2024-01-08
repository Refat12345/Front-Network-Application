import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import '../Cubit/File/add_file_cubit.dart';
import '../model/getallfile.dart';
import '../network/helper.dart';
import 'ViewFile.dart';


class GetAllFilePage extends StatelessWidget {
   var groupId;

  GetAllFilePage({ this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFileCubit()..getAllFile(groupId: groupId),
      child: BlocListener<AddFileCubit, AddFileState>(
        listener: (context, state) {

          if(state is SuccessStatecheckin)
          {
            context.read<AddFileCubit>().getAllFile(groupId: groupId);
            flutterToast( state.messageModel.message??'s', "Sucess");

          }

          if(state is SuccessStatecheckout)
          {
            context.read<AddFileCubit>().getAllFile(groupId: groupId);
            flutterToast( state.messageModel.message??'s', "Sucess");

          }
          if(state is SuccessStatedeleteallfile)
          {
            context.read<AddFileCubit>().getAllFile(groupId: groupId);
            flutterToast( state.messageModel.message??'s', "Sucess");

          }
          if(state is SuccessStatedelfile)
          {
            context.read<AddFileCubit>().getAllFile(groupId: groupId);
            flutterToast( state.messageModel.message??'s', "Sucess");

          }


          if(state is SuccessStateupdate)
          {
            context.read<AddFileCubit>().getAllFile(groupId: groupId);
            flutterToast( state.messageModel.message??'s', "Sucess");

          }


        },
        child: BlocConsumer<AddFileCubit, AddFileState>(
          listener: (context, state) {


            if(state is ErrorStatecheckin){
              flutterToast( state.errormodel.error??'s', "Sucess");

            }

            if(state is ErrorStatecheckout){
              flutterToast( state.errormodel.error??'s', "Sucess");

            }



            if(state is ErrorStatedeleteallfile){
              flutterToast( state.errormodel.error??'s', "Sucess");

            }

            if(state is ErrorStateupdate){
              flutterToast( state.errormodel.error??'s', "Sucess");

            }


            if(state is ErrorStatedelfile){
              flutterToast( state.errormodel.error??'s', "Sucess");

            }






          },
          builder: (context, state) {
            GetAllFileModel? getAllFileModel =
                AddFileCubit.get(context).getAllFileModel;

            return Scaffold(
              appBar: AppBar(
                title: Text('Get All Files'),
                actions: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'checkin') {
                        AddFileCubit.get(context).checkIn();
                      }
                      if (value == 'checkout') {
                        AddFileCubit.get(context).checkOut();
                      }

                      if (value == 'deleteallfile') {
                        AddFileCubit.get(context).deleteAllFileInGroup(groupId: groupId);
                      }

                      if (value == 'updatefile') {

                        AddFileCubit.get(context).pickUpdateFile(context,this.groupId);

                      }

                      if (value == 'delete_File') {
                        AddFileCubit.get(context).deleteFile(groupId:this.groupId);

                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'checkin',
                          child: Text('Check-in'),
                        ),
                        PopupMenuItem<String>(
                          value: 'checkout',
                          child: Text('Check-out'),
                        ),

                        PopupMenuItem<String>(
                          value: 'deleteallfile',
                          child: Text('Delete-All-File'),
                        ),

                        PopupMenuItem<String>(
                          value: 'updatefile',
                          child: Text('Update_File'),
                        ),

                        PopupMenuItem<String>(
                          value: 'delete_File',
                          child: Text('delete_File'),
                        ),

                      ];
                    },
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: ()async=>context.read<AddFileCubit>().getAllFile(groupId: groupId),

                child: ListView.builder(
                  itemCount: getAllFileModel?.groupFilesDTOResponses?.length ?? 0,
                  itemBuilder: (context, index) {



                    String? fileName = getAllFileModel?.groupFilesDTOResponses![index].fileName;
                    String trimmedFileName = fileName!.replaceAll(RegExp(r'\d+$'), '');


                    return ListTile(
                      leading: Icon(Icons.file_copy),
                      title: Text(trimmedFileName),
                      subtitle: Text(''),
                        trailing: getAllFileModel?.groupFilesDTOResponses![index].status == true
                           ? Icon(Icons.check_circle, color: Colors.green)
                           : Icon(Icons.remove_circle, color: Colors.grey),
                      onTap: () {
                        if(AddFileCubit.get(context).selectedIds.length!=0){
                          AddFileCubit.get(context).toggleSelection(getAllFileModel?.groupFilesDTOResponses![index].fileId??0);
                        }

                        if(AddFileCubit.get(context).selectedIds.length==0){
                          AddFileCubit.get(context).getFileContent(groupID:this.groupId,
                              fileName: trimmedFileName,context: context);
                        }


                      },
                      onLongPress: () {
                        AddFileCubit.get(context)
                            .toggleSelection(getAllFileModel?.groupFilesDTOResponses![index].fileId??0);
                      },
                        tileColor: AddFileCubit.get(context).selectedIds.contains(getAllFileModel?.groupFilesDTOResponses![index].fileId) ? Colors.blue:null,

                    );
                  },
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AddFileCubit.get(context).pickFile(context,this.groupId);
                },
                child: Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}




