import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                 Navigator.pushNamed(context, 'LoginPage');
              },
              child: const Text(
                "SKIP",
                style: TextStyle(color: Color.fromRGBO(118, 115, 115, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline),
              )),
              
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [   //E79CA3
            Image.asset('assets/onboardring1.png',),
            const SizedBox(height: 50,),
            const Text('Welcome To Online Shop',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25,color: Color.fromRGBO(118, 115, 115, 1),),),
            const Spacer(),
             Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(children: [
                const Row(
                  children: [
                    Text('-',style: TextStyle(color: Color(0xff224773),fontSize: 100),),
                     Text('-',style: TextStyle(color: Color.fromRGBO(118, 115, 115, 1),fontSize: 100),),
                      Text('-',style: TextStyle(color: Color.fromRGBO(118, 115, 115, 1),fontSize: 100),),
                      Text('-',style: TextStyle(color: Color.fromRGBO(118, 115, 115, 1),fontSize: 100),),
                  ],
                ),
                const Spacer(),
                IconButton(onPressed:() {
                     Navigator.pushNamed(context, 'onboardring');
                }, icon: const Icon(Icons.arrow_circle_right_sharp,size: 50,color: Color.fromRGBO(118, 115, 115, 1))),
               
              
              
                
              ],),
            )
          ],
        ),
      ),
    );

  }
}