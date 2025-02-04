// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';
// import 'package:highties_cannabis/alert/toast.dart';
// import 'package:highties_cannabis/http/api_request.dart';
// import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
// import 'package:highties_cannabis/screens/otp/mobile_verification.dart';
// import 'package:highties_cannabis/secure_storage/common.dart';
// import 'package:highties_cannabis/state/state.dart';
// import 'package:highties_cannabis/widgets/button.dart';
// import 'package:highties_cannabis/widgets/dropDwn.dart';
// import 'package:highties_cannabis/widgets/input.dart';

// class PhoneNumber extends StatefulWidget {
//   const PhoneNumber({super.key});

//   @override
//   State<PhoneNumber> createState() => _PhoneNumberState();
// }

// class _PhoneNumberState extends State<PhoneNumber> {
//   final controller = Get.find<StateController>();
//   TextEditingController mobileNo = TextEditingController();
//   var userData;
//   var userToken;
//   List<dynamic> countryList = [
//     {
//       "id": '1',
//       "name": 'India',
//     },
//     {
//       "id": '2',
//       "name": 'Australia',
//     },
//     {
//       "id": '3',
//       "name": 'Egypt',
//     },
//     {
//       "id": '4',
//       "name": 'Isreal',
//     },
//     {
//       "id": '5',
//       "name": 'Sri Lanka',
//     },
//     {
//       "id": '6',
//       "name": 'United State America',
//     },
//     {
//       "id": '7',
//       "name": 'Brazil',
//     },
//     {
//       "id": '8',
//       "name": 'Chile',
//     },
//     {
//       "id": '9',
//       "name": 'England',
//     },
//     {
//       "id": '10',
//       "name": 'South Africa',
//     },
//     {
//       "id": '11',
//       "name": 'New Zealand',
//     },
//     {
//       "id": '12',
//       "name": 'France',
//     },
//   ];
//   var selectedCountry;

//   bool isChecked = false;

//   bool loading = false;

//   var generateOTPRes;
//   var generateOTPData;
//   var generateOTPDataInfo;

//   //akshay26@gmail.com
//   //123456

//   Future<void> generateOtp(String mobile) async {
//     try {
//       if (mobile.trim() == '') {
//         showToast('Please fill up the Mobile Number field!', false);
//         return;
//       }
//       if (mobile.length <= 9) {
//         showToast('Invalid Mobile Number', false);
//         return;
//       }
//       if (loading) return;

//       setState(() {
//         loading = true;
//       });

//       var payloadIs = {
//         'mobile_no': mobile.toString(),
//       };
//       print(' Payload is : $payloadIs');
//       var apiURL = "/customers/${userData['id'].toString()}/send-otp";
//       print(apiURL);
//       generateOTPRes = await postReq(apiURL, userToken, payloadIs);

//       if (generateOTPRes.statusCode == 200) {
//         generateOTPData = jsonDecode(generateOTPRes.body.toString());
//         print('generateOTPData');
//         print(generateOTPData['message']);
//         Get.off(
//           () => VerificationMobile(phoneData: mobileNo.text.toString()),
//           transition: Transition.rightToLeft,
//         );
//       } else {
//         print('Error - Body');
//         print(generateOTPRes.body.toString());

//         var errorMessage =
//             jsonDecode(generateOTPRes.body.toString())['message'];
//         print(errorMessage);

//         if (errorMessage == 'Customer not found!') {
//           showToast('User not found. Please register first.', false);
//         } else {
//           showToast(errorMessage, false);
//         }
//       }
//     } catch (e) {
//       print("Error");
//       print(e.toString());
//       showToast('An error occurred', false);
//     } finally {
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   initialize() async {
//     updateUser();
//     print(controller);
//     userData = controller.authUser.value;
//     userToken = controller.authToken.value;
//     print('userData is ${userData}');
//     print('userToken is ${userToken}');
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
//     final textScale = MediaQuery.of(context).textScaleFactor;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: ListView(children: [
//           const SizedBox(height: 20),
//           Text(
//             "Phone Number",
//             style: TextStyle(
//                 fontFamily: 'FontMain',
//                 color: const Color(0xff2A6443),
//                 fontSize: 25 * textScale,
//                 fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 30),
//           const Text(""),
//           const SizedBox(height: 30),
//           Container(
//             width: 200,
//             child: CustomDropdown(
//                 items: countryList,
//                 value: selectedCountry,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedCountry = newValue;
//                     print(" Selected Country :$selectedCountry");
//                   });
//                 }),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             textAlign: TextAlign.center,
//             maxLength: 10,
//             controller: mobileNo,
//             style: const TextStyle(
//               fontFamily: 'FontMain',
//             ),
//             keyboardType: TextInputType.number,
//             inputFormatters: <TextInputFormatter>[
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//             ],
//             decoration: InputDecoration(
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.black, width: 2.0),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               border: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.black, width: 2.0),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               hintText: 'Enter Mobile Number',
//             ),
//           ),
//           const SizedBox(height: 40),
//           Buttons(
//               onPressed: () {
//                 generateOtp(mobileNo.text);
//                 //Get.to(() => DashboardPage());
//               },
//               title: 'Send Code',
//               height: 60,
//               width: screenWidthBtn,
//               textColors: Colors.white,
//               colors: const Color(0xff2A6443)),
//         ]),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/otp/mobile_verification.dart';
import 'package:highties_cannabis/secure_storage/common.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:country_code_picker/country_code_picker.dart'; // Import country_code_picker package

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final controller = Get.find<StateController>();
  TextEditingController mobileNo = TextEditingController();
  var userData;
  var userToken;

  bool loading = false;

  var generateOTPRes;
  var generateOTPData;
  var generateOTPDataInfo;

  Future<void> generateOtp(String mobile) async {
    try {
      if (mobile.trim() == '') {
        showToast('Please fill up the Mobile Number field!', false);
        return;
      }
      if (mobile.length <= 9) {
        showToast('Invalid Mobile Number', false);
        return;
      }
      if (loading) return;

      setState(() {
        loading = true;
      });

      var payloadIs = {
        'mobile_no': mobile.toString(),
      };
      print(' Payload is : $payloadIs');
      var apiURL = "/customers/${userData['id'].toString()}/send-otp";
      print(apiURL);
      generateOTPRes = await postReq(apiURL, userToken, payloadIs);

      if (generateOTPRes.statusCode == 200) {
        generateOTPData = jsonDecode(generateOTPRes.body.toString());
        print('generateOTPData');
        print(generateOTPData['message']);
        Get.off(
          () => VerificationMobile(phoneData: mobileNo.text.toString()),
          transition: Transition.rightToLeft,
        );
      } else {
        print('Error - Body');
        print(generateOTPRes.body.toString());

        var errorMessage =
            jsonDecode(generateOTPRes.body.toString())['message'];
        print(errorMessage);

        if (errorMessage == 'Customer not found!') {
          showToast('User not found. Please register first.', false);
        } else {
          showToast(errorMessage, false);
        }
      }
    } catch (e) {
      print("Error");
      print(e.toString());
      showToast('An error occurred', false);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  initialize() async {
    updateUser();
    print(controller);
    userData = controller.authUser.value;
    userToken = controller.authToken.value;
    print('userData is ${userData}');
    print('userToken is ${userToken}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(children: [
          const SizedBox(height: 20),
          Text(
            "Phone Number",
            style: TextStyle(
                fontFamily: 'FontMain',
                color: const Color(0xff2A6443),
                fontSize: 25 * textScale,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text(""),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              maxLength: 10,
              controller: mobileNo,
              style: const TextStyle(
                fontFamily: 'FontMain',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: 'Enter Mobile Number',
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountryCodePicker(
                        onChanged: (value) {
                          // Handle country code change
                        },
                        initialSelection: 'CA', // Set default to Canada
                        favorite: ['+1', 'CA'], // Set favorite to Canada
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      const SizedBox(width: 8),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 3,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Buttons(
              onPressed: () {
                generateOtp(mobileNo.text);
                //Get.to(() => DashboardPage());
              },
              title: 'Send Code',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.white,
              colors: const Color(0xff2A6443)),
        ]),
      ),
    );
  }
}
