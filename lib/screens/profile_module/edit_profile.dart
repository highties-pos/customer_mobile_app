import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/http/dio_http.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/registration_and_signup/phone_number.dart';
import 'package:highties_cannabis/secure_storage/common.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:highties_cannabis/widgets/editable_input.dart';
import 'package:highties_cannabis/widgets/input.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.find<StateController>();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController govtNum = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();

  String formatDateTime(String inputDateTime) {
    // Parse the input date time
    DateTime dateTime = DateTime.parse(inputDateTime);

    // Format the date and time in the desired format
    String formattedDateTime = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDateTime;
  }

//customer_name
// mobile_no
// email_id
// date_of_birth
// government_id_number
  var userData;
  var userToken;
  bool isChecked = false;
  bool loading = false;
  bool authInitialized = false;
  var formResponse;
  var fullName;

  Future updateProfileData(String custName, String phoneNum, String emailAd,
      String dob, String govNum) async {
    if (custName.trim() == '' ||
        phoneNum.trim() == '' ||
        emailAd.trim() == '' ||
        dob.trim() == '' ||
        govNum.trim() == '') {
      return showToast('Please fill up the fields!', false);
    }

    if (phoneNum.length <= 9) {
      showToast('Invalid Mobile Number', false);
      return;
    }

    setState(() {
      loading = true;
    });

    var payload = {
      'customer_name': custName,
      'mobile_no': phoneNum,
      'email_id': emailAd,
      'date_of_birth': dob,
      'government_id_number': govNum,
    };

    var formData = await createFormMapData(
      null,
      payload,
    );
    print('payload is');
    print(payload);

    try {
      formResponse = await patchDataFullResponse(
          '/customers/${userData['id'].toString()}', formData, userToken);

      if (formResponse.statusCode == 200) {
        showToast('Profile Updated Successfully');

        await updateUser();

        CommonMethod().showToast(context,
            title: 'Success',
            message: 'Profile updated successfully',
            type: 'success');
      } else {
        print('error');
        CommonMethod().showToast(context,
            title: 'Failed',
            message: 'Could not update profile',
            type: 'error');
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('here');
        print(e.response?.data);
        print(e.toString());
        if (!e.response?.data['message'].isEmpty) {
          return showToast(e.response?.data['message'], false);
        }
        showToast('Some error!', false);
      } else {
        print(e.message);
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  DateTime? pickedDate;

  void initialize() async {
    await updateUser();
    // Now userData should be properly initialized
    setState(() {
      userData = controller.authUser.value;
      userToken = controller.authToken.value;

      fName.text = userData['customer_name'] ?? '';
      dateinput.text = formatDateTime(userData['date_of_birth']) ?? '';
      mobile.text = userData['mobile_no'] ?? '';
      email.text = userData['email_id'] ?? '';
      govtNum.text = userData['government_id_number'] ?? '';
    });
    print(controller);
    print('userData is ${userData['customer_name'] ?? "Hello"}');
    print('userToken is ${userToken}');
  }

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    updateUser().then((_) {
      initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    double screenWidth = MediaQuery.of(context).size.width * 0.25;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xff2A6443),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(
              color: Color(0xff2A6443),
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    InputTextFieldWidget(
                        textEditingController: fName,
                        hintText: 'First Name',
                        view: false),
                    const SizedBox(height: 20),
                    InputTextFieldWidget(
                        textEditingController: lName,
                        hintText: 'Last Name',
                        view: false),
                    const SizedBox(height: 20),
                    TextFormField(
                      cursorColor: const Color(0xff2A6443),
                      controller: dateinput,
                      style: TextStyle(
                          fontFamily: 'FontMain', fontWeight: FontWeight.bold),
                      readOnly: true,
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2900));
                        if (pickedDate != null) {
                          setState(() {
                            dateinput.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate!);
                          });
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.calendar_month_rounded,
                            color: const Color(0xff2A6443),
                          ),
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: "BirthDate",
                          labelStyle: const TextStyle(
                              fontFamily: 'FontMain',
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(height: 20),
                    InputTextFieldWidget(
                        textEditingController: govtNum,
                        hintText: 'License Number',
                        view: false),
                    const SizedBox(height: 20),
                    InputTextFieldWidget(
                        textEditingController: mobile,
                        hintText: 'Mobile Number',
                        view: false),
                    const SizedBox(height: 20),
                    InputTextFieldWidget(
                        textEditingController: email,
                        hintText: 'Email',
                        view: false),
                    const SizedBox(height: 20),
                    Buttons(
                        onPressed: () {
                          updateProfileData(
                              fName.text,
                              mobile.text,
                              email.text,
                              CommonMethod().ddMmYyyyToISO(dateinput.text),
                              govtNum.text);
                        },
                        title: loading ? 'Please wait...' : 'Update',
                        height: 60,
                        width: screenWidthBtn,
                        textColors: Colors.white,
                        colors: const Color(0xff2A6443)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
