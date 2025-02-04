import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/cart_module/create_order_btn.dart';
import 'package:highties_cannabis/screens/success_pages/order_successfull.dart';
import 'package:highties_cannabis/screens/success_pages/success_reset_password.dart';
import 'package:highties_cannabis/widgets/button.dart';


class PaymentMethods {
  static const String CASH = 'CASH';
  static const String CARD = 'CREDIT CARD';
  static const String VISA = 'VISA';
  static const String MASTERCARD = 'MASTERCARD';
  static const String AMAZONPAY = 'AMAZONPAY';
  static const String APPLEPAY = 'APPLEPAY';
  static const String GOOGLEPAY = 'GOOGLEPAY';
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController cardNo = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController cardHolder = TextEditingController();

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputDialog(
          cardNo: cardNo,
          cvv: cvv,
          expiry: expiry,
          cardHolder: cardHolder,
        );
      },
    );
  }

  int selectedPaymentOption = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xff2A6443),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xff2A6443),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Select the payment method you want to use.',
              style: TextStyle(
                fontFamily: 'FontMain',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.store,
                    color: Color(0xff2A6443),
                  ),
                  title: const Text(
                    'Pay at Store',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Radio(
                    activeColor: Color(0xff2A6443),
                    value: 1,
                    groupValue: selectedPaymentOption,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentOption = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.ccMastercard,
                    color: Color(0xff2A6443),
                  ),
                  title: const Text(
                    '**** **** **** 8973',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Radio(
                    activeColor: Color(0xff2A6443),
                    value: 1,
                    groupValue: selectedPaymentOption,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentOption = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                    onTap: () {
                      _showInputDialog();
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.creditCard,
                      color: Color(0xff2A6443),
                    ),
                    title: const Text(
                      'Add New Debit/Credit Card',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: Color(0xff2A6443),
                        ))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CreateOrderBtn(
              PaymentMethods: PaymentMethods,
              fromCart: true,
            ),
          ],
        ),
      ),
    );
  }
}

class InputDialog extends StatelessWidget {
  final TextEditingController cardNo;
  final TextEditingController expiry;
  final TextEditingController cvv;
  final TextEditingController cardHolder;

  InputDialog({
    required this.cardNo,
    required this.expiry,
    required this.cvv,
    required this.cardHolder,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Add new Card',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'FontMain'),
            ),
            Card(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
      content: Container(
        width: 600,
        height: 300,
        child: Column(
          children: [
            TextField(
              style: const TextStyle(
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              controller: cardNo,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Card Number',
                labelStyle: const TextStyle(
                    fontFamily: 'FontMain',
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  child: TextField(
                    style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    controller: expiry,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'MM / YYYY',
                      labelStyle: const TextStyle(
                          fontFamily: 'FontMain',
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 100,
                  child: TextField(
                    style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    controller: cvv,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'CVV',
                      labelStyle: const TextStyle(
                          fontFamily: 'FontMain',
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              style: const TextStyle(
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              controller: cardHolder,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Card Holder Name',
                labelStyle: const TextStyle(
                    fontFamily: 'FontMain',
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
            child: Buttons(
                onPressed: () {},
                title: 'Save',
                height: 50,
                width: double.infinity,
                colors: Color(0xff2A6443),
                textColors: Colors.white)),
      ],
    );
  }
}
