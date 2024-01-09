
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/getmemberoutofgroup_cubit.dart';
import '../Cubit/getmembersingroup_cubit.dart';
import '../model/getAllUserOutOfThisGroupmodel.dart';
import '../model/getmembermodel.dart';
import '../network/helper.dart';
import 'getMembersInGroup.dart';

class GetMemberOutOfGroup extends StatelessWidget {
  int? groupId;


  GetMemberOutOfGroup({
    this.groupId,
  });



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => GetmemberoutofgroupCubit()..getMembersOutOfGroup(this.groupId),
      child: BlocListener<GetmemberoutofgroupCubit,GetmemberoutofgroupState>(
        listener: (context, state) {


          if(state is SuccessState6)
          {
            context.read<GetmemberoutofgroupCubit>().getMembersOutOfGroup( groupId);
            flutterToast( state.messageModel.message!, "Sucess");

            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => GetAllGroupMembers(groupId: groupId)),
            );

          }

        },
        child: BlocConsumer<GetmemberoutofgroupCubit, GetmemberoutofgroupState>(
          listener: (context, state) {

            if(state is ErrorState6){
              flutterToast( state.errorModel.error!, "Sucess");

            }

          },
          builder: (context, state) {
            GetAllUserOutOfThisGroupModel? getAllUserOutOfThisGroupModel  =
                GetmemberoutofgroupCubit.get(context).getAllUserOutOfThisGroupModel;
            return  getAllUserOutOfThisGroupModel!=null ?Scaffold(

              appBar: AppBar(title: Text('Add User To Group '),),
              body: getAllUserOutOfThisGroupModel?.userSearchDTOS?.length != 0 ?RefreshIndicator(
                onRefresh: ()async=>context.read<GetmemberoutofgroupCubit>().getMembersOutOfGroup(this.groupId),

                child: ListView.builder(
                  itemCount: getAllUserOutOfThisGroupModel?.userSearchDTOS?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        flutterToast( "اضغط مطولا اذا كنت تريد اضافة المستخدم للمجموعة", "Sucess");

                      },

                      onLongPress: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext contextt) {
                            return AlertDialog(
                              title: Text('حدد الخيار الذي ترغب به'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('اضافة المستخدم للغروب '),
                                  onPressed: () {
                                    GetmemberoutofgroupCubit.get(context).addUserToGroup(groupId: groupId,userId: getAllUserOutOfThisGroupModel?.userSearchDTOS?[index].userId);

                                  },
                                ),
                              ],
                            );
                          },
                        );




                      },
                      leading: Icon( Icons.person),
                      title: Text(getAllUserOutOfThisGroupModel?.userSearchDTOS?[index].userName??'null'), // اسم المستخدم
                    );
                  },
                ),
              ):const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),)
              ),
            ): const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),));;
          },
        ),
      ),
    );
  }

}


