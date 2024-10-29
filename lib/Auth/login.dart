
import 'package:api/widgets/LoginWidget.dart';
import 'package:api/widgets/signUpWidget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showFirstPage = true;

  void _togglePage() {
    setState(() {
      _showFirstPage = !_showFirstPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff224773),
      body: Column(children: [
        Center(
            child: Image.asset(
          'assets/logo.png',
          height: 190,
        )),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeInOutCirc,
                switchOutCurve: Curves.easeOutCirc,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                duration: const Duration(seconds: 1),
                child: _showFirstPage
                    ? LoginWidget(
                        key: const ValueKey('FirstPage'),
                        onCreateAccount: _togglePage,
                      )
                    : SignUpWidget(key: const ValueKey('SecondPage'),onCreateAccount: _togglePage,),
              ),
            ),
          ),
        ),
      ]),
     
    );
  }
}


