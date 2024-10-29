import 'package:api/Auth/login.dart';
import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/Detailes/changepassword.dart';
import 'package:api/widgets/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static String id = 'Profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body: cubit.userModel != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff224773),
                              backgroundImage:
                                  NetworkImage(cubit.userModel!.image!),
                              radius: 72,
                            ),
                            CircleAvatar(
                              backgroundColor: Color(0xff224773),
                              child: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: const Alignment(0.8, -0.80),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 64),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff224773), width: 1),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                _buildInfoField(
                                  label: 'UserName',
                                  value: cubit.userModel!.name!,
                                ),
                                _buildInfoField(
                                  label: 'Email',
                                  value: cubit.userModel!.email!,
                                ),
                                _buildInfoField(
                                  label: 'Phone',
                                  value: cubit.userModel!.phone!,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Changepassword()));
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Color(0xff224773)),
                                        ),
                                        child: Text('Change Password')),
                                    BlocConsumer<LayoutCubit, LayoutStatus>(
                                      listener: (context, state) {
                                        if (state is LogoutLoading) {
                                        } else if (state is LogoutSuccess) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                            (Route<dynamic> route) => false,
                                          );
                                        } else if (state is LogoutFailure) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(state.error)),
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                final cubit =
                                                    context.read<LayoutCubit>();
                                                cubit.logout();
                                              },
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.white),
                                                shape: WidgetStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.red),
                                              ),
                                              child: Text('LogOut')),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),

                            /**/
                          ),
                        ),
                        GestureDetector(
                          onTap: () => animatedNavigateTo(
                              context: context,
                              widget: Editprofilescreen(),
                              direction: PageTransitionType.rightToLeft,
                              curve: Curves.fastOutSlowIn),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff224773),
                            radius: 26,
                            child: const Icon(
                              Icons.settings_suggest_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Image.asset(
                    "assets/loading-cargando.gif",
                    height: 100,
                    width: 100,
                  ),
                ),
        );
      },
    );
  }

  Widget _buildInfoField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xff224773),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: 50, // Limit height
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                value,
                maxLines: 1, // Limit the number of lines
                overflow: TextOverflow.ellipsis, // Show ellipsis if overflow
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

void animatedNavigateTo({
  required BuildContext context,
  required Widget widget,
  required PageTransitionType direction,
  Curve curve = Curves.linear,
}) {
  Navigator.push(
    context,
    PageTransition(
      type: direction,
      child: widget,
      curve: curve,
      duration: Duration(milliseconds: 500), // Adjust duration as needed
    ),
  );
}
