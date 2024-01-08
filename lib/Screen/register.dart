import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Cubit/authBloc/cubit.dart';
import '../Cubit/authBloc/state.dart';
import '../network/local/cache.dart';
import '../style/color.dart';
import 'getAllGroup.dart';

class Register extends StatelessWidget {
   Register({super.key});
  final TextEditingController userName=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController confirmPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthRegisterSuccessState){
          CacheHelper.saveData(
              key: "token", value:state.registerModel.token);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetAllGroup(),
            ),
          );

        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                height: size.height *
                    (size.height > 770
                        ? 0.75
                        : size.height > 670
                            ? 0.6
                            : 0.8),
                width: 430,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 30, bottom: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),


                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Enter Verify Code"),
                                        content: TextField(
                                          decoration: InputDecoration(
                                            hintText: "Enter code",
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              AuthCubit.get(context).registerAdmin(username: userName.text, password: password.text, confirmPassword: confirmPassword.text,verificationCode:'SHADOWEN');
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.person_add,
                                  color: Colors.grey[700],
                                  size: 18,
                                ),
                              ),


                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: 30,
                            child: Divider(
                              color: MyColors.primaryColor,
                              thickness: 2,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           TextFormField(
                             controller: userName,
                            decoration:const InputDecoration(
                              hintText: 'UserName',
                              labelText: 'UserName',
                              suffixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              suffixIcon: Icon(
                                Icons.lock_outline,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           TextFormField(
                             controller: confirmPassword,
                            decoration:const InputDecoration(
                              hintText: 'ConfirmPassword',
                              labelText: 'ConfirmPassword',
                              suffixIcon: Icon(
                                Icons.lock_outline,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ZoomTapAnimation(
                            onTap: (){
                                AuthCubit.get(context).register(username: userName.text, password: password.text, confirmPassword: confirmPassword.text);
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ZoomTapAnimation(
                                onTap: () {
                                  AuthCubit.get(context).change();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Log In",
                                      style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: MyColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
