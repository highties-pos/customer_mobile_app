import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/screens/invoices/invoice_details.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:intl/intl.dart';

class ListInvoice extends StatefulWidget {
  const ListInvoice({super.key});

  @override
  State<ListInvoice> createState() => _ListInvoiceState();
}

class _ListInvoiceState extends State<ListInvoice> {
  String formatDateTime(String inputDateTime) {
    // Parse the input date time
    DateTime dateTime = DateTime.parse(inputDateTime);

    // Format the date and time in the desired format
    String formattedDateTime =
        DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);

    return formattedDateTime;
  }

  var invoiceListResponse;
  var invoiceListData;
  var invoiceListDataInfo;
  final state = Get.find<StateController>();

  Future getInvoiceList() async {
    try {
      var invoiceUrl = '/sales-orders?customer_id=${state.authUser['id']}';
      invoiceListResponse = await getReq(invoiceUrl);

      if (invoiceListResponse.statusCode == 200) {
        invoiceListData = jsonDecode(invoiceListResponse.body.toString());

        setState(() {
          invoiceListDataInfo = invoiceListData['result'];
        });
        print("invoiceListDataInfo:");
        print(invoiceListDataInfo[1]['name']);
      } else {
        print("error");
        print(invoiceListResponse.body.toString());
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInvoiceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoices',
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Color(0xff2A6443),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.arrowUpShortWide,
              color: Color(0xff2A6443),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: invoiceListDataInfo == null || invoiceListDataInfo == ''
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: invoiceListDataInfo == null
                          ? 0
                          : invoiceListDataInfo.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            // Get.to(() => InvoiceDetailsPage(
                            //
                            // ),
                            //     transition: Transition.leftToRight);
                          },
                          leading: const FaIcon(
                            FontAwesomeIcons.receipt,
                            color: Color(0xff2A6443),
                          ),
                          title: Text(
                            invoiceListDataInfo[index]['name'] ?? '',
                            style: const TextStyle(
                              fontFamily: 'FontMain',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff2A6443),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                invoiceListDataInfo[index]['customer_name'],
                                style: const TextStyle(
                                  fontFamily: 'FontMain',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                invoiceListDataInfo[index]['set_warehouse'],
                                style: const TextStyle(
                                  fontFamily: 'FontMain',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                invoiceListDataInfo[index]['taxes_and_charges'],
                                style: const TextStyle(
                                  fontFamily: 'FontMain',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: Text(
                              formatDateTime(
                                  invoiceListDataInfo[index]['creation']),
                              style: const TextStyle(
                                fontFamily: 'FontMain',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
