import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/otp/personal_info.dart';
import 'package:highties_cannabis/secure_storage/common.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:highties_cannabis/widgets/input.dart';

class VerificationMobile extends StatefulWidget {
  final phoneData;
  VerificationMobile({super.key, required this.phoneData});

  @override
  State<VerificationMobile> createState() => _VerificationMobileState();
}

class _VerificationMobileState extends State<VerificationMobile> {
  final controller = Get.find<StateController>();
  var otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  var userData;
  var userToken;
  bool loading = false;

  var verifyOTPRes;
  var verifyOTPData;
  var verifyOTPDataInfo;

  bool isResendButtonEnabled = false;
  late Timer _timer;
  int _start = 60;

  Future verifyOtp(String otp) async {
    try {
      if (otp.trim() == '') {
        return showToast('Please Enter the OTP!', false);
      }
      if (loading) return;
      setState(() {
        loading = true;
      });

      var payloadIs = {
        "mobile_no": widget.phoneData.toString(),
        "otp": otp.toString()
      };
      print(' Payload is : $payloadIs');
      verifyOTPRes = await postReq(
          '/customers/${userData['id'].toString()}/verify-otp/update',
          controller.authToken.value,
          payloadIs);

      if (verifyOTPRes.statusCode == 200) {
        verifyOTPData = jsonDecode(verifyOTPRes.body.toString());
        print('verifyOTPData');
        print(verifyOTPData['message']);
        // Get.off(
        //   () => DashboardPage(),
        //   transition: Transition.rightToLeft,
        // );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {
        print('Error - Body');
        print(verifyOTPRes.body.toString());

        var errorMessage = jsonDecode(verifyOTPRes.body.toString())['message'];
        print(errorMessage);

        showToast(errorMessage, false);
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  initialize() async {
    updateUser();
    print(controller);
    userData = controller.authUser.value;
    userToken = controller.authToken.value;
    print('userData is ${userData}');
    print('userToken is ${userToken}');
    print('phoneData is ${widget.phoneData}');
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _start = 60;
      isResendButtonEnabled = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          isResendButtonEnabled = true;
        });
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    double screenWidth = MediaQuery.of(context).size.width * 0.30;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                "Verify Phone Number",
                style: TextStyle(
                    fontFamily: 'FontMain',
                    color: const Color(0xff2A6443),
                    fontSize: 25 * textScale,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(""),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NumberWidget(handleChange: (val) {
                    otpControllers[0].text = val;
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  NumberWidget(handleChange: (val) {
                    otpControllers[1].text = val;
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  NumberWidget(handleChange: (val) {
                    otpControllers[2].text = val;
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  NumberWidget(handleChange: (val) {
                    otpControllers[3].text = val;
                  }),
                  Buttons(
                      onPressed: () =>
                          isResendButtonEnabled ? startTimer() : null,
                      title: 'Resend',
                      height: 50,
                      width: screenWidth,
                      textColors: Colors.white,
                      colors: isResendButtonEnabled
                          ? const Color(0xff2A6443)
                          : Colors.grey),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Resend OTP in",
                      style: TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * textScale)),
                  Container(
                    child: Text(" ${_start}s",
                        style: TextStyle(
                            fontFamily: 'FontMain',
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * textScale)),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Buttons(
                onPressed: () {
                  verifyOtp(
                      '${otpControllers[0].text}${otpControllers[1].text}${otpControllers[2].text}${otpControllers[3].text}');
                  //
                },
                title: loading ? 'Please wait...' : "CONFIRM",
                height: 50,
                width: screenWidthBtn,
                textColors: Colors.white,
                colors: const Color(0xff2A6443),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Incorrect mobile Number ? ",
                      style: TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * textScale)),
                  Container(
                    child: Text("Edit now",
                        style: TextStyle(
                            fontFamily: 'FontMain',
                            color: const Color(0xff2A6443),
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * textScale)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.handleChange,
  });
  final Function(String val) handleChange;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      height: 40,
      width: 40,
      child: TextField(
        cursorColor: const Color(0xff2A6443),
        style: const TextStyle(
          fontFamily: 'FontMain',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          hintText: "-",
          hintStyle: TextStyle(
              fontFamily: 'FontMain',
              color: Colors.grey[300],
              fontSize: 22 * textScale,
              fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) {
          handleChange(value);
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
