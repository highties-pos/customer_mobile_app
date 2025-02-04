import 'package:highties_cannabis/screens/success_pages/order_successfull.dart';
import 'package:highties_cannabis/state/order_controller.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/components/export.dart';
import 'package:highties_cannabis/model/customer/get_all_store_model.dart';
import 'package:highties_cannabis/screens/cart_module/payment_page.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/widgets/button.dart';

class CreateOrderBtn extends StatefulWidget {
  const CreateOrderBtn({super.key, this.PaymentMethods, this.fromCart});
  final PaymentMethods;
  final fromCart;

  @override
  State<CreateOrderBtn> createState() => _CreateOrderBtnState();
}

class _CreateOrderBtnState extends State<CreateOrderBtn> {
  var salesController = Get.find<SalesController>();
  var creatingInvoice = false;
  var cashAmountReceived = 0;
  var cardAmountReceived = 0;
  var confirmingTender = false;
  var orderController = Get.find<OrderController>();
  var state = Get.find<StateController>();

  Future createInvoice([orderNumber]) async {

    var authToken = state.authToken.value;
    print('the auth token is ' + authToken);
    final cartData = salesController.activeCartData.value.data;
    if (cartData == null) {
      return;
    }
    setState(() {
      creatingInvoice = true;
    });
    Map currentDateFormats = CommonMethod().currentDateFormats();
    String postingDate = currentDateFormats['iso_date'];
    String postingTime = currentDateFormats['time'];

    // todo: implement the due date later its giving error that 0th itme is not present
    // DateTime dueDate = cartData.paymentSchedule?[0]?.dueDate ?? DateTime.now();
    DateTime dueDate = DateTime.now();
    // Default to current time if dueDate is null
    String formattedDueDate = DateFormat('yyyy-MM-dd').format(dueDate);
    var savedWareHouse = getSavedWareHouse();
    var customerName = cartData?.customerName ?? 'guest';
    final payments = [];

    if (cashAmountReceived > 0) {
      payments.add({
        "mode_of_payment": widget.PaymentMethods.CASH,
        "account": "Cash - H",
        "doctype": "Sales Invoice Payment",
        "name": "new-sales-invoice-payment",
        "amount": cashAmountReceived,
        "base_amount": cashAmountReceived,
      });
    }

    if (cardAmountReceived > 0) {
      payments.add({
        "mode_of_payment": widget.PaymentMethods.CARD,
        "account": "Cash - H",
        "doctype": "Sales Invoice Payment",
        "name": "new-sales-invoice-payment",
        "amount": cardAmountReceived,
        "base_amount": cardAmountReceived,
      });
    }

    final cartInvoiceData = {
      "docstatus": 1,
      "orderNumber": widget.fromCart ? '' : orderNumber,
      "is_return": 0,
      "update_billed_amount_in_sales_order": 0,
      "company": cartData.company,
      "posting_date": postingDate,
      "set_posting_time": 1,
      "update_stock": 1,
      "selling_price_list": cartData.sellingPriceList,
      "apply_discount_on": cartData.applyDiscountOn,
      "additional_discount_percentage":
          cartData.additionalDiscountPercentage ?? 0,
      "discount_amount": cartData.discountAmount,
      "set_warehouse": savedWareHouse['name'],
      "pos_profile": getSelectedPOSProfileName(),
      "paid_amount": cartData?.grandTotal ?? 0,
      "base_total": cartData?.baseTotal ?? 0,
      "grand_total": cartData?.grandTotal ?? 0,
      "fromCustomerApp": 1,

      "items": cartData.items.map((item) {
        return {
          "warehouse": savedWareHouse['name'],
          "cost_center": "Main - H",
          "qty": item.qty,
          "name": item.name,
          // "update_stock": 1,
          "item_code": item.itemCode,
          "image": item.image,
          "amount": item.amount,
          "catalog_sku": item.catalogSku,
          "base_amount": item.baseAmount,
          "price_list_rate": item.priceListRate,
          "base_price_list_rate": item.basePriceListRate,
          "net_amount": item.amount,
          "batch_no": item.batchNo,
          "discount_amount": item.discountAmount,
          "discount_percentage": item.discountPercentage
        };
      }).toList(),
      "total_qty": cartData.totalQty,
      "payments": payments,
      // todo: send customer id later.
      "customer": state.authUser['id'] ?? '',
      "customer_name": state.authUser['customer_name'] ?? '',

      "due_date": formattedDueDate,
      "posting_time": postingTime,

      // tax data:

      "taxes_and_charges": "CANADA AND ONTORIO 5% AND 8% - H",
      // "tax_category": "",
      "base_total_taxes_and_charges": cartData?.baseTotalTaxesAndCharges ?? 0,
      "total_taxes_and_charges": cartData?.totalTaxesAndCharges ?? 0,
      "taxes": cartData.taxes?.map((item) {
        return {
          "account_head": item['accountHead'],
          "rate": item['rate'],
          "charge_type": item['chargeType'],
          "description": item['description']
        };
      }).toList(),
      "createSalesOrder": true,
      "createInvoice": false
    };

    final apiResponse = await NetworkRepository().createInvoice(
      context,
      state.authToken,
      cartInvoiceData,
    );
    setState(() {
      creatingInvoice = false;
    });
    return apiResponse;
  }

  Future handleTenderNow() async {
    if (confirmingTender) return;
    setState(() {
      confirmingTender = true;
    });

    // if (orderController.salesOrderDetailData.value.data == null) {
    //   return;
    // }
    var orderNumber = null;
    if (orderController.salesOrderDetailData.value.data != null) {
      orderNumber = orderController.salesOrderDetailData.value.data?.name ?? '';
    }
    // first use payment complete api.

    List<dynamic> skippedItemCodes = [];

    for (var skippedItem in salesController.skippedItems) {
      skippedItemCodes.add(skippedItem['code']);
    }
    // clear this to
    // clear this so that redirect is done to main page.
    orderController.isOrderDetails.value = false;

    if (!widget.fromCart) {
      if (orderNumber != null && orderNumber.isNotEmpty) {
        await NetworkRepository().updateOrderStatus(
          context,
          salesOrderName: orderController.salesOrderDetailData.value.data?.name,
          data: {
            "mark_order_status": "Confirmed",
            "skipped_item_codes": skippedItemCodes,
          },
        );
        // await NetworkRepository.confirmAndTender(
        //   context,
        //   orderId: orderNumber,
        //   skippedItemCodes: skippedItemCodes,
        // );
      } else {
        CommonMethod().showToast(
          context,
          title: "Error",
          message: 'Order Number not Found',
          type: 'error',
        );
      }
    }

    // create invoice must run after confirm tender becuase its dependent on billing status to be updated by confirm tender.
    try {
      var invStatus = await createInvoice(orderNumber);
      if (invStatus.statusCode == 200) {
        // clear cart code
        salesController.activeCartData.value.data = null;
        salesController.activeCartList.clear();
        salesController.activeCartList.refresh();
        salesController.activeCartData.refresh();

        print((invStatus.body.toString()));
        CommonMethod().showToast(
          context,
          title: "Success",
          message: "Invoice Generated Successfully!",
          type: 'success',
        );
        Get.offAll(
          () => OrderSuccessful(
              success: true,
              invoice: jsonDecode(invStatus.body.toString())['result']),
        );
      } else {
        Get.offAll(
          () => OrderSuccessful(
              success: false,
              invoice: jsonDecode(invStatus.body.toString())['result']),
        );
        CommonMethod().showToast(
          context,
          title: "Failed",
          message: jsonDecode(invStatus.body.toString())['message'],
          type: 'error',
        );
      }
      setState(() {
        creatingInvoice = false;
      });
      return true;
    } catch (err) {
      print(err);
      CommonMethod().showToast(
        context,
        title: "Error",
        message: "Could not generate invoice!",
        type: 'error',
      );
      setState(() {
        creatingInvoice = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Buttons(
      onPressed: () {
        handleTenderNow();
      },
      title: creatingInvoice ? 'Please wait...' : 'Place Order',
      height: 55,
      width: double.infinity,
      colors: const Color(0xff2A6443),
      textColors: Colors.white,
    );
  }
}
