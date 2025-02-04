import 'package:get/get.dart';
import 'package:highties_cannabis/model/connectivity/internet_connectivity.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
