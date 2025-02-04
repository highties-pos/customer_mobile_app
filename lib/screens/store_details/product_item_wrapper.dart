import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highties_cannabis/app.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/model/customer/get_all_store_model.dart';
import 'package:highties_cannabis/screens/store_details/product_item.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:get/get.dart';

class ProductItemWrapper extends StatefulWidget {
  const ProductItemWrapper({super.key, this.product});
  final product;

  @override
  State<ProductItemWrapper> createState() => _ProductItemWrapperState();
}

class _ProductItemWrapperState extends State<ProductItemWrapper> {
  SalesController salesController = Get.find<SalesController>();

  handleAddToCart({onlyUpdateBatchNumber = false, required batchNo}) async {
    // log('inside handle add to cart get item detail by code:');
    // format data product

    final data = widget.product;
    // print('the product is ' + jsonEncode(data));

    // todo: batch no. later
    // store the batch number for cart.
    // if (batchNo == null || batchNo.isEmpty) {
    //   CommonMethod().showToast(
    //     context,
    //     title: "Please select a batch number!",
    //     message: "Not Selected!.",
    //     type: 'error',
    //   );
    //   return false;
    // }
    // saveBatchNumber(data['item_code'], batchNo);

    if (onlyUpdateBatchNumber) {
      salesController.getCartData(null, dataStorages.read("qID"));
      return true;
    }

    num weightPerUnit =
        salesController.itemDetailByCode.value.data?.weightPerUnit ?? 0.0;

    if (salesController.activeCartData.value.data == null) {
      salesController.createCart(
        context,
        data['item_code'],
        itemPrice: data['selling_price'],
        closeDialog: () {
          setState(() {});
        },
        fromDetails: false,
      );
      print("-----cart Created");
    } else if (salesController.activeCartData.value.data!.totalNetWeight +
            weightPerUnit >
        30) {
      // showoverWeightCartDialog(context);
      // todo: show overweight dialog
      CommonMethod().showToast(
        context,
        title: "Limit reached!",
        message: "For total weight of 30gms!.",
        type: 'error',
      );
    } else {
      if (salesController.activeCartData.value.data!.totalNetWeight +
              weightPerUnit <=
          30.0) {
        if (salesController.activeCartData.value.data == null) {
          salesController.createCart(
            context,
            data['item_code'],
            itemPrice: data['selling_price'],
            closeDialog: () {
              setState(() {});
            },
            fromDetails: false,
          );
        } else {
          var itemFound = salesController.activeCartData.value.data!.items
              .any((element) => element.itemCode == data['item_code']);

          if (itemFound) {
            final a = salesController.activeCartList
                .firstWhere((element) => element.itemCode == data['item_code']);
            print(
                "TF CHECK ==> in new condiation else---${a.baseAmount.toString()}");
            // salesController.activeCartData.value.data!.totalNetWeight += a.weightPerUnit!;
            // a.baseAmount += a.baseNetRate!;
            // a.qty = (a.qty ?? 0) + 1;
            // final dd = salesController.activeCartList.firstWhere((element) => element.itemCode == data.itemCode);
            // dd.qty = dd.qty! + 1;

            salesController.incrementCart(context, a);
            salesController.activeCartData.refresh();
            salesController.activeCartList.refresh();
            // if (salesController.isEditSalesOrder.value) {
            //   await salesController.updateSalesOrder(context,
            //       itemData: data, fromCart: true);
            // } else {
            await salesController.updateCart(
              null,
              itemCode: data['item_code'],
              quotationid: salesController.activeCartData.value.data!.name,
              fromcart: true,
              itemPrice: data['selling_price'],
              fromDetails: false,
              itemname: data['item_name'],
              description: data['description'],
              uom: data['stock_uom'],
              confactor: 1,
            );
            // }
          } else {
            // if item not found
            // if (salesController.isEditSalesOrder.value) {
            //   print('inside salesController.isEditSalesOrder.value');
            //   await salesController.updateSalesOrder(context,
            //       itemData: data, fromCart: true);
            // } else {
            print("inside salesController.updateCart()");
            await salesController.updateCart(
              context,
              itemCode: data['item_code'],
              quotationid: salesController.activeCartData.value.data!.name,
              fromcart: false,
              itemPrice: data['selling_price'],
              fromDetails: false,
              itemname: data['item_name'],
              description: data['description'],
              uom: data['stock_uom'],
              confactor: 1,
            );
            // }
            print(
                "TF CHECK ==> in new condiation else 22---${data['item_code']}");
          }
        }
        if (!salesController.isEditSalesOrder.value) {
          salesController.calctotalDiscountedAmount();
          salesController.calcdiscountBasePrice();
        }
      }
    }

    print('added to cart');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ProductItem(
      handleAddToCart: handleAddToCart,
      product: widget.product,
    );
  }
}
