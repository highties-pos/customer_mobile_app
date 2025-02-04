// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:highties_cannabis/http/api_request.dart';
// import 'package:intl/intl.dart';

// class InvoiceDetailsPage extends StatefulWidget {
//   const InvoiceDetailsPage({super.key});

//   @override
//   State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
// }

// class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
//   String formatDateTime(String inputDateTime) {
//     // Parse the input date time
//     DateTime dateTime = DateTime.parse(inputDateTime);

//     // Format the date and time in the desired format
//     String formattedDateTime =
//         DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);

//     return formattedDateTime;
//   }

//   var invoiceDetailsResponse;
//   var invoiceDetailsData;
//   var invoiceDetailsDataInfo;

//   Future getInvoiceDetails() async {
//     try {
//       invoiceDetailsResponse = await getReq(
//           "/invoices/${widget.billDetails['name'].toString()}/mobile");

//       if (invoiceDetailsResponse.statusCode == 200) {
//         invoiceDetailsData = jsonDecode(invoiceDetailsResponse.body.toString());

//         setState(() {
//           invoiceDetailsDataInfo = invoiceDetailsData['data'];
//         });
//         print("invoiceDetailsDataInfo:");
//         print(invoiceDetailsDataInfo['items'][0]['name']);
//       } else {
//         print(
//             "Error fetching invoice details. Status code: ${invoiceDetailsResponse.statusCode}");
//         print(invoiceDetailsResponse.body.toString());
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getInvoiceDetails();

//     print('billDetails');
//     print(widget.billDetails['name']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double totalAmount = 0.0;
//     double deliveryCharges = 70.0;
//     double taxes = 5.0;

//     if (invoiceDetailsDataInfo != null) {
//       if (invoiceDetailsDataInfo['items'] != null) {
//         totalAmount = invoiceDetailsDataInfo['items']
//             .fold(0.0, (sum, item) => sum + item['net_amount']);
//       }

//       totalAmount += taxes;

//       totalAmount += deliveryCharges;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Invoice Details',
//           style: TextStyle(
//             fontFamily: 'FontMain',
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//             color: Color(0xff2A6443),
//           ),
//         ),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Color(0xff2A6443),
//           ),
//         ),
//       ),
//       body: invoiceDetailsDataInfo == null
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           invoiceDetailsDataInfo['name'],
//                           style: const TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                         Text(
//                           formatDateTime(invoiceDetailsDataInfo['creation']),
//                           style: const TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     if (invoiceDetailsDataInfo['items'] != null)
//                       Column(
//                         children:
//                             invoiceDetailsDataInfo['items'].map<Widget>((item) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   item['item_name'],
//                                   style: const TextStyle(
//                                     fontFamily: 'FontMain',
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   item['qty'].toString(),
//                                   style: const TextStyle(
//                                     fontFamily: 'FontMain',
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   item['net_amount'].toString(),
//                                   style: const TextStyle(
//                                     fontFamily: 'FontMain',
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     const SizedBox(height: 10),
//                     const Divider(),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Taxes',
//                           style: TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                         Text(
//                           taxes.toString(),
//                           style: const TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Delivery Charges',
//                           style: TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                         Text(
//                           deliveryCharges.toString(),
//                           style: const TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Total',
//                           style: TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                         Text(
//                           totalAmount.toString(),
//                           style: const TextStyle(
//                             fontFamily: 'FontMain',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff2A6443),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
