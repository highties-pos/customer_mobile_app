import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String formatDateTime(String inputDateTime) {
    // Parse the input date time
    DateTime dateTime = DateTime.parse(inputDateTime);

    // Format the date and time in the desired format
    String formattedDateTime =
        DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);

    return formattedDateTime;
  }

  List<Map<String, dynamic>> notify = [
    {
      "title": "Order Placed",
      "description":
          "Your order has been successfully placed. We will start processing it soon.",
      "time": "2024-02-14T10:30:00Z",
      "icon": FontAwesomeIcons.check,
    },
    {
      "title": "Order Processing",
      "description":
          "Your order is being processed. We are preparing your items for shipment.",
      "time": "2024-02-14T12:00:00Z",
      "icon": FontAwesomeIcons.spinner,
    },
    {
      "title": "Order Shipped",
      "description":
          "Your order has been shipped. It is on its way to your delivery address.",
      "time": "2024-02-14T14:30:00Z",
      "icon": FontAwesomeIcons.truck,
    },
    {
      "title": "Out for Delivery",
      "description":
          "Your order is out for delivery. Expect it to arrive soon.",
      "time": "2024-02-15T09:00:00Z",
      "icon": FontAwesomeIcons.truck,
    },
    {
      "title": "Delivery Delayed",
      "description":
          "We apologize, but there has been a delay in delivering your order. We're working to resolve it.",
      "time": "2024-02-15T11:45:00Z",
      "icon": FontAwesomeIcons.triangleExclamation,
    },
    {
      "title": "Delivery Successful",
      "description":
          "Your order has been successfully delivered to your doorstep. Thank you for choosing us!",
      "time": "2024-02-15T14:00:00Z",
      "icon": FontAwesomeIcons.circleCheck,
    },
    {
      "title": "Delivery Attempted",
      "description":
          "We attempted to deliver your order, but no one was available to receive it. We'll try again later.",
      "time": "2024-02-16T10:30:00Z",
      "icon": FontAwesomeIcons.circleInfo,
    },
    {
      "title": "Delivery Rescheduled",
      "description":
          "Your delivery has been rescheduled to a different date. We'll notify you of the new delivery time.",
      "time": "2024-02-17T08:00:00Z",
      "icon": FontAwesomeIcons.calendarWeek,
    },
    {
      "title": "Delivery Problem",
      "description":
          "There seems to be a problem with your delivery. Please contact customer support for assistance.",
      "time": "2024-02-17T12:15:00Z",
      "icon": FontAwesomeIcons.circleExclamation,
    },
    {
      "title": "Delivery Completed",
      "description":
          "The delivery process for your order has been completed. We hope you enjoy your purchase!",
      "time": "2024-02-18T09:30:00Z",
      "icon": FontAwesomeIcons.circleCheck,
    }
  ];

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
        title: const Text(
          'Notification',
          style: TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: notify.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: FaIcon(
                    notify[index]['icon'],
                    color: const Color(0xff2A6443),
                  ),
                  title: Text(
                    notify[index]['title'],
                    style: const TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    notify[index]['description'],
                    style: const TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 60,
                    child: Text(
                      formatDateTime(
                        notify[index]['time'],
                      ),
                      style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
