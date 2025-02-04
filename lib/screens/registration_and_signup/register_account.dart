import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/screens/registration_and_signup/phone_number.dart';
import 'package:highties_cannabis/screens/sign_in.dart/sign_in.dart';
import 'package:highties_cannabis/screens/success_pages/success_reset_password.dart';
import 'package:highties_cannabis/secure_storage/common.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:highties_cannabis/widgets/input.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({super.key});

  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final controller = Get.find<StateController>();
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController createPassword = TextEditingController();

  bool isChecked = false;
  bool loading = false;
  bool authInitialized = false;
  var createCusRes;
  var createCusData;
  var createCusDataInfo;
  var registerToken;
  //from_customer_app: true, email_id: admin26@gmail.com, password: 098765

  Future createCustomer(
      String fName, String emailAd, String conPassword) async {
    try {
      if (fName.trim() == '' &&
          conPassword.trim() == '' &&
          emailAd.trim() == '') {
        return showToast('Please fill up the fields!', false);
      }
      if (loading) return;
      setState(() {
        loading = true;
      });

      var payloadIs = {
        'from_customer_app': true,
        'email_id': emailAd.toString(),
        'password': conPassword.toString(),
      };
      print(' Payload is : $payloadIs');
      createCusRes = await postReq('/customers', '', payloadIs);

      if (createCusRes.statusCode == 200) {
        createCusData = jsonDecode(createCusRes.body.toString());
        setState(() {
          createCusDataInfo = createCusData['result']['user'];
          registerToken = createCusDataInfo['result']['token'];
        });
        print('createCusDataInfo');
        print(createCusDataInfo);
        print('registerToken');
        print(registerToken);
        await controller.setAuthUser(createCusDataInfo);
        await controller.setAuthToken(registerToken);
        Get.off(
          const PhoneNumber(),
          transition: Transition.rightToLeft,
        );
      } else {
        print('Error - Body');
        print(createCusRes.body.toString());

        var errorMessage = jsonDecode(createCusRes.body.toString())['message'];
        print(errorMessage);

        setState(() {
          fullName.text = '';
          emailAddress.text = '';
          createPassword.text = '';
          loading = false;
        });

        Get.showSnackbar(
          GetSnackBar(
            title: 'Error !',
            message: errorMessage,
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 35,
            ),
            borderRadius: 24,
            duration: const Duration(seconds: 3),
            isDismissible: false,
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.GROUNDED,
          ),
        );
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  Future initializeUser() async {
    await controller.initAuth();
    final authToken = controller.authToken.value;
    final authUser = controller.authUser.value;

    if (authToken != '') {
      try {
        //await updateUser();
      } catch (err) {
        print('error in logging in');
      }
    }
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        authInitialized = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeUser();
  }

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
            "Register Account",
            style: TextStyle(
                fontFamily: 'FontMain',
                color: const Color(0xff2A6443),
                fontSize: 25 * textScale,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(""),
          const SizedBox(height: 20),
          InputTextFieldWidget(
              textEditingController: fullName,
              hintText: 'Full Name',
              view: false),
          const SizedBox(height: 20),
          InputTextFieldWidget(
              textEditingController: emailAddress,
              hintText: 'Email Address',
              view: false),
          const SizedBox(height: 20),
          InputTextFieldWidget(
              textEditingController: createPassword,
              hintText: 'Create Password',
              view: true),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("By Creating account, your are accepting"),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ))),
                      child: const Text("terms & conditions")),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Buttons(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const PhoneNumber()));

                createCustomer(
                    fullName.text, emailAddress.text, createPassword.text);
              },
              title: 'Get Started',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.white,
              colors: const Color(0xff2A6443)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account ? ",
                  style: TextStyle(
                      fontFamily: 'FontMain', fontSize: 16 * textScale)),
              InkWell(
                onTap: () {
                  Get.to(() => const SignInPage(),
                      transition: Transition.rightToLeft);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign in",
                      style: TextStyle(
                          fontFamily: 'FontMain',
                          color: const Color(0xff2A6443),
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * textScale)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Center(child: Text("Or")),
          const SizedBox(height: 40),
          Buttons(
              onPressed: () {},
              title: 'Continue with Google',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.black,
              colors: Colors.white),
          const SizedBox(height: 20),
          Buttons(
              onPressed: () {},
              title: 'Continue with iCloud',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.black,
              colors: Colors.white),
        ]),
      ),
    ));
  }
}
