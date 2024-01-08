import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Cubit/get_my_group_cubit.dart';

import '../model/getmygroupmodel.dart';

import '../network/helper.dart';
import 'getAllFile.dart';
import 'getMembersInGroup.dart';

class GetMyGroup extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMyGroupCubit()..getMyGroup(),
      child: BlocListener<GetMyGroupCubit, GetMyGroupState>(
        listener: (context, state) {

          if(state is SuccessStatedeletegroup1)
          {
            context.read<GetMyGroupCubit>().getMyGroup();
            flutterToast( state.messageModel.message??'s', "Sucess");

          }



        },
        child: BlocConsumer<GetMyGroupCubit, GetMyGroupState>(
          listener: (context, state) {

            if(state is ErrorStatedeletegroup1){
              flutterToast( state.errormodel.error??'null', "error");
            }

          },
          builder: (context, state) {
            GetMyGroupModel? getMyGroupModel =
                GetMyGroupCubit.get(context).getMyGroupModel;
            if (getMyGroupModel == null) {
              Fluttertoast.showToast(
                msg: "ليس لديك أي مجموعة تملكها",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }

            return getMyGroupModel!=null ?Scaffold(
              appBar: AppBar(backgroundColor: Colors.deepPurple,title: Text('My Group',style: TextStyle(color: Colors.black,fontSize: 25),),),

              body: RefreshIndicator(
                onRefresh: ()async=>context.read<GetMyGroupCubit>().getMyGroup(),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                    itemCount: getMyGroupModel?.userGroupsDTOResponses?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.group),
                        title: Text(   getMyGroupModel
                            ?.userGroupsDTOResponses![index].groupName ??
                            'ds',),

                        onLongPress: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext contextt) {
                              return AlertDialog(
                                title: Text('حدد الخيار الذي ترغب به'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('عرض أعضاء الغروب'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GetAllGroupMembers(groupId: getMyGroupModel?.userGroupsDTOResponses![index].groupID),
                                        ),
                                      );
                                    },
                                  ),

                                  //Edit


                                  TextButton(
                                    child: Text('حذف الغروب'),
                                    onPressed: () {

                                      GetMyGroupCubit.get(context).deleteGroup(groupID: getMyGroupModel.userGroupsDTOResponses?[index].groupID);
                                    },
                                  ),



                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),


            ) : const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),));

          },
        ),
      ),
    );
  }
}

