import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Editprofilescreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  Editprofilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    usernameController.text = cubit.userModel!.name!;
    emailController.text = cubit.userModel!.email!;
    phoneController.text = cubit.userModel!.phone!;
    // passwordController.text= cubit.userModel!.pa!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit",
          style:
              TextStyle(color: Color(0xff224773), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Inputfield(
                hint: 'Enter Your Name',
                title: 'Enter Your Name',
                controller: usernameController,
              ),
              Inputfield(
                hint: 'xyz@gmail.com',
                title: 'Email Address',
                controller: emailController,
              ),
              Inputfield(
                hint: '+20*****',
                title: "Phone",
                controller: phoneController,
                textType: TextInputType.phone,
              ),
              BlocConsumer<LayoutCubit, LayoutStatus>(
                listener: (context, state) {
                  if (state is UpdateUserDataSuccessState) {
                    showSnackBarItem(
                        context, 'Data Updated Successfully', true);
                    Navigator.pop(context);
                  }
                  if (state is FailedTogetUpdateUserDataState) {
                    showSnackBarItem(context, state.error, false);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        if (usernameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            phoneController.text.isNotEmpty) {
                        
                            cubit.updateUserData(
                                name: usernameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                         
                        } else {
                          showSnackBarItem(
                              context, 'Please, Enter All Data !!', false);
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xff224773)),
                      ),
                      child: Text('Update'));
                },
              ),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //       title: Text(
    //     'Edit',
    //     style: TextStyle(color: Color(0xff224773), fontWeight: FontWeight.bold),
    //   )),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         TextFormField(
    //           controller: currentPasswordController,
    //           decoration: InputDecoration(
    //             border: OutlineInputBorder(),
    //             labelText: "Current Password",
    //           ),
    //         ),
    //         SizedBox(
    //           height: 12,
    //         ),
    //         TextFormField(
    //           controller: newPasswordController,
    //           decoration: InputDecoration(
    //             border: OutlineInputBorder(),
    //             labelText: "New Password",
    //           ),
    //         ),
    //         BlocConsumer<LayoutCubit, LayoutStatus>(
    //           listener: (context, state) {
    //             if (state is getChangePasswordSuccessState) {
    //               showSnackBarItem(
    //                   context, "Password Updated Successfully", true);
    //               Navigator.pop(context);
    //             }
    //             if (state is FailedTogetChangePasswordState) {
    //               showSnackBarItem(context, state.error, false);
    //             }
    //           },
    //           builder: (context, state) {
    //             return MaterialButton(
    //               onPressed: () {
    //                 if (currentPasswordController.text.trim() ==
    //                     currentPassword) {
    //                   if (newPasswordController.text.length >= 6) {
    //                     cubit.changePassword(
    //                         userCurrentPassword: currentPassword!,
    //                         newPassword: newPasswordController.text.trim());
    //                   } else {
    //                     showSnackBarItem(context,
    //                         'Password Must be at least 6 characters', false);
    //                   }
    //                 } else {
    //                   showSnackBarItem(
    //                       context,
    //                       "please , verify Current Password, try again later",
    //                       false);
    //                 }
    //               },
    //               color: Color(0xff224773),
    //               textColor: Colors.white,
    //               child: Text(state is getChangePasswordLoadingState
    //                   ? "Loading.."
    //                   : 'UPdate'),
    //             );
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
    ));
  }
}
