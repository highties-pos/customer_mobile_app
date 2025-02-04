import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:highties_cannabis/screens/registration_and_signup/splash_screen2.dart';

class SplashScreenPage1 extends StatefulWidget {
  const SplashScreenPage1({super.key});

  @override
  State<SplashScreenPage1> createState() => _SplashScreenPage1State();
}

class _SplashScreenPage1State extends State<SplashScreenPage1> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SplashScreenPage2()));
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
                'assets/images/logo_1.png',
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}
