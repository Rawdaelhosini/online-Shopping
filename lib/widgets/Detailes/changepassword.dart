import 'package:api/Shared/constants/constants.dart';
import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Changepassword extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  Changepassword({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style:
              TextStyle(color: Color(0xff224773), fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Inputfield(
              hint: '******',
              title: 'Current Password',
              widget: const Icon(Icons.remove_red_eye_outlined),
              textType: TextInputType.visiblePassword,
              isPassword: true,
              controller: currentPasswordController,
            ),
            Inputfield(
              hint: '******',
              title: 'New Password',
              widget: const Icon(Icons.remove_red_eye_outlined),
              textType: TextInputType.visiblePassword,
              isPassword: true,
              controller: newPasswordController,
            ),
            BlocConsumer<LayoutCubit, LayoutStatus>(
              listener: (context, state) {
                if (state is getChangePasswordSuccessState) {
                  showSnackBarItem(
                      context, "Password Updated Successfully", true);
                  Navigator.pop(context);
                }
                if (state is FailedTogetChangePasswordState) {
                  showSnackBarItem(context, state.error, false);
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (currentPasswordController.text.trim() ==
                        currentPassword) {
                      if (newPasswordController.text.length >= 6) {
                        cubit.changePassword(
                            userCurrentPassword: currentPassword!,
                            newPassword: newPasswordController.text.trim());
                      } else {
                        showSnackBarItem(context,
                            'Password Must be at least 6 characters', false);
                      }
                    } else {
                      showSnackBarItem(
                          context,
                          "please , verify Current Password, try again later",
                          false);
                    }
                  },
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(Color(0xff224773)),
                  ),
                  child: Text(state is getChangePasswordLoadingState
                      ? "Loading.."
                      : 'Update'),
                );

                // MaterialButton(
                //   onPressed: () {
                //     if (currentPasswordController.text.trim() ==
                //         currentPassword) {
                //       if (newPasswordController.text.length >= 6) {
                //         cubit.changePassword(
                //             userCurrentPassword: currentPassword!,
                //             newPassword: newPasswordController.text.trim());
                //       } else {
                //         showSnackBarItem(context,
                //             'Password Must be at least 6 characters', false);
                //       }
                //     } else {
                //       showSnackBarItem(
                //           context,
                //           "please , verify Current Password, try again later",
                //           false);
                //     }
                //   },
                //   color: Color(0xff224773),
                //   textColor: Colors.white,
                //   child: Text(state is getChangePasswordLoadingState
                //       ? "Loading.."
                //       : 'UPdate'),
                // );
              },
            )
          ],
        ),
      ),
    );
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
    ));
  }
}
