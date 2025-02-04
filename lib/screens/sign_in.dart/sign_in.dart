import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/screens/invoices/invoice_list.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/main_screen/homePage.dart';
import 'package:highties_cannabis/screens/registration_and_signup/phone_number.dart';
import 'package:highties_cannabis/screens/registration_and_signup/register_account.dart';
import 'package:highties_cannabis/screens/sign_in.dart/reset_password.dart';
import 'package:highties_cannabis/secure_storage/common.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:highties_cannabis/widgets/input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = Get.find<StateController>();
  TextEditingController userNameController =
      TextEditingController(text: 'janeDoe@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  //email_id: janeDoe@gmail.com, password: 123456
  bool _isSecurePassword = true;
  bool loading = false;
  var loginResponse;
  var loginData;
  var loginDataInfo;
  var tokenInfo;
  bool authInitialized = false;
  var tokenFcm;
  var firebaseMsgToken;
  var signingIn = false;

  Future loginDetails(String userName, String password) async {
    try {
      if (userName.isEmpty || password.isEmpty) {
        return CommonMethod().showToast(context,
            title: 'Erorr',
            message: 'Please fill up the fields!',
            type: 'error');
      }
      // if (loading || signingIn) return;
      setState(() {
        loading = true;
        signingIn = true;
      });

      var payloadIs = {
        'username': userName,
        'password': password.toString(),
        'is_customer': true
      };

      loginResponse = await postReq('/auth/login', '', payloadIs);

      if (loginResponse.statusCode == 200) {
        loginData = jsonDecode(loginResponse.body.toString());

        setState(() {
          loginDataInfo = loginData['result']['user'];
          tokenInfo = loginData['result']['token'];
        });
        print("loginDataInfo : ${loginDataInfo}");
        print("tokenInfo : ${tokenInfo}");
        await controller.setAuthUser(loginDataInfo);
        await controller.setAuthToken(tokenInfo);
        Future.delayed(const Duration(seconds: 0), () {
          if (loginDataInfo['mobile_no'] == null ||
              loginDataInfo['mobile_no'].isEmpty) {
            Get.off(
              () => const PhoneNumber(),
              transition: Transition.rightToLeft,
            );
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => DashboardPage()));
          }
        });
      } else {
        print('Error - Body');
        print(loginResponse.body.toString());

        CommonMethod().showToast(
          context,
          title: 'Error !',
          message: 'Invalid Credentials',
          type: 'error',
        );
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
    setState(() {
      userNameController.text = '';
      passwordController.text = '';
      loading = false;
      signingIn = false;
    });
  }

  Future initializeUser() async {
    await controller.initAuth();
    final authToken = controller.authToken.value;
    final authUser = controller.authUser.value;

    await updateUser();
    if (authToken.isNotEmpty && (authUser == null || authUser['id'] == null)) {
      try {
        await updateUser();
        //Get.off(() => DashboardPage());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
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
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: 'FontMain',
                  color: const Color(0xff2A6443),
                  fontSize: 25 * textScale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 70),
              const Text(""),
              const SizedBox(height: 70),
              InputTextFieldWidget(
                textEditingController: userNameController,
                hintText: 'Email address',
                view: false,
              ),
              const SizedBox(height: 20),
              InputTextFieldWidget(
                textEditingController: passwordController,
                hintText: 'Password',
                view: false,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Forgotten password?",
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontSize: 16 * textScale,
                    ),
                  ),
                  Container(
                    child: Text(
                      " Reset now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FontMain',
                        color: const Color(0xff2A6443),
                        fontSize: 16 * textScale,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Buttons(
                onPressed: () {
                  loginDetails(
                    userNameController.text,
                    passwordController.text,
                  );
                },
                title: signingIn ? 'Please wait...' : 'Sign In',
                height: 60,
                width: screenWidthBtn,
                textColors: Colors.white,
                colors: const Color(0xff2A6443),
              ),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Are you new here ? ",
              //       style: TextStyle(
              //         fontFamily: 'FontMain',
              //         fontSize: 16 * textScale,
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         // Get.to(
              //         //   const RegisterAccount(),
              //         //   transition: Transition.leftToRight,
              //         // );
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           "Sign up",
              //           style: TextStyle(
              //             fontFamily: 'FontMain',
              //             color: const Color(0xff2A6443),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16 * textScale,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
