import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/order_module/track_order.dart';
import 'package:highties_cannabis/state/order_controller.dart';

class ActiveTab extends StatefulWidget {
  const ActiveTab({super.key});

  @override
  State<ActiveTab> createState() => _ActiveTabState();
}

class _ActiveTabState extends State<ActiveTab> {
  var orderController = Get.find<OrderController>();

  double convertToDecimal(dynamic value) {
    if (value == null) {
      return 0.0; // Return 0 if value is null
    }
    // Parse the value to double
    double parsedValue = double.tryParse(value.toString()) ?? 0.0;
    // Round the parsed value to two decimal places
    double roundedValue = double.parse(parsedValue.toStringAsFixed(2));
    return roundedValue;
  }

  @override
  initState() {
    orderController.getInvoices(
      context,
      searchStr: '',
      startDate: '',
      endDate: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(() => orderController.invoiceList.value.length > 0
                ? SizedBox()
                : Container(child: Text('No orders found'))),
            Obx(
              () => ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderController.invoiceList.value.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.to(
                              () => TrackOrder(
                                  billDetails:
                                      orderController.invoiceList[index]),
                              transition: Transition.rightToLeft);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffE8EFF3)),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '#${orderController.invoiceList.value[index]['name']}',
                                          style: const TextStyle(
                                              color: Color(
                                                0xff2A6443,
                                              ),
                                              fontSize: 18,
                                              fontFamily: 'FontMain',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Card(
                                          color: Color(0xffD9D9D9),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: Text(
                                              'In Delivery',
                                              style: TextStyle(
                                                  color: Color(0xff0D986A),
                                                  fontFamily: 'FontMain',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Store',
                                                style: TextStyle(
                                                  color: Color(0xff7D8FAB),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              Text(
                                                orderController.invoiceList
                                                            .value[index]
                                                        ['set_warehouse'] ??
                                                    '',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const VerticalDivider(
                                            thickness: 0.3,
                                            width: 70, // Adjust width as needed
                                            color: Colors.black,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Orders Total',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              Text(
                                                '\$${convertToDecimal(orderController.invoiceList.value[index]['grand_total'])}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Delivery',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                              SizedBox(height: 7),
                                              Text(
                                                orderController.invoiceList
                                                    .value[index]['status'],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const VerticalDivider(
                                            thickness: 0.3,
                                            width: 75, // Adjust width as needed
                                            color: Colors.black,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Schedule by',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              Text(
                                                '${orderController.invoiceList.value[index]['createdAt']}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: 'FontMain',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize: MaterialStateProperty
                                              .all(const Size(150,
                                                  40)), // Adjust the size as needed
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color(0xffC8EDD9),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          'Reorder',
                                          style: TextStyle(
                                            color: Color(0xff2A6443),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Fontmain',
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.to(
                                                () => TrackOrder(
                                                    billDetails: orderController
                                                        .invoiceList[index]),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.angleRight,
                                            color: Color(
                                              0xff2A6443,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
