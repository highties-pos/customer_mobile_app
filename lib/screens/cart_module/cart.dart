import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/components/export.dart';
import 'package:highties_cannabis/model/customer/get_all_store_model.dart';
import 'package:highties_cannabis/screens/cart_model/export.dart';
import 'package:highties_cannabis/screens/cart_module/checkout.dart';
import 'package:highties_cannabis/screens/notification.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:highties_cannabis/widgets/cart_item.dart';
import 'package:highties_cannabis/widgets/qty_btn.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final salesController = Get.find<SalesController>();
  var savedWarehouse;
  int selectedOption = -1;

  initState() {
    setState(() {
      savedWarehouse = getSavedWareHouse();
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RadioDialog(selectedOption);
      },
    );
  }

  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputDialog(
          addressLine1: addressLine1,
          addressLine2: addressLine2,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.35;
    double screenHeightBtn = MediaQuery.of(context).size.height * 0.100;
    final textScale = MediaQuery.of(context).textScaleFactor;

    // Function to calculate the subtotal
    double calculateSubtotal() {
      double subtotal = 0;
      // for (var variety in weedVarieties) {
      //   subtotal += variety['price'];
      // }
      return subtotal;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Cart',
          style: TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            // fontSize: 25 * textScale,
            color: Color(0xff2A6443),
          ),
        ),
        actions: [
          Row(
            children: [
              Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffE8EFF3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${(salesController.activeCartData.value.data != null) ? salesController.activeCartData.value.data!.totalNetWeight : 0.00}g / 30g",
                        style: TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 18 * textScale,
                          color: const Color(0xff2A6443),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const NotificationPage(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE8EFF3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/images/Icon-bell.png',
                        ),
                      )),
                ),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ListTile(
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
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                'HighTies ${savedWarehouse != null && savedWarehouse['name'] != null ? '(' + savedWarehouse['name'] + ')' : ''}',
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold,
                  fontSize: 16 * textScale,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Products',
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 16 * textScale,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Use a ListView.builder to dynamically create widgets for each item
            Obx(() => salesController.activeCartList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/cart_bag.png',
                        fit: BoxFit.fitWidth,
                        height: 160,
                      ),
                      const Text(
                        "Your cart is empty",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FontMain',
                            color: Color(0xff002140)),
                      ),
                      const Text(
                        "You don’t have any items addedto your cart yet.\nYou need to add items to cart before\ncheckout.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'FontMain',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: salesController.activeCartList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = salesController.activeCartList[index];
                      return CartItem(
                        key: ValueKey(data),
                        data: data,
                        index: index,
                      );
                    })),
            const SizedBox(
              height: 15,
            ),

            Obx(() => salesController.activeCartList.isEmpty
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Choose Address',
                          style: TextStyle(
                            fontFamily: 'FontMain',
                            fontSize: 18 * textScale,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              onTap: _showDialog,
                              leading: const Icon(
                                Icons.directions_bus,
                                color: const Color(0xff2A6443),
                                size: 30,
                              ),
                              title: const Text(
                                'Choose Shipping Type',
                                style: TextStyle(
                                    fontFamily: 'FontMain',
                                    color: Colors.grey,
                                    fontSize: 16),
                              ),
                              subtitle: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery',
                                    style: TextStyle(
                                        fontFamily: 'FontMain',
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Reopen at 10 AM today',
                                    style: TextStyle(
                                        fontFamily: 'FontMain',
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Shipping Address',
                          style: TextStyle(
                            fontFamily: 'FontMain',
                            fontSize: 18 * textScale,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              onTap: _showInputDialog,
                              leading: const Icon(
                                Icons.home,
                                color: const Color(0xff2A6443),
                                size: 30,
                              ),
                              title: const Text(
                                'Home',
                                style: TextStyle(
                                    fontFamily: 'FontMain',
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              subtitle: const Text(
                                '6140 Sunbrook Park, PC 5679',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'FontMain',
                                    fontSize: 12),
                              ),
                              trailing: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.edit_square,
                                  color: const Color(0xff2A6443),
                                ),
                              )),
                        ),
                      )
                    ],
                  )),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Subtotal:',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontSize: 12 * textScale,
                      color: Colors.grey,
                    ),
                  ),
                  Obx(() => salesController.activeCartData.value.data == null
                      ? const Text('\$ 0')
                      : Text(
                          "\$ ${(salesController.activeCartData.value.data!.baseTotal ?? 0)}",
                          style: TextStyle(
                            fontFamily: 'FontMain',
                            fontSize: 18 * textScale,
                            color: const Color(0xff2A6443),
                          ),
                        )),
                ],
              ),
              Obx(
                () => salesController.activeCartList.isEmpty
                    ? Container(
                        height: screenHeightBtn,
                        width: screenWidthBtn,
                        decoration: BoxDecoration(
                          color: Colors.grey, // Disabled button color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            'CheckOut',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'FontMain',
                            ),
                          ),
                        ),
                      )
                    : Buttons(
                        onPressed: () {
                          Get.to(
                            () => const CheckoutPage(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        title: 'CheckOut',
                        height: screenHeightBtn,
                        width: screenWidthBtn,
                        textColors: Colors.white,
                        colors: const Color(0xff2A6443),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioDialog extends StatefulWidget {
  final int selectedOption;

  RadioDialog(this.selectedOption);

  @override
  _RadioDialogState createState() => _RadioDialogState();
}

class _RadioDialogState extends State<RadioDialog> {
  int selectedOption = -1;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Shipping type:',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'FontMain'),
      ),
      content: Container(
        height: 350,
        child: Column(
          children: [
            for (int i = 0; i < 5; i++)
              buildRadioButton(i,
                  'Delivery (In-Store) will reopen at 9:00 AM today ${i + 1}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedOption); // Close the dialog
          },
          child: const Text(
            'OK',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontFamily: 'FontMain'),
          ),
        ),
      ],
    );
  }

  Widget buildRadioButton(int index, String label) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontFamily: 'FontMain'),
      ),
      leading: Radio(
        value: index,
        groupValue: selectedOption,
        onChanged: (int? value) {
          setState(() {
            selectedOption = value ?? -1;
          });
        },
      ),
    );
  }
}

class InputDialog extends StatelessWidget {
  final TextEditingController addressLine1;
  final TextEditingController addressLine2;

  InputDialog({
    required this.addressLine1,
    required this.addressLine2,
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
              'Add Address',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'FontMain'),
            ),
            Card(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
      content: Container(
        width: 600,
        height: 200,
        child: Column(
          children: [
            TextField(
              style: const TextStyle(
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              controller: addressLine1,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Address 1',
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
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              controller: addressLine2,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Address 2',
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
                colors: const Color(0xff2A6443),
                textColors: Colors.white)),
      ],
    );
  }
}
