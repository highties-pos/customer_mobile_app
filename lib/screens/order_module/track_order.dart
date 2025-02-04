import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/widgets/qty_btn.dart';
import 'package:intl/intl.dart';

class TrackOrder extends StatefulWidget {
  final billDetails;
  const TrackOrder({required this.billDetails, super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  String formatDateTime(String inputDateTime) {
    // Parse the input date time
    DateTime dateTime = DateTime.parse(inputDateTime);

    // Format the date and time in the desired format
    String formattedDateTime =
        DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);

    return formattedDateTime;
  }

  int _currentStep = 1;
  List _steps = [];
  var invoiceDetailsResponse;
  var invoiceDetailsData;
  var invoiceDetailsDataInfo;
  var orderDetail;

  Future getInvoiceDetails() async {
    try {
      invoiceDetailsResponse = await getReq(
          "/sales-orders/${widget.billDetails['name'].toString()}/mobile");

      if (invoiceDetailsResponse.statusCode == 200) {
        invoiceDetailsData = jsonDecode(invoiceDetailsResponse.body.toString());

        _steps.clear();

        setState(() {
          invoiceDetailsDataInfo = invoiceDetailsData['data'];
          orderDetail = invoiceDetailsDataInfo['items'];
          _steps.addAll([
            {
              'title': 'Order Placed',
              'content': invoiceDetailsDataInfo['formatted_date'],
              'isActive': true,
            },
            {
              'title': 'Order Shipped',
              'content': invoiceDetailsDataInfo['formatted_date'],
              'isActive': true,
            },
            {
              'title': 'Order Delivered',
              'content': invoiceDetailsDataInfo['formatted_date'],
              'isActive': true,
            }
          ]);
        });

        print("hey orderDetail is : ${orderDetail}");
      } else {
        print(
            "Error fetching invoice details. Status code: ${invoiceDetailsResponse.statusCode}");
        print(invoiceDetailsResponse.body.toString());
      }
    } catch (e) {
      print("Error: $e");
    }
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getInvoiceDetails();

    print('billDetails');
    print(widget.billDetails['name']);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.35;
    double screenHeightBtn = MediaQuery.of(context).size.height * 0.100;
    final textScale = MediaQuery.of(context).textScaleFactor;
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth / _steps.length;
    containerWidth = containerWidth > 200
        ? 200
        : containerWidth; // Limit container width to 200
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Orders',
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
        body: invoiceDetailsDataInfo == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff2A6443),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID : ${invoiceDetailsDataInfo['name'] ?? ''}",
                          style: const TextStyle(
                              color: Color(
                                0xff2A6443,
                              ),
                              fontSize: 18,
                              fontFamily: 'FontMain',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${convertToDecimal(invoiceDetailsDataInfo['grand_total']) ?? ''}',
                          style: const TextStyle(
                              color: Color(
                                0xff2A6443,
                              ),
                              fontSize: 18,
                              fontFamily: 'FontMain',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Card(
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
                            fontSize: 12 * textScale,
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoiceDetailsDataInfo['set_warehouse'] ?? '',
                              style: TextStyle(
                                fontFamily: 'FontMain',
                                fontWeight: FontWeight.bold,
                                fontSize: 12 * textScale,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Delivery',
                              style: TextStyle(
                                fontFamily: 'FontMain',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.squarePhone,
                              color: Color(
                                0xff2A6443,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(
                            fontFamily: 'FontMain',
                            fontWeight: FontWeight.bold,
                            fontSize: 18 * textScale,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderDetail != null ? orderDetail.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      orderDetail[index]['image'],
                                      fit: BoxFit.contain,
                                      width: 80,
                                      height: 80,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              orderDetail[index]['name']
                                                          .substring(0, 20) +
                                                      "....." ??
                                                  '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'FontMain',
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                color: const Color(0xff002140),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                            // Text(
                                            //   convertToDecimal(
                                            //       orderDetail[index]
                                            //           ['total_net_weight']),
                                            //   style: TextStyle(
                                            //     fontFamily: 'FontMain',
                                            //     fontSize: 14 *
                                            //         MediaQuery.of(context)
                                            //             .textScaleFactor,
                                            //     color: Colors.grey,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Text(
                                          "Qty: x${double.parse(orderDetail[index]['qty']).toInt()}",
                                          style: TextStyle(
                                            fontFamily: 'FontMain',
                                            fontSize: 15 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          convertToDecimal(orderDetail[index]
                                                      ['amount'])
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'FontMain',
                                            fontSize: 18 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: const Color(0xff002140),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          ' Order Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'FontMain',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _steps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: 110,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    _currentStep >= index
                                        ? FontAwesomeIcons.solidCircleCheck
                                        : FontAwesomeIcons.hourglassHalf,
                                    color: _currentStep >= index
                                        ? Colors.green
                                        : Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _steps[index]['title'].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'FontMain',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      '(${_steps[index]['content'].toString()})',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'FontMain',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )));
  }
}
