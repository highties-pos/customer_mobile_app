import 'dart:developer';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:intl/intl.dart';
import '../../utils/repository/network_repository.dart';
import '../components/common_methos.dart';
import '../model/cart_model/cart_data_model.dart';
import '../model/order_model/sales_order_model.dart';

class OrderController extends GetxController {
  final state = Get.find<StateController>();

  RxList<OrderData> salesOrderList = <OrderData>[].obs;
  RxList<OrderData> savedSalesOrderList = <OrderData>[].obs;
  RxBool isOrderDetails = false.obs;
  RxBool isAddOrderDetails = false.obs;
  RxBool isLoadingData = false.obs;
  RxInt orderStatus = 0.obs;
  RxString orderStatusval = "".obs;

  List<Map<String, dynamic>> allData = [];
  RxString salesOrderId = "".obs;
  Rx<GetAllCartDataModel> salesOrderDetailData = GetAllCartDataModel().obs;
  RxBool isShowDetail = false.obs;

  RxList invoiceList = [].obs;
  RxBool loadingInvoices = false.obs;

  Future getInvoices(context,
      {searchStr = '', startDate = '', endDate = ''}) async {
    loadingInvoices.value = true;

    var url = '/sales-orders?customer_id=${state.authUser['id']}';
    var warehouseProductsResponse = await getReq(url);
    print('invoice url $url');

    if (warehouseProductsResponse.statusCode == 200) {
      invoiceList.value =
          jsonDecode(warehouseProductsResponse.body.toString())['result'];
    } else if (warehouseProductsResponse.statusCode == 404) {}
    loadingInvoices.value = false;
  }

  filterSalesOrderList(String searchStr, String startDate, String endDate) {
    salesOrderList.clear();

    getSalesOrder(
      null,
      searchStr: searchStr,
      startDate: startDate,
      endDate: endDate,
    );
    // Convert the startDate and endDate strings to DateTime objects

    // final searchResult = savedSalesOrderList.where((item) {
    //   bool textSearchCondition = item.name.toLowerCase().contains(searchStr) ||
    //       item.title.toLowerCase().contains(searchStr);
    //   bool startDateCondition = true;
    //   bool endDateCondition = true;
    //
    //   if (startDate != '') {
    //     DateTime parsedStartDate = DateTime.parse(startDate);
    //     startDateCondition = item.creation.isAfter(parsedStartDate);
    //   }
    //   if (endDate != '') {
    //     DateTime parsedEndDate = DateTime.parse(endDate);
    //     endDateCondition = item.creation.isBefore(parsedEndDate);
    //   }
    //
    //   return textSearchCondition && startDateCondition && endDateCondition;
    //   // item.mark_order_status.toLowerCase().contains(searchStr);
    // }).toList();

    // salesOrderList.addAll(searchResult);
  }

  Future getSalesOrder(context,
      {searchStr = '', startDate = '', endDate = ''}) async {
    isLoadingData.value = true;
    String status1 = "Order Placed";
    String status2 = "In progress";
    String status3 = "Ready for Pick Up";
    String status4 = "Confirmed";

    var orderStatusFilter = orderStatus.value == 1
        ? status1
        : orderStatus.value == 2
            ? status2
            : orderStatus.value == 3
                ? status3
                : orderStatus.value == 4
                    ? status4
                    : '';

    final response = await NetworkRepository().getSalesOrder(
      context,
      parameters:
          'mark_order_status=$orderStatusFilter&search=$searchStr&start_date=$startDate&end_date=$endDate',
      isFilter: orderStatus.value == 0 ? false : true,
    );
    if (response['statusCode'] == 200) {
      response["body"]['data'] = response["body"]['result'];
      SalesOrderModel dd = SalesOrderModel.fromJson(response["body"]);
      salesOrderList.clear();

      if (salesOrderList.isEmpty) {
        for (var i in dd.data) {
          salesOrderList.add(i);
        }
      }
      // save for future use in filters
      savedSalesOrderList.clear();
      savedSalesOrderList.addAll(salesOrderList);
      isLoadingData.value = false;
    } else if (response['statusCode'] == 404) {
      // showCustomerListDialog(context).whenComplete(() {
      //   // selectedCustomer.value = dataStorages.read("customer_name");
      // });
      isLoadingData.value = false;
    }
  }

  Future getSalesOrderDetails(context) async {
    isShowDetail.value = true;
    final response = await NetworkRepository().getSalesOrderDetails(
      context,
      data: {"sales_order_name": salesOrderId.value},
    );
    if (response['statusCode'] == 200) {
      isShowDetail.value = false;
      log("${response["body"]}");

      // cart is restored when we fetch data
      salesOrderDetailData.value =
          GetAllCartDataModel.fromJson(response["body"]);
      orderStatusval.value = response["body"]["data"]["mark_order_status"];

      // log("list length---${salesOrderList.length}");
    } else if (response['statusCode'] == 404) {
      isShowDetail.value = false;
      // showCustomerListDialog(context).whenComplete(() {
      //   // selectedCustomer.value = dataStorages.read("customer_name");
      // });
    }
  }

  Future updateOrderStatus(context) async {
    final response = await NetworkRepository().updateOrderStatus(
      context,
      salesOrderName: salesOrderId.value,
      data: {
        "mark_order_status": "$orderStatusval",
      },
    );
    if (response['statusCode'] == 200) {
      // isAddOrderDetails.value = false;
      isLoadingData.value = true;
      salesOrderList.clear();
      isAddOrderDetails.value = false;
      // todo: uncomment below if necessary to redirect to order list. it was commented to avoid redirecting after status change.
      // isOrderDetails.value = false;
      update();

      CommonMethod().showToast(
        context,
        title: "Success",
        message: "Order Status has been changed successfully.",
        type: 'success',
      );
      // log("list length---${salesOrderList.length}");
    } else if (response['statusCode'] == 404) {
      isShowDetail.value = false;
      // showCustomerListDialog(context).whenComplete(() {
      //   // selectedCustomer.value = dataStorages.read("customer_name");
      // });
    }
  }
}
