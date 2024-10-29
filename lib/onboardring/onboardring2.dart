import 'package:flutter/material.dart';

class onboardring2 extends StatefulWidget {
  const onboardring2({super.key});
  static String id = 'onboardring2';

  @override
  State<onboardring2> createState() => _onboardring2State();
}

class _onboardring2State extends State<onboardring2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'assets/onboardring2.png',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Personalized Recommendations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff224773),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 5, top: 10),
              child: Text(
                'Your preferences matter. Enjoy a personalized shopping experience with recommendations tailored just for you. The more you explore, the better we get at suggestir items you\'ll love.',
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
                        style:
                            TextStyle(color: Color(0xff224773), fontSize: 100),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                            color: Color.fromRGBO(118, 115, 115, 1),
                            fontSize: 100),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'onboardring3');
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
