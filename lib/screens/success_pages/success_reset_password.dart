import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/main_screen/homePage.dart';
import 'package:highties_cannabis/screens/sign_in.dart/sign_in.dart';
import 'package:highties_cannabis/widgets/button.dart';

class SuccessReset extends StatefulWidget {
  const SuccessReset({super.key});

  @override
  State<SuccessReset> createState() => _SuccessResetState();
}

class _SuccessResetState extends State<SuccessReset> {
  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    double screenWidth = MediaQuery.of(context).size.width * 0.25;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 500,
              child: Center(
                child: const FaIcon(
                  FontAwesomeIcons.circleCheck,
                  color: Colors.green,
                  size: 100,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Customer Created Successfully",
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
              },
              title: 'Next',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.white,
              colors: const Color(0xff2A6443),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
