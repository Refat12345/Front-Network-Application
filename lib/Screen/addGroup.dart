import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/addgroup_cubit.dart';
import '../network/helper.dart';
import 'getAllGroup.dart';

class AddGroupScreen extends StatelessWidget {
  const AddGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _groupNameController = TextEditingController();

    return BlocProvider(
      create: (context) => AddgroupCubit(),
      child: BlocConsumer<AddgroupCubit, AddgroupState>(
        listener: (context, state) {

          if(state is SuccessState){
            if(state.addnewgroup.groupName!=null){
              flutterToast( state.addnewgroup.groupName!+'Created Succeffuly', "Sucess");

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetAllGroup()),
              );

            }






          }
          if(state is ErrorState){
            flutterToast( state.errormodel.error??'j', "error");
          }
          },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('إضافة مجموعة جديدة'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      labelText: 'اسم المجموعة',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      AddgroupCubit.get(context).addNewGroup(
                        groupName: _groupNameController.text,
                      );
                    },
                    child: Text('إضافة'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
