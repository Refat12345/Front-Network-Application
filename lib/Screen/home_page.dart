import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkapplication/Screen/register.dart';

import '../Cubit/authBloc/cubit.dart';
import '../Cubit/authBloc/state.dart';
import 'login.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(children: [
            const Image(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage('images/login.jpg')),
            AuthCubit.get(context).status ?  Login() :  Register()
          ]),
        );
      },
    ));
  }
}
