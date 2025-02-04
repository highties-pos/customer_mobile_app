import 'package:flutter/material.dart';
import 'package:highties_cannabis/screens/sign_in.dart/sign_in.dart';
import 'package:highties_cannabis/widgets/button.dart';

class YourAllSet extends StatefulWidget {
  const YourAllSet({super.key});

  @override
  State<YourAllSet> createState() => _YourAllSetState();
}

class _YourAllSetState extends State<YourAllSet> {
  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    double screenWidth = MediaQuery.of(context).size.width * 0.25;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "You're All Set",
              style: TextStyle(
                  fontFamily: 'FontMain',
                  color: const Color(0xff2A6443),
                  fontSize: 25 * textScale,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus, eget erat bibendum in magna pretium rhoncus ut."),
            const SizedBox(height: 20),
            Buttons(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              },
              title: 'Finish',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.white,
              colors: const Color(0xff2A6443),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    ));
  }
}
