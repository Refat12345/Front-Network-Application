import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:networkapplication/Screen/home_page.dart';

import '../Cubit/getallgroup_cubit.dart';
import '../model/getallgroupmodel.dart';
import '../network/helper.dart';
import '../network/local/cache.dart';
import 'addGroup.dart';
import 'getAllFile.dart';
import 'getMembersInGroup.dart';
import 'getMyGroup.dart';

class GetAllGroup extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetallgroupCubit()..getAllGroups(),
      child: BlocListener<GetallgroupCubit, GetallgroupState>(
        listener: (context, state) {
          if(state is SuccessStateleavegroup){
            if(state.messageModel.message!=null){
              context.read<GetallgroupCubit>().getAllGroups();

              flutterToast( state.messageModel.message??'null', "error");

            }
          }


        },
        child: BlocConsumer<GetallgroupCubit, GetallgroupState>(
          listener: (context, state) {


            if(state is ErrorStateleavegroup){
              flutterToast( state.errormodel.error??'null', "error");
            }




          },
          builder: (context, state) {
            var k = 'Welcome '+CacheHelper.getData(key: 'username');
            GetAllGroupmodel? getAllGroupmodel =
                GetallgroupCubit.get(context).getAllGroupmodel;
            return getAllGroupmodel!=null ?Scaffold(
              appBar: AppBar(backgroundColor: Colors.deepPurple,title: Text('All Group',style: TextStyle(color: Colors.black,fontSize: 25),),),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                     DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),

                      child: Text(k),
                    ),
                    ListTile(
                      title: const Text('Show group members'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GetMyGroup()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('LOG OUT'),
                      onTap: () {
                         CacheHelper.removeData(key: 'token');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              body: RefreshIndicator(
                onRefresh: ()async=>context.read<GetallgroupCubit>().getAllGroups(),

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                    itemCount: getAllGroupmodel?.userGroupsDTOResponses?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.group),
                        title: Text(   getAllGroupmodel
                            ?.userGroupsDTOResponses![index].groupName ??
                            'ds',),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetAllFilePage(groupId: getAllGroupmodel
                                  ?.userGroupsDTOResponses![index].groupID,),
                            ),
                          );
                        },


                        onLongPress: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext contextt) {
                              return AlertDialog(
                                title: Text('حدد الخيار الذي ترغب به'),
                                actions: <Widget>[

                                  TextButton(
                                    child: Text('مغادرة الغروب'),
                                    onPressed: () {

                                      GetallgroupCubit.get(context).leaveGroup(groupID: getAllGroupmodel.userGroupsDTOResponses?[index].groupID);
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

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddGroupScreen()),
                  );
                },
                child: Icon(Icons.add),
              ),



            ) : const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),)

            );

            },
        ),
      ),
    );

  }

}

