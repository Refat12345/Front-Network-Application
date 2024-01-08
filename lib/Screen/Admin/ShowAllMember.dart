
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkapplication/Screen/Admin/showlog.dart';

import '../../Cubit/Admin/admin_cubit.dart';
import '../../model/Admin/getallusermodel.dart';
import '../../network/local/cache.dart';
import '../home_page.dart';


class ShowAllMember extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AdminCubit()..getAllUser(),
      child: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {





        },
        child: BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {



          },
          builder: (context, state) {
            GetAllUserModel? getAllUserModel  =
                AdminCubit.get(context).getAllUserModel;
            return  getAllUserModel!=null ?Scaffold(

              appBar: AppBar(title: Text('Members'),),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),

                      child: Text('Welcome'),
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
              body: getAllUserModel?.userSearchDTOS?.length != 0 ?RefreshIndicator(
                onRefresh: ()async=>context.read<AdminCubit>().getAllUser(),

                child: ListView.builder(
                  itemCount: getAllUserModel?.userSearchDTOS?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowLogScreen(getAllUserModel?.userSearchDTOS?[index].userId,getAllUserModel?.userSearchDTOS?[index].userName),
                          ),
                        );

                      },
                      leading: Icon( Icons.person),
                      title: Text(getAllUserModel?.userSearchDTOS?[index].userName??'null'), // اسم المستخدم
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


