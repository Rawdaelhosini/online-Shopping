
// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:api/Modules/Screens/auth_cubit/auth_Cubit.dart';
import 'package:api/Modules/Screens/auth_cubit/auth_State.dart';
import 'package:api/layout/layout_screen.dart';
import 'package:api/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatelessWidget {
  final VoidCallback onCreateAccount;
  final formKey= GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

   LoginWidget({Key? key, required this.onCreateAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LayoutScreen()));
        }
        else if (state is FailedToLoginState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
        }
      },
      builder: (context,state){
        return  Form(
      key: formKey,
      child: Padding(
         padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
            color: Colors.white,
          ),
          key: key,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Hello Again!',
                        style: TextStyle(color: Color(0xff224773), fontSize: 24),
                      ),
                      Text(
                        'Fill your details',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Inputfield(
                  title: 'Email Address',
                  hint: 'xyz@gmail.com',
                  controller: emailController,
                  textType: TextInputType.emailAddress,
                ),
                Inputfield(
                  title: 'Password',
                  hint: '******',
                  isPassword: true,
                  textType: TextInputType.visiblePassword,
                  controller: passwordController,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(''),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                     if (formKey.currentState!.validate() == true) {
                      BlocProvider.of<AuthCubit>(context).login(
                                email: emailController.text,
                                password: passwordController.text);
                     }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff224773).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 300,
                      height: 50,
                      child:  Center(
                        child: Text(
                          state is LoginLoadingState
                                  ? "Loading....":
                          'Sign In',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New User?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff224773),
                      ),
                    ),
                    TextButton(
                      onPressed: onCreateAccount, // Use the callback to switch pages
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  
  
      }, );
    
    
    
    
    
    
   
  
  }
}

