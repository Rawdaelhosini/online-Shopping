import 'package:api/Modules/Screens/auth_cubit/auth_Cubit.dart';
import 'package:api/Modules/Screens/auth_cubit/auth_State.dart';
import 'package:api/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatelessWidget {
  final VoidCallback onCreateAccount;
  final formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignUpWidget({super.key, required this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
         if (state is RegisterSuccessState) {
       Navigator.pushNamed(context, 'LoginPage');
        }
        else if (state is FailedRegisterState) {
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
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              color: Colors.white,
            ),
            key: key,
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Register Account',
                            style: TextStyle(
                                color: Color(0xff224773), fontSize: 24),
                          ),
                          Text(
                            'Hurry And Be One Of Us',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Inputfield(
                      title: 'UserName',
                      hint: 'xyz@gmail.com',
                      controller: usernameController,
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
                    Inputfield(
                      title: 'Phone',
                      hint: '+20*****',
                      textType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            //register
                            BlocProvider.of<AuthCubit>(context).register(
                                name: usernameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
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
                          child: Center(
                            child: Text(
                              state is RegisterLoadingState
                                  ? "Loading...."
                                  : 'Sign Up',
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
                          'Already Have Account?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff224773),
                          ),
                        ),
                        TextButton(
                          onPressed:
                              onCreateAccount, // Use the callback to switch pages
                          child: const Text(
                            'Log In',
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
      },
    );
  }
}
