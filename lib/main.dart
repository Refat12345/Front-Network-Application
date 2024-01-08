import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:google_fonts/google_fonts.dart';

import 'Cubit/authBloc/cubit.dart';
import 'Screen/getAllGroup.dart';
import 'Screen/home_page.dart';
import 'Screen/login.dart';
import 'Screen/register.dart';
import 'network/local/cache.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  // CacheHelper.saveData(
  //     key: "token", value:"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ3YXNzZW0iLCJpYXQiOjE3MDQ1MjEwOTAsImV4cCI6MTcwNDYwNzQ5MH0.3rEHgkeDp_4BWQkRl2Ih8spALgqWIgquzDwq5wIiTZ0");


  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var k = CacheHelper.getData(key: 'token');


    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Network Application',
          theme: ThemeData(
            textTheme: GoogleFonts.secularOneTextTheme(),
            useMaterial3: true,
          ),
            home: k==null? HomePage():GetAllGroup()
          // home: Login()

      ),
    );
  }
}

