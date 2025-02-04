import 'package:flutter/material.dart';
import 'package:highties_cannabis/screens/otp/successfull_page.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:intl/intl.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController dateinput = TextEditingController();

  DateTime? pickedDate;
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    double screenWidth = MediaQuery.of(context).size.width * 0.25;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                "Personal Information",
                style: TextStyle(
                    fontFamily: 'FontMain',
                    color: const Color(0xff2A6443),
                    fontSize: 25 * textScale,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(""),
              const SizedBox(height: 30),
              TextFormField(
                controller: dateinput,
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
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
                    });
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month_rounded),
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
              TextFormField(
                onTap: () {},
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.photo),
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Document",
                    labelStyle: const TextStyle(
                        fontFamily: 'FontMain',
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
              const SizedBox(height: 20),
              Buttons(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const YourAllSet()));
                },
                title: 'Confirm',
                height: 60,
                width: screenWidthBtn,
                textColors: Colors.white,
                colors: const Color(0xff2A6443),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
