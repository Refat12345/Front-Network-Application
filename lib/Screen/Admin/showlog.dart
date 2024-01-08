import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkapplication/model/Admin/logmodel.dart';

import '../../Cubit/Admin/admin_cubit.dart';

class ShowLogScreen extends StatelessWidget {
  var userId;
  var userName;

  ShowLogScreen(this.userId,this.userName);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getLog(userId: this.userId),
      child: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          LogModel? logModel =
              AdminCubit.get(context).logModel;


          return Scaffold(
            appBar: AppBar(
              title: Text('User Operations'),
            ),
            body: ListView.builder(
              itemCount: logModel?.logs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name: ${this.userName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Operation: ${logModel?.logs![index].operation}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Affected ID: ${logModel?.logs![index].affectedId}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Result: ${logModel?.logs![index].result}',
                          style: TextStyle(
                            fontSize: 14,
                            color: logModel?.logs![index].result == "success"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}