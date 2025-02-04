import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/main_screen/homePage.dart';
import 'package:highties_cannabis/screens/order_module/orders_details.dart';
import 'package:highties_cannabis/screens/sign_in.dart/sign_in.dart';
import 'package:highties_cannabis/widgets/button.dart';

class OrderSuccessful extends StatefulWidget {
  const OrderSuccessful({super.key, this.success, this.invoice});
  final success;
  final invoice;

  @override
  State<OrderSuccessful> createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    double screenWidth = MediaQuery.of(context).size.width * 0.25;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Order #${widget.invoice['name']} ${widget.success ? 'Successful' : 'Failed'}",
              style: TextStyle(
                  fontFamily: 'FontMain',
                  color: const Color(0xff2A6443),
                  fontSize: 25 * textScale,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text("View orders from your profile."),
            const SizedBox(height: 20),
            Buttons(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
                // Get.off(() => DashboardPage(),
                //     transition: Transition.leftToRight);
              },
              title: 'Home',
              height: 60,
              width: screenWidthBtn,
              textColors: Colors.white,
              colors: const Color(0xff2A6443),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    ));
  }
}
