import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(
      List<ConnectivityResult> connectivityResultList) {
    if (connectivityResultList.contains(ConnectivityResult.none)) {
      isConnected.value = false;
      //Get.to(NoInternetPage());

      _showNoInternetSnackbar();
    } else {
      isConnected.value = true;
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  void _showNoInternetSnackbar() {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          messageText: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "PLEASE CONNECT TO THE INTERNET",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold),
            ),
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.GROUNDED);
    }
  }
}
