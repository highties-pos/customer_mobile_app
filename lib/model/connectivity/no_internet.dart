import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NoInternetPage extends StatefulWidget {
  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('No Internet'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Please connect to the internet',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _checkInternetConnection(context); // Trigger retry logic
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _checkInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // If internet connection is available, pop the current route
      Navigator.of(context).pop();
    } else {
      // If still no internet connection, show snackbar or handle as needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Still no internet connection'),
          duration: Duration(days: 2),
        ),
      );
    }
  }
}
