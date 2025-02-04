import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/constant/constnt.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/widgets/button.dart';

class WareHouseDetails extends StatefulWidget {
  final warehouseData;
  const WareHouseDetails({super.key, required this.warehouseData});

  @override
  State<WareHouseDetails> createState() => _WareHouseDetailsState();
}

///warehouses/71c163ff-8da6-4f0d-bbfe-527eed8a9388

class _WareHouseDetailsState extends State<WareHouseDetails> {
  var wareHouseDetailsRes;
  var wareHouseDetailsData;
  var wareHouseDetailsDataInfo;

  Future getWarehouseDetails() async {
    try {
      wareHouseDetailsRes =
          await getReq("/warehouses/${widget.warehouseData['id'].toString()}");

      if (wareHouseDetailsRes.statusCode == 200) {
        wareHouseDetailsData = jsonDecode(wareHouseDetailsRes.body.toString());

        setState(() {
          wareHouseDetailsDataInfo = wareHouseDetailsData['result'];
        });
        print("wareHouseDetailsDataInfo:");
        print(wareHouseDetailsDataInfo);
      } else {
        print(
            "Error fetching warehouses details. Status code: ${wareHouseDetailsRes.statusCode}");
        print(wareHouseDetailsRes.body.toString());
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("warehouseData : ${widget.warehouseData}");
    getWarehouseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff2A6443),
          ),
        ),
        title: Text(
          widget.warehouseData['warehouse_name'] ?? '',
          style: const TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            //fontSize: 25,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: wareHouseDetailsDataInfo == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Center(
                      child: wareHouseDetailsDataInfo['image'] == null ||
                              wareHouseDetailsDataInfo['image'].isEmpty
                          ? Image.network(
                              dummyImgUrl,
                              fit: BoxFit.cover,
                              height: 100,
                            )
                          : Image.network(
                              "$serverImgUrl${wareHouseDetailsDataInfo['image']}",
                              fit: BoxFit.cover,
                              height: 200,
                              width: 400,
                            ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${wareHouseDetailsDataInfo['address_line_1'] ?? ''}${wareHouseDetailsDataInfo['address_line_2'] ?? ''}",
                          style: const TextStyle(
                            fontFamily: 'FontMain',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "${wareHouseDetailsDataInfo['warehouse_name'] ?? ''}, Canada",
                          style: TextStyle(
                              fontFamily: 'FontMain',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidClock,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Friday, 9am - 10pm',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${wareHouseDetailsDataInfo['phone_no'] ?? ''}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.globe,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'highties.ca',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '4.5 / 5 Review',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                color: Colors.green.shade100,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    'Open Now',
                                    style: TextStyle(
                                      fontFamily: 'FontMain',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2A6443),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'In-store Shopping',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Kerbside Pickup',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Delivery',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Store Information',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FontMain',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.truck,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'DELIVERY',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                        ),
                      ),
                      subtitle: Text(
                        'Free Delivery',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.moneyBill1,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'PAYMENT',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                        ),
                      ),
                      subtitle: Text(
                        'Cash,Credit Card',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.grip,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'MENUS',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                        ),
                      ),
                      subtitle: Text(
                        'Recreational',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
