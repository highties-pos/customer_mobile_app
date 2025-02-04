import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/main_screen/homePage.dart';
import 'package:highties_cannabis/screens/profile_module/my_profile.dart';
import 'package:highties_cannabis/screens/registration_and_signup/register_account.dart';
import 'package:highties_cannabis/screens/sign_in.dart/sign_in.dart';
import 'package:highties_cannabis/widgets/button.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.75;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.9), BlendMode.softLight),
            image: const AssetImage(
              "assets/images/bg_img.jpg",
            ),
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
            ),
            SizedBox(height: 90),
            Buttons(
                onPressed: () {
                  Get.to(
                      () =>const SignInPage(),
                    transition: Transition.rightToLeft,
                  );
                },
                title: 'Get Started',
                height: 60,
                width: screenWidthBtn,
                textColors: Colors.black,
                colors: Colors.white),
            const SizedBox(height: 25),
            // Buttons(
            //     onPressed: () {
            //       Get.to(
            //         const SignInPage(),
            //         transition: Transition.rightToLeft,
            //       );
            //     },
            //     title: 'Sign In',
            //     height: 60,
            //     width: screenWidthBtn,
            //     textColors: Colors.black,
            //     colors: Colors.white),
            // const SizedBox(height: 25),
            // InkWell(
            //   onTap: () {
            //     Get.to(
            //         () => const RegisterAccount(),
            //       transition: Transition.rightToLeft,
            //     );
            //   },
            //   child: Text(
            //     "Sign Up",
            //     style: TextStyle(
            //         fontFamily: 'FontHead',
            //         color: Colors.white,
            //         fontSize: 16 * textScale,
            //         fontWeight: FontWeight.bold),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
