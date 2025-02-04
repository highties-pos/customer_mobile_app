import 'package:flutter/material.dart';
import 'package:highties_cannabis/screens/registration_and_signup/get_started.dart';

class SplashScreenPage2 extends StatefulWidget {
  const SplashScreenPage2({super.key});

  @override
  State<SplashScreenPage2> createState() => _SplashScreenPage2State();
}

class _SplashScreenPage2State extends State<SplashScreenPage2> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const GetStartedScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.9), BlendMode.softLight),
            image: AssetImage("assets/images/bg_img.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_2.png',
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}
