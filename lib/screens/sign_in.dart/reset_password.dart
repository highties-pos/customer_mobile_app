import 'package:flutter/material.dart';
import 'package:highties_cannabis/screens/otp/successfull_page.dart';
import 'package:highties_cannabis/screens/success_pages/success_reset_password.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:highties_cannabis/widgets/input.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController resetPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(children: [
        const SizedBox(height: 20),
        Text(
          "Reset Password",
          style: TextStyle(
              fontFamily: 'FontMain',
              color: const Color(0xff2A6443),
              fontSize: 25 * textScale,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 70),
        const Text(""),
        const SizedBox(height: 70),
        InputTextFieldWidget(
            textEditingController: resetPassword,
            hintText: 'ex : johnDoe@gmail.com',
            view: false),
        const SizedBox(height: 20),
        Buttons(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SuccessReset()));
            },
            title: 'Reset Now',
            height: 60,
            width: screenWidthBtn,
            textColors: Colors.white,
            colors: const Color(0xff2A6443)),
      ]),
    )));
  }
}
