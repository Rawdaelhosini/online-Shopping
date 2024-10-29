import 'package:flutter/material.dart';

class onboardring3 extends StatefulWidget {
  const onboardring3({super.key});
  static String id = 'onboardring3';

  @override
  State<onboardring3> createState() => _onboardring3State();
}

class _onboardring3State extends State<onboardring3> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                 Navigator.pushNamed(context, 'LoginPage');
              },
              child: const Text(
                "SKIP",
                style: TextStyle(
                    color: Color.fromRGBO(118, 115, 115, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            //FE5F6B
            Image.asset(
              'assets/offer.png',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Exclusive Offers and Discounts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff224773),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,right: 5, top: 10
              ),
              child: Text(
                'Be the first to know about special deals and exclusive discounts. Save big on your favorite brands and products. Keep an eye out for limited-time offers that are too good to miss',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(118, 115, 115, 1),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Text(
                        '-',
                        style: TextStyle(
                            color: Color.fromRGBO(118, 115, 115, 1),
                            fontSize: 100),
                      ),
                     
                      Text(
                        '-',
                        style: TextStyle(
                            color: Color.fromRGBO(118, 115, 115, 1),
                            fontSize: 100),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                            color: Color.fromRGBO(118, 115, 115, 1),
                            fontSize: 100),
                      ),
                       Text(
                        '-',
                        style:
                            TextStyle(color: Color(0xff224773), fontSize: 100),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'LoginPage');
                      },
                      icon: const Icon(Icons.arrow_circle_right_sharp,
                          size: 50, color: Color.fromRGBO(118, 115, 115, 1))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
