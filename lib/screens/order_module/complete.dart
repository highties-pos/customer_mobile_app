import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/order_module/track_order.dart';

class CompleteTab extends StatefulWidget {
  const CompleteTab({super.key});

  @override
  State<CompleteTab> createState() => _CompleteTabState();
}

class _CompleteTabState extends State<CompleteTab> {
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
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 0,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // Get.to(
                        //     () => TrackOrder(
                        //         billDetails:
                        //             orderController.invoiceList[index]),
                        //     transition: Transition.rightToLeft);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE8EFF3)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '10006579',
                                        style: TextStyle(
                                            color: Color(
                                              0xff2A6443,
                                            ),
                                            fontSize: 18,
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Card(
                                        color: Color(0xffD9D9D9),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: Text(
                                            'Completed',
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
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Store',
                                              style: TextStyle(
                                                color: Color(0xff7D8FAB),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'FontMain',
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'HighTies EmBurn',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: 'FontMain',
                                              ),
                                            ),
                                          ],
                                        ),
                                        VerticalDivider(
                                          thickness: 0.3,
                                          width: 70, // Adjust width as needed
                                          color: Colors.black,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Orders Total',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'FontMain',
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              '\$86.33',
                                              style: TextStyle(
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
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              'Emmanuel Priest',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: 'FontMain',
                                              ),
                                            ),
                                          ],
                                        ),
                                        VerticalDivider(
                                          thickness: 0.3,
                                          width: 75, // Adjust width as needed
                                          color: Colors.black,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Delivered on',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'FontMain',
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              '15 Jan, 1:22 PM',
                                              style: TextStyle(
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
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(150,
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
                                      onPressed: () {
                                        Navigator.pop(context); // Close modal
                                      },
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
                                        onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
