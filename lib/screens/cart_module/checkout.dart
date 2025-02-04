import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/cart_module/create_order_btn.dart';
import 'package:highties_cannabis/screens/cart_module/payment_page.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/widgets/button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController promoCode = TextEditingController();
  bool isChecked = false;
  final salesController = Get.find<SalesController>();

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.35;
    double screenHeightBtn = MediaQuery.of(context).size.height * 0.100;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff2A6443),
            )),
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            // fontSize: 25,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xffE8EFF3))),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/emburnImg.png',
                  fit: BoxFit.fitWidth,
                ),
                title: Text(
                  'SHOPPING AT :',
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * textScale,
                    color: const Color(0xff7D8FAB),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High Ties(Emburn)',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * textScale,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Delivery | Today, 10:00 AM - 8:00 PM',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 12 * textScale,
                        color: const Color(0xff7D8FAB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sub-Total',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7D8FAB),
                        fontSize: 18,
                      )),
                  Text(
                    "\$ ${(salesController.activeCartData.value.data!.baseTotal ?? 0)}",
                    style: const TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff2A6443),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Discount',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7D8FAB),
                        fontSize: 18,
                      )),
                  Text(
                    "-\$ ${(salesController.activeCartData.value.data!.discountAmount ?? 0)}",
                    style: const TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff2A6443),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Taxes',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7D8FAB),
                        fontSize: 18,
                      )),
                  Text(
                    "+\$ ${(salesController.activeCartData.value.data!.totalTaxesAndCharges ?? 0)}",
                    style: const TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff2A6443),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7D8FAB),
                        fontSize: 18,
                      )),
                  Text(
                    '\$0.00',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff2A6443),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                'Promo Code',
                style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 310,
                  child: Card(
                    //width: 250,
                    child: TextField(
                      style: const TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      controller: promoCode,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: 'Enter promo code',
                        labelStyle: TextStyle(
                            fontFamily: 'FontMain',
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: !isChecked,
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(60, 60)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(
                                0xff2A6443)), // Set your desired background color here
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set your desired border radius here
                          ),
                        ),
                      ),
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontFamily: 'FontMain',
                          color: Colors.white,
                          //fontSize: 14 * textScale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isChecked = true;
                        });
                      },
                    )),
                Visibility(
                  visible: isChecked,
                  child: IconButton(
                    icon: const Icon(
                      Icons.check_circle_rounded,
                      size: 60,
                      color: const Color(0xff2A6443),
                    ),
                    onPressed: () {
                      setState(() {
                        isChecked = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'ORDER TOTAL',
                  style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "\$${(salesController.activeCartData.value.data!.grandTotal ?? 0)}",
                  style: const TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A6443),
                      fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Buttons(
                onPressed: () {
                  Get.to(
                    () => const PaymentPage(),
                    transition: Transition.rightToLeft,
                  );
                },
                title: 'Continue to Payment',
                height: 45,
                width: double.infinity,
                colors: const Color(0xff2A6443),
                textColors: Colors.white)
          ],
        ),
      ),
    );
  }
}
