
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/getmembersingroup_cubit.dart';
import '../model/getmembermodel.dart';
import '../network/helper.dart';
import 'getAllUserOutOfThisGroup.dart';

class GetAllGroupMembers extends StatelessWidget {
  int? groupId;


  GetAllGroupMembers({
    this.groupId,
  });


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => GetmembersingroupCubit()..getMembers(this.groupId),
      child: BlocListener<GetmembersingroupCubit, GetmembersingroupState>(
        listener: (context, state) {

          if(state is SuccessStateedel)
          {
            context.read<GetmembersingroupCubit>().getMembers(this.groupId);
            flutterToast( state.messageModel.message!, "Sucess");
          }



        },
        child: BlocConsumer<GetmembersingroupCubit, GetmembersingroupState>(
          listener: (context, state) {

            if(state is ErrorStateedel){
              flutterToast( state.errormodel.error!, "Sucess");

            }

          },
          builder: (context, state) {
            GetMemberModel? getmembermodel  =
                GetmembersingroupCubit.get(context).getmembersmodle;
            return  getmembermodel!=null ?Scaffold(

              appBar: AppBar(title: Text('Members'),
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    GetmembersingroupCubit.get(context).getMembers(this.groupId);
                  },
                ),
              ],
              ),
              body: getmembermodel?.membersDTOS?.length != 0 ?RefreshIndicator(
                onRefresh: ()async=>context.read<GetmembersingroupCubit>().getMembers(this.groupId),

                child: ListView.builder(
                  itemCount: getmembermodel?.membersDTOS?.length,
                  itemBuilder: (context, index) {
                    return ListTile(

                      onLongPress: (){

                        showDialog(
                          context: context,
                          builder: (BuildContext contextt) {
                            return AlertDialog(
                              title: Text('حدد الخيار الذي ترغب به'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('حذف المستخدم'),
                                  onPressed: () {
                                    GetmembersingroupCubit.get(context).deleteUser(groupId:groupId,userId:getmembermodel?.membersDTOS?[index].userId,);

                                  },
                                ),
                              ],
                            );
                          },
                        );





                    },
                      leading: Icon( Icons.person),
                      title: Text(getmembermodel?.membersDTOS?[index].userName??'null'), // اسم المستخدم
                    );
                  },

                ),

              ):const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),)
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetMemberOutOfGroup(groupId:this.groupId)),
                  );
                },
                child: Icon(Icons.add),
              ),

            ): const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),));;
          },
        ),
      ),
    );
  }

}


