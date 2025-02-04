import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/widgets/qty_btn.dart';
import 'package:get/get.dart';

class CartItem extends StatefulWidget {
  CartItem({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final data;
  final index;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final salesController = Get.find<SalesController>();

  getListWithoutThisItem() {
    // used for deleting list
    return salesController.activeCartList
        .where((item) => item.itemCode != widget.data.itemCode)
        .toList();
  }

  decrementCartItem() async {
    // decrement cart item qty
    var data = widget.data;

    if (data.qty! <= 1) {
      if (salesController.activeCartList.length <= 1) {
        salesController.deleteCArt(
          context,
          data.name,
        );
      }
      // salesController.activeCartList.removeAt(index);

      var otherItems = getListWithoutThisItem();
      salesController.activeCartList.value = otherItems;
      salesController.activeCartData.value.data!.items = otherItems;
    } else {
      salesController.decrementCart(data);
      salesController.activeCartList.refresh();
      salesController.activeCartData.refresh();

      // if (salesController.isEditSalesOrder.value) {
      // await salesController.updateSalesOrder(context);
      // } else {
      await salesController.updateCart(
        null,
        itemCode: data.itemCode,
        quotationid: salesController.activeCartData.value.data!.name,
        fromcart: true,
        itemPrice: data.baseRate,
        fromDetails: false,
        itemname: data.itemName,
        description: data.description,
        uom: data.uom,
        confactor: data.conversionFactor,
      );
      // }
    }

    // if (salesController.isEditSalesOrder.value) {
    //   await salesController.updateSalesOrder(context);
    // } else {
    await salesController.updateCart(
      null,
      itemCode: data.itemCode,
      quotationid: data.name,
      fromcart: true,
      itemPrice: data.baseRate,
      fromDetails: false,
      itemname: data.itemName,
      description: data.description,
      uom: data.uom,
      confactor: data.conversionFactor,
    );
    // }

    if (salesController.activeCartList.isEmpty) {
      salesController.discountAmountcnt.value.text = "";
    }

    setState(() {});
    print(
        "====================12345678--${salesController.activeCartList.length}");
  }

  incrementCartItem() async {
    var data = widget.data;
    var wpu = (data.weightPerUnit ?? 0)!;
    if (salesController.activeCartData.value.data!.totalNetWeight + wpu > 30) {
      // show warning if more weight is being added beyond limit of 30g
      // todo: 'show dialog for overweight above 30 limit'
      // showoverWeightCartDialog(context);
    }
    salesController.activeCartData.refresh();
    if (salesController.activeCartData.value.data!.totalNetWeight + wpu <= 30) {
      await salesController.incrementCart(context, data);

      // if (salesController.isEditSalesOrder.value) {
      //   await salesController.updateSalesOrder(context);
      // } else {
      await salesController.updateCart(
        null,
        itemCode: data.itemCode,
        quotationid: data.name,
        fromcart: true,
        itemPrice: data.baseRate,
        fromDetails: false,
        itemname: data.itemName,
        description: data.description,
        uom: data.uom,
        confactor: data.conversionFactor,
      );
      // }
      salesController.activeCartList.refresh();
      salesController.activeCartData.refresh();
    }
  }

  handleDelete() async {
    var data = widget.data;
    if (salesController.activeCartList.length <= 1) {
      await salesController.deleteCArt(
        context,
        data.name,
      );
      salesController.activeCartList.refresh();
    } else {
      var otherItems = getListWithoutThisItem();
      salesController.activeCartList.value = otherItems;
      salesController.activeCartData.value.data!.items = otherItems;
      await salesController.updateCart(
        null,
        itemCode: data.itemCode,
        quotationid: data.name,
        fromcart: true,
        itemPrice: data.baseRate,
        fromDetails: false,
        itemname: data.itemName,
        description: data.description,
        uom: data.uom,
        confactor: data.conversionFactor,
      );
    }
    salesController.activeCartList.refresh();
    salesController.calctotalDiscountedAmount();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    var qty = int.tryParse((salesController.storedCartData.value.data?.items
                    .firstWhere((item) => item.itemCode == data.itemCode)
                    .qty ??
                0)
            .toStringAsFixed(0)) ??
        0;

    var imagePath = data.image != null && data.image != ""
        ? data.image
        : "https://i0.wp.com/post.healthline.com/wp-content/uploads/2022/11/marijuana-cannabis-weed-leaves-plant-on-pink-1296x728-header.jpg?w=1155&h=1528";

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.itemName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain',
                      fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                      color: const Color(0xff002140),
                    ),
                  ),
                  Text(
                    "${data.brand}",
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontSize: 13 * MediaQuery.of(context).textScaleFactor,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${((data.basePriceListRate! - (data.discountAmount ?? 0)) * qty).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain',
                          fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                          color: const Color(0xff002140),
                        ),
                      ),
                      Text(
                        '${(data.totalWeight * qty).toStringAsFixed(2)}g',
                        style: TextStyle(
                          fontFamily: 'FontMain',
                          fontSize: 13 * MediaQuery.of(context).textScaleFactor,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                QuantityBtn(
                  qty: qty,
                  onIncrement: incrementCartItem,
                  onDecrement: decrementCartItem,
                ),
                IconButton(
                  onPressed: () {
                    handleDelete();
                  },
                  iconSize: 18,
                  icon: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: const Color(0xff2A6443),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
