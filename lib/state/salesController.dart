import 'dart:developer';

import 'package:get/get.dart';
import 'package:highties_cannabis/app.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/model/items_model/get-Item_by_code_model.dart';
import 'package:highties_cannabis/model/items_model/get_main_items_model.dart';

import 'package:highties_cannabis/components/export.dart';
import '../model/customer/get_all_store_model.dart';
import '../model/cart_model/cart_data_model.dart';
import '../model/items_model/get_filtertaperene_model.dart';
import '../model/items_model/get_filtertype_mdoel.dart';
import '../model/items_model/get_filterweight_model.dart';
import '../model/items_model/get_siblings_item_model.dart';
import '../model/items_model/getitemsgroup_model.dart';
import 'package:dio/src/form_data.dart' as fd;
import 'package:highties_cannabis/utils/repository/web_pos_network_repository.dart';

class SalesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList allowedWarehouseItems = [].obs;
  RxList allowedWarehouseCodes = [].obs;
  RxMap stockDataByItemCodeMap = {}.obs;
  RxList itemAvailability = [].obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: implement get cart later
    // getCartData(null, dataStorages.read("qID"));
  }

  Future getWarehouseProducts({categoryId = ''}) async {
    loadingWarehouseProductsDataInfo.value = true;
    if (categoryId == 'All Groups') {
      categoryId = '';
    }
    try {
      var savedWarehouse = getSavedWareHouse();
      var response = await NetworkRepository().getWarehouseProducts(
        warehouseId: savedWarehouse?['id'],
        categoryId: categoryId,
      );
      warehouseProductsDataInfo.value = response;
    } catch (e) {
      print("Error");
      print(e.toString());
    }
    loadingWarehouseProductsDataInfo.value = false;
  }

  getItemBatchNumbers(itemCode) async {
    try {
      var response = await NetworkRepository().getItemBatchNumbers(
        null,
        itemCode: itemCode,
      );
      return response['body']['results'];
    } catch (err) {
      print('the error is err');
    }
  }

  loadWareHouseItemCodes() async {
    // todo implement item codeslater
    return;
    try {
      var response = await NetworkRepository().getItemsList(
        null,
        url: CommonMethod.encodeQueryString(
          "http://3.97.254.80/api/method/highties.highties.custom.mobile.detail_product",
          {
            'warehouse': getSavedWareHouse()['name'],
          },
        ),
      );

      var records = response["body"]["data"]['records'];
      allowedWarehouseItems.value = records;

      List itemCodeCodes = [];
      for (var record in records) {
        itemCodeCodes.add(record['item_code']);
        stockDataByItemCodeMap[record['item_code']] =
            record['qty_after_transaction'];
      }
      allowedWarehouseCodes.value = itemCodeCodes;
    } catch (err) {
      print('the error is err');
    }
  }

  RxInt selectedItemIndex = 0.obs;
  RxInt selectedType = 0.obs;
  RxInt selectedOverallType = 0.obs;

  RxBool isProductDetails = false.obs;
  RxBool isEditForm = false.obs;
  RxBool showCart = true.obs;
  RxBool isShowsavedcart = false.obs;
  RxBool isLoading = false.obs;

  RxBool isGuestCustomer = true.obs;

  //
  RxInt selectedDiscount = 1.obs;
  RxInt selectpresent = 1.obs;

  //* SAVE ORDER
  RxInt saveOrderIndex = 0.obs;
  RxList saveOrderType = [
    "Pick up",
    "Delivery",
  ].obs;
  Rx<TextEditingController> saveOrderCnt = TextEditingController().obs;

  //* PRODUCT DETAILS
  RxInt currentdetailIndex = 0.obs;
  RxList<dynamic> skippedItems = [].obs;
  RxList detailList = [
    "Specifications",
    "Availability",
    "Notes",
    "Transfer",
  ].obs;

  ///
  RxDouble discountedPrice = 0.00.obs;
  RxDouble invoiceDiscount = 0.00.obs;
  RxDouble totalTaxPayableAmount = 0.00.obs;
  RxDouble totalAmount = 0.00.obs;
  RxDouble subTotal = 0.00.obs;
  RxDouble manualDiscountValue = 0.00.obs;
  // RxDouble manualproductDiscountValue = 0.00.obs;
  RxList<double> discountedPriceList = <double>[].obs;
  RxList<double> discountedsubtotalPriceList = <double>[].obs;
  RxList<double> dialogDiscount = <double>[].obs;
  RxDouble dialogTotalAmount = 0.00.obs;
  RxDouble dialogTotalDiscount = 0.00.obs;
  RxList<Map<String, dynamic>> packageList = <Map<String, dynamic>>[
    {
      "packageId": "122342355",
      "stock": "3 in-stock",
    },
    {
      "packageId": "122342355",
      "stock": "1 in-stock",
    },
    {
      "packageId": "122342355",
      "stock": "4 in-stock",
    },
  ].obs;
  // RxDouble discountedbasePrice = 0.0.obs;

  ///
  Rx<TextEditingController> qtycontroller =
      TextEditingController(text: "1").obs;

  ///
  Rx<TextEditingController> saveCartcnt = TextEditingController().obs;

  Rx<TextEditingController> manualAmountcnt = TextEditingController().obs;
  Rx<TextEditingController> discountAmountcnt = TextEditingController().obs;
  Rx<TextEditingController> totaldiscountAmountcnt =
      TextEditingController().obs;

  RxString? notes;
  RxString activeProductDetailItemCode = ''.obs;

  TextEditingController notescontroller = TextEditingController();
  Rx<MainItemsModel> mainItemsDataList = MainItemsModel().obs;
  RxList<MainItemData> paginationListData = <MainItemData>[].obs;

  int? pageItemCount = 20;
  RxInt pageCount = 0.obs;
  TextEditingController searchController = TextEditingController();
  RxInt selectedTabValue = 0.obs;
  RxString sortValue = "In-Stock".obs;

  // list of filters
  RxList weightList = [].obs;
  RxList typeList = [].obs;
  RxList tapereneList = [].obs;
  RxInt valueTCH = 0.obs;
  RxInt valueCHC = 0.obs;

  resetFilters() {
    weightList.value = [];
    typeList.value = [];
    tapereneList.value = [];
    valueTCH.value = 0;
    valueCHC.value = 0;
  }

  /// ! Filter
  ///
  // Future filterItembyMultiTeperene(context) async {
  //   var data = {
  //     'or_filters': [
  //       ...List.generate(tapereneList.length,
  //           (index) => '["terpenes", "LIKE", "%${tapereneList[index]}%"]')
  //     ].toString(),
  //   };
  //   log("Data-----${data}");
  //   try {
  //     final response = await NetworkRepository().filterItembyType(
  //       context,
  //       queryParameters: {"fields": '["*"]'},
  //       data:
  //         data,
  //     );
  //     if (response['statusCode'] == 200) {
  //       // itemsGroupData.value = GetAllItemsGroupModel.fromJson(response['body']);
  //       var data = MainItemsModel.fromJson(response["body"]);
  //       tabController.animateTo(0, curve: Curves.linear);
  //       paginationListData.addAll(data.data!);
  //       log("dddsss-----${paginationListData.first.name}");
  //       paginationListData.refresh();
  //       Get.back();
  //       // itemsGroupData.value.data!.insert(0, ItemGroupData(name: "All Items"));
  //       // itemsGroupData.refresh();
  //       // tabController = TabController(
  //       //     length: itemsGroupData.value.data?.length ?? 0, vsync: this);
  //       // itemsGroupData.refresh();
  //     } else if (response['statusCode'] == null) {
  //       // dataStorages.erase();
  //       // Get.offAll(() => const LogInScreen());
  //     }
  //   } on DioException catch (e) {
  //     CommonMethod().getXSnackBar("Error", e.error.toString(), redColor);
  //   }
  // }

  Future filterItembyWeight(context) async {
    var data = {
      'filters': [
        ...List.generate(weightList.length,
            (index) => '["weight_per_unit", "=", "${weightList[index]}"]')
      ].toString(),
    };
    log("Data-----${data}");
    try {
      final response = await NetworkRepository().filterItembyType(
        context,
        queryParameters: {"fields": '["*"]'},
        data: data,
      );
      log("\x1B[33m filter items by weight  ${response['statusCode']} \x1B[0m");
      if (response['statusCode'] == 200) {
        // itemsGroupData.value = GetAllItemsGroupModel.fromJson(response['body']);
        paginationListData.clear();
        var data = MainItemsModel.fromJson(response["body"]);
        tabController.animateTo(0, curve: Curves.linear);
        paginationListData.addAll(data.data!);
        // log("dddsss-----${paginationListData.first.name}");
        paginationListData.refresh();
        Get.back();

        log("\x1B[33m  filter items by weight ${paginationListData.toString()} \x1B[0m");
      } else if (response['statusCode'] == null) {
        // dataStorages.erase();
        // Get.offAll(() => const LogInScreen());
      }
    } on DioException catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.error.toString(),
        type: 'error',
      );
    }
  }

  // Future filterItembyMultiWeight(context) async {
  //   var data = {
  //     'filters': [
  //       ...List.generate(weightList.length,
  //           (index) => '["weight_per_unit", "=", "${weightList[index]}"]'),
  //     ].toString(),
  //   };
  //   log("Data-----${data}");
  //   try {
  //     final response = await NetworkRepository().filterItembyType(
  //       context,
  //       queryParameters: {"fields": '["*"]'},
  //       data:
  //         data,
  //     );
  //     if (response['statusCode'] == 200) {
  //       // itemsGroupData.value = GetAllItemsGroupModel.fromJson(response['body']);
  //       var data = MainItemsModel.fromJson(response["body"]);
  //       tabController.animateTo(0, curve: Curves.linear);
  //       paginationListData.addAll(data.data!);
  //       log("dddsss-----${paginationListData.first.name}");
  //       paginationListData.refresh();
  //       Get.back();

  //     } else if (response['statusCode'] == null) {
  //       log("Status------>${response['statusCode']}");
  //       // dataStorages.erase();
  //       // Get.offAll(() => const LogInScreen());
  //     }
  //   } on DioException catch (e) {
  //     CommonMethod().getXSnackBar("Error", e.error.toString(), redColor);
  //   }
  // }

  Future filterItembyWeightandTaperene(context) async {
    log("filterItembyWeightandTaperene----");
    var data = {
      'filters': [
        ...List.generate(typeList.length,
            (index) => '["item_group", "=", "${typeList[index]}"]'),
        ...List.generate(tapereneList.length,
            (index) => '["terpenes", "LIKE", "%${tapereneList[index]}%"]'),
        ...List.generate(weightList.length,
            (index) => '["weight_per_unit", "=", "${weightList[index]}"]')
      ].toString(),
      // '${List.generate(tapereneList.length, (index) => '["terpenes", "LIKE", "%${tapereneList[index]}%"]')}, ${List.generate(weightList.length, (index) => '["weight_per_unit", "=", "${weightList[index]}"]')}',
    };
    log("Data-----${data}");
    try {
      final response = await NetworkRepository().filterItembyType(
        context,
        queryParameters: {"fields": '["*"]'},
        data: data,
      );
      log("\x1B[33m filter items by weight and taperene ${response['statusCode']} \x1B[0m");
      // log("\x1B[31m GET ITEMS LIST [HOME SCREEN] Response ${response["body"]["message"]} \x1B[0m");
      if (response['statusCode'] == 200) {
        // itemsGroupData.value = GetAllItemsGroupModel.fromJson(response['body']);
        paginationListData.clear();
        var data = MainItemsModel.fromJson(response["body"]);
        tabController.animateTo(0, curve: Curves.linear);
        paginationListData.addAll(data.data!);

        paginationListData.refresh();
        Get.back();
        log("\x1B[33m filter items by weight and taperene  ${paginationListData.toString()} \x1B[0m");
      } else if (response['statusCode'] == null) {
        log("Status------>${response['statusCode']}");
        // dataStorages.erase();
        // Get.offAll(() => const LogInScreen());
      }
    } on DioException catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.error.toString(),
        type: 'error',
      );
    }
  }

  Rx<GetAllItemsGroupModel> itemsGroupData = GetAllItemsGroupModel().obs;
  RxBool itemsGroupsInitializing = false.obs;

  late final TabController tabController;

  Future createInvoice(context) async {
    //  not used anymore
    final response = await NetworkRepository().createInvoice(context, '', {
      "docstatus": 0,
      "createSalesOrder": true,
      "createInvoice": false,
      "name": "new-pos-invoice-2",
      "is_return": 0,
      "update_billed_amount_in_sales_order": 0,
      "company": "HighTies Cannabis Store",
      "posting_date": "2023-07-06",
      "set_posting_time": 0,
      "update_stock": 1,
      "status": "Draft",
      "items": abc,
      "total_qty": 1,
      "payments": [
        {
          "mode_of_payment": "Cash",
          "account": "Cash - H",
          "doctype": "Sales Invoice Payment",
          "name": "new-sales-invoice-payment-3"
        },
        {
          "mode_of_payment": "Gift Card",
          "account": "Cash - H",
          "doctype": "Sales Invoice Payment",
          "name": "new-sales-invoice-payment-4"
        }
      ],
      "customer": "??LucasMorin??016790",
      "due_date": "2023-07-06",
      "posting_time": "14:53:55"
    });
    if (response['statusCode'] == 200) {
    } else {}
    return response;
  }

  Rx<GetItemsGramsModel> siblingsItemData = GetItemsGramsModel().obs;
  RxList<ItemSiblingsData> itemSiblingsList = <ItemSiblingsData>[].obs;

  Future getItemsGrams(context, itemName, i) async {
    final response =
        await NetworkRepository().getItemsGrams(context, itemName: itemName);
    log("\x1B[33m GET ITEMS GRAMS [HOME SCREEN] statuscode 5555 s ${response['statusCode']} \x1B[0m");

    if (response['statusCode'] == 200) {
      siblingsItemData.value = GetItemsGramsModel.fromJson(response['body']);

      itemSiblingsList.add(siblingsItemData.value.data!);
      itemSiblingsList.refresh();

      // log("siblings item ===>>>>> ${itemSiblingsList.value[i].itemVariants.toString()}");
    }
  }

  RxList<String> productImages = <String>[].obs;

  Rx<ItemDetailData> itemDetailByCode = ItemDetailData().obs;

  Future getItemDetailByCode(context, itemCode) async {
    // pass null context if we want to hide the spinner
    final response =
        await NetworkRepository().getItemsByCode(null, itemCode: itemCode);
    var resData;
    if (response['statusCode'] == 200) {
      resData = ItemDetailData.fromJson(response['body']);
      itemDetailByCode.value = resData;
      itemAvailability.value = response['body']['stockData'];

      if (itemDetailByCode.value.data?.productImage != null) {
        productImages.value = [itemDetailByCode.value.data?.productImage];
      } else {
        productImages.value = [];
      }
    }
    return resData;
  }

  RxList warehouseProductsDataInfo = [].obs;
  RxList itemGroupDataInfo = [].obs;

  RxBool loadingWarehouseProductsDataInfo = false.obs;
  RxString selectedCustomer = "".obs;
  RxString selectedLoyalty = "".obs;

  String quotationID = "";

  Future getWarehouseItemGroup() async {
    try {
      var itemGroupResponse = await getReq('/item-groups');
      if (itemGroupResponse.statusCode == 200) {
        var itemGroupData = jsonDecode(itemGroupResponse.body.toString());
        itemGroupDataInfo.value = [
          {'id': '', 'name': 'All Groups'}
        ];
        itemGroupDataInfo.addAll(itemGroupData['result']);
      } else {
        print("error");
        print(itemGroupResponse.body.toString());
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  // formatItem of cart
  formatCartItem(Map itemToUpdate) {
    // utility function to find item details.
    // find a particular item in existing cart and return the formatted data for adding/updating it

    var activeCart = activeCartData.value;
    var items = activeCart.data?.items ?? [];

    // find the item from sale list and define default values
    var paginationItem = warehouseProductsDataInfo.firstWhereOrNull(
        (element) => element['item_code'] == itemToUpdate['item_code']);

    print('warehouseProductsDataInfo ${jsonEncode(warehouseProductsDataInfo)}');
    print('found pagination item ${jsonEncode(paginationItem)}');
    var price = paginationItem?['selling_price'] ?? 0.0;
    var netWeight = paginationItem?['net_weight'] ?? 0.0;

    dynamic itemFoundMap = {
      "description": paginationItem?['description'],
      "uom": paginationItem?['stock_uom'],
      'name': paginationItem?['name'],
      'brand': paginationItem?["brand"],
      'item_name': paginationItem?['item_name'],
      'item_code': paginationItem?['item_code'],
      'item_group': paginationItem?['item_group'],
      'selling_price': price,
      "price_list_rate": price,
      "stock_qty": paginationItem?['actual_qty'],
      'image': paginationItem?['image'],
      'qty': 1.0,
      "rate": price,
      "amount": price,
      "base_amount": price,
      "discount": null,
      'discount_amount': 0.0,
      'base_price_list_rate': price,
      'conversion_factor': 1,
      'weight_per_unit': netWeight,
      'total_weight': paginationItem?['equivalent_to'] ?? 0,
      'batch_no': paginationItem?['default_batch_no'],
      // 'batch_no': getSavedBatchNumber(paginationItem?['item_code']) ?? null,
    };

    // check if in cart then use it to overwrite as base
    dynamic foundItem = items.firstWhereOrNull(
        (dynamic listItem) => listItem.itemCode == itemToUpdate['item_code']);

    if (foundItem != null) {
      var itemFoundMapJson2 = foundItem!.toJson();
      for (var key in itemFoundMapJson2.keys) {
        itemFoundMap[key] = itemFoundMapJson2[key];
      }
    }

    for (var key in itemToUpdate.keys) {
      itemFoundMap[key] = itemToUpdate[key];
    }
    log('ITEM AFTER FORMATTING:: ');
    log(jsonEncode(itemFoundMap));

    // if found return with previous values.
    return itemFoundMap;
  }

  Future createCart(context, itemCode,
      {void Function()? closeDialog, itemPrice, stockQty, fromDetails}) async {
    var formattedItem = formatCartItem({
      "item_code": itemCode,
      "qty": CommonMethod()
          .convertToDouble(fromDetails ? qtycontroller.value.text : 1),
      "rate": CommonMethod().convertToDouble(itemPrice),
      "base_amount": CommonMethod().convertToDouble(itemPrice),
      "discount": null,
    });

    // Taxes for locations:
    //
    // 13% Total in Ontario on every product sold. Highties is only in Ontario right now. But later we need this to be based on the state. Each state has different %
    // Alberta: 5% GST
    // British Columbia:  12% GST/PST
    // Manitoba (recreational cannabis):  5% GST
    // New Brunswick:  15% HST
    // Newfoundland & Labrador: 15% HST
    // Northwest Territories:  5% GST
    // Nova Scotia: 15% HST
    // Nunavut:  5% GST
    // Ontario:  13% HST
    // Prince Edward Island: 15% HST
    // Quebec: 14.975 GST/QST
    // Saskatchewan:  11% GST/PST
    // Yukon:  5% GST

    var custName = dataStorages.read("customer_name") ?? '';
    var createCartData = {
      "customer": dataStorages.read("customer"),
      "customer_name": custName,
      // todo: update the requried fields base amount & total net weight later on frontend based on items added.
      "total_net_weight": formattedItem['weight_per_unit'],
      'base_amount': 0.0,
      'base_total': 0.0,
      'total_taxes_and_charges': 0.0,
      'discount_amount': 0.0,
      "items": [formattedItem].toList(),
      "taxes": [
        {
          "account_head": "CANADA HST  5% - H",
          "rate": 5.0,
          "charge_type": "On Net Total",
          "description": "CANADA HST  5%"
        },
        {
          "account_head": "ONTRIO TAX RATE 8% - H",
          "rate": 8.0,
          "charge_type": "On Net Total",
          "description": "ONTRIO TAX RATE 8%"
        }
      ],
    };

    await NetworkRepository().createCart(context, createCartData);

    invoiceDiscount.value = 0.00;
    totaldiscountAmountcnt.value.clear();
    selectedCustomer.value =
        custName != null && custName != 'guest' ? custName : '';
    quotationID = '';
    await dataStorages.write("qID", '');
    await dataStorages.write("discount", 0.0);

    await getCartData(context, quotationID);
    CommonMethod().showToast(
      context,
      title: "Cart",
      type: 'success',
      message: "Cart has been created successfully.",
    );
    qtycontroller.value.text = "1";
  }

  getSalesOrderDataFromCart() {
    final cartData = activeCartData.value.data;
    var savedWareHouse = getSavedWareHouse();
    var customerName = cartData?.customerName ?? 'guest';

    final cartSalesOrderData = {
      "docstatus": 1,
      "title": saveOrderCnt.value.text,
      "customer": cartData?.customer ?? '',
      "customer_name": customerName,
      "update_billed_amount_in_sales_order": 0,
      "company": cartData?.company ?? "HighTies Cannabis Store",
      "selling_price_list": cartData?.sellingPriceList,
      "apply_discount_on": cartData?.applyDiscountOn,
      "additional_discount_percentage":
          cartData?.additionalDiscountPercentage ?? 0,
      "discount_amount": cartData?.discountAmount ?? 0,
      "set_warehouse": savedWareHouse['name'],
      "base_total": cartData?.baseTotal ?? 0,
      "grand_total": cartData?.grandTotal ?? 0,
      "items": cartData?.items.map((item) {
        var qty = item?.qty ?? 1;
        // var itemScanned = skippedItems.value
        //             .firstWhere((item) => item["code"] == item.itemCode) ==
        //         null
        //     ? 1
        //     : 0;
        return {
          "item_scanned": 1,
          "warehouse": savedWareHouse['name'],
          "qty": qty,
          "name": item.name,
          "item_code": item.itemCode,
          "total_weight": item.totalWeight,
          "price_list_rate": item.priceListRate,
          "image": item.image,
          "amount": item.priceListRate! * qty,
          "net_amount": item.amount,
          "batch_no": item.batchNo,
          "discount_amount": item.discountAmount ?? 0,
          "discount_percentage": item.discountPercentage ?? 0
        };
      }).toList(),
      "total_qty": cartData?.totalQty,
      // tax data:
      "taxes_and_charges": "CANADA AND ONTORIO 5% AND 8% - H",
      // "tax_category": "",
      "base_total_taxes_and_charges": cartData?.baseTotalTaxesAndCharges ?? 0,
      "total_taxes_and_charges": cartData?.totalTaxesAndCharges ?? 0,
      "taxes": cartData?.taxes?.map((item) {
        return {
          "account_head": item['accountHead'],
          "rate": item['rate'],
          "charge_type": item['chargeType'],
          "description": item['description']
        };
      }).toList(),
    };
    return cartSalesOrderData;
  }

  Future createSalesOrder(context) async {
    final response = await NetworkRepository().createSalesOrder(
      context,
      data: getSalesOrderDataFromCart(),
    );

    if (response['statusCode'] == 200 || response['statusCode'] == 201) {
      await deleteCArt(context, dataStorages.read("qID"))
          .then((value) => log("Sales order cart deleted successfully"));
      CommonMethod().showToast(
        context,
        title: "Sales Order",
        message: "Sales Order has been created successfully.",
        type: 'success',
      );
      Navigator.of(context).pop();
      qtycontroller.value.text = "1";
    } else if (response['statusCode'] == 404) {}
  }

  Future updateSalesOrder(context,
      {MainItemData? itemData,
      bool fromCart = false,
      bool isAdding = false,
      bool isremoving = false}) async {
    var salesOrderData = getSalesOrderDataFromCart();
    final response = await NetworkRepository().updateSalesOrder(
      context,
      salesOrderName: dataStorages.read("salesOrderId"),
      data: salesOrderData,
    );
    if (response['statusCode'] == 200) {
      // activeCartData.value = GetAllCartDataModel.fromJson(response["body"]);
      // activeCartList.clear();
    } else if (response['statusCode'] == 404) {}
  }

  RxString searchText = "".obs;

  Future getCustomerbySearch(context) async {
    final response = await NetworkRepository()
        .getCustomerbySearch(context, queryParameters: {
      "txt": searchText.value,
      "doctype": "Customer",
      "ignore_user_permissions": 0,
      "reference_doctype": "Quotation",
      // "order_type": "Pick Up",
    });
    if (response['statusCode'] == 200 || response['statusCode'] == 201) {
    } else if (response['statusCode'] == 404) {
      // showCustomerListDialog(context).whenComplete(() {
      //   selectedCustomer.value = dataStorages.read("customer_name");
      //   log("inside the sell");
      // });
    }
  }

  RxBool isSelectedCustomer = false.obs;

  Future updateQuotation(context) async {
    List data = [];
    log("c----${activeCartData.value.data!.name.toString()}");
    for (var element in activeCartList) {
      log("discount---${element.basePriceListRate}---${element.qty!}-----${element.discountAmount!}---${element.discountAmount! * 100 / element.basePriceListRate! * element.qty!}");
      data.add(
        (element.discountType == "amount")
            ? {
                "name": element.name,
                "item_name": element.itemName,
                // "description": element.description,
                "uom": element.uom,
                "conversion_factor": element.conversionFactor,
                "item_code": element.itemCode,
                "qty": CommonMethod().convertToDouble(element.qty),
                "margin_type": "Amount",
                "discount_amount": element.discountAmount,
                "discount_percentage": (element.discountAmount! * 100) /
                    (element.basePriceListRate! * element.qty!)
              }
            : {
                "name": element.name,
                "item_name": element.itemName,
                // "description": element.description,
                "uom": element.uom,
                "conversion_factor": element.conversionFactor,
                "item_code": element.itemCode,
                "qty": CommonMethod().convertToDouble(element.qty),
                "discount_percentage": element.discountPercentage,
              },
      );
    }

    var customerData = (!isSelectedCustomer.value)
        ? {
            "title": saveOrderCnt.value.text,
            "customer_name": "Guest",
            "party_name": "Guest",
            if (storedCartData.value.data!.additionalDiscountPercentage !=
                    0.0 ||
                storedCartData.value.data!.discountAmount != 0.0)
              "apply_discount_on": "Net Total",
            if (storedCartData.value.data!.additionalDiscountPercentage !=
                    0.0 ||
                storedCartData.value.data!.discountAmount != 0.0 &&
                    storedCartData.value.data!.items.first.totaldiscountType ==
                        "percentage")
              "additional_discount_percentage":
                  storedCartData.value.data!.additionalDiscountPercentage,

            if (storedCartData.value.data!.additionalDiscountPercentage !=
                    0.0 ||
                storedCartData.value.data!.discountAmount != 0.0 &&
                    storedCartData.value.data!.items.first.totaldiscountType ==
                        "amount")
              "discount_amount": storedCartData.value.data!.discountAmount,
            "docstatus": 1,
            "items": data,
            "taxes": [
              {
                "account_head": "CANADA HST  5% - H",
                "rate": 5.0,
                "charge_type": "On Net Total",
                "description": "CANADA HST  5%"
              },
              {
                "account_head": "ONTRIO TAX RATE 8% - H",
                "rate": 8.0,
                "charge_type": "On Net Total",
                "description": "ONTRIO TAX RATE 8%"
              }
            ],
            // "payment_schedule": storedCartData.value.data!.paymentSchedule,
            "payment_schedule": [
              {
                "name": storedCartData.value.data!.paymentSchedule!.first.name,
                "owner":
                    storedCartData.value.data!.paymentSchedule!.first.owner,
                "creation": storedCartData
                    .value.data!.paymentSchedule!.first.creation
                    .toString(),
                "modified": storedCartData
                    .value.data!.paymentSchedule!.first.modified
                    .toString(),
                "modified_by": storedCartData
                    .value.data!.paymentSchedule!.first.modified
                    .toString(),
                "parent":
                    storedCartData.value.data!.paymentSchedule!.first.parent,
                "parentfield": storedCartData
                    .value.data!.paymentSchedule!.first.parentfield,
                "parenttype": storedCartData
                    .value.data!.paymentSchedule!.first.parenttype,
                "idx": storedCartData.value.data!.paymentSchedule!.first.idx,
                "docstatus":
                    storedCartData.value.data!.paymentSchedule!.first.docstatus,
                "due_date": storedCartData
                    .value.data!.paymentSchedule!.first.dueDate
                    .toString(),
                "invoice_portion": storedCartData
                    .value.data!.paymentSchedule!.first.invoicePortion,
                "discount_type": storedCartData
                    .value.data!.paymentSchedule!.first.discountType,
                "discount_date": storedCartData
                    .value.data!.paymentSchedule!.first.discountDate,
                "discount":
                    storedCartData.value.data!.paymentSchedule!.first.discount,
                "payment_amount": storedCartData
                    .value.data!.paymentSchedule!.first.paymentAmount,
                "outstanding": storedCartData
                    .value.data!.paymentSchedule!.first.outstanding,
                "paid_amount": storedCartData
                    .value.data!.paymentSchedule!.first.paidAmount,
                "discounted_amount": storedCartData
                    .value.data!.paymentSchedule!.first.discountedAmount,
                "base_payment_amount": storedCartData
                    .value.data!.paymentSchedule!.first.basePaymentAmount,
                "doctype":
                    storedCartData.value.data!.paymentSchedule!.first.doctype
              }
            ]
          }
        : {
            "customer_name": saveOrderCnt.value.text,
            "party_name": saveOrderCnt.value.text,
            "title": saveOrderCnt.value.text,
            if (storedCartData.value.data!.additionalDiscountPercentage !=
                    0.0 ||
                storedCartData.value.data!.discountAmount != 0.0)
              "apply_discount_on": "Net Total",
            if (storedCartData.value.data!.additionalDiscountPercentage !=
                    0.0 ||
                storedCartData.value.data!.discountAmount != 0.0 &&
                    storedCartData.value.data!.items.first.totaldiscountType ==
                        "percentage")
              "additional_discount_percentage":
                  storedCartData.value.data!.additionalDiscountPercentage,

            if (storedCartData.value.data!.additionalDiscountPercentage !=
                    0.0 ||
                storedCartData.value.data!.discountAmount != 0.0 &&
                    storedCartData.value.data!.items.first.totaldiscountType ==
                        "amount")
              "discount_amount": storedCartData.value.data!.discountAmount,
            "docstatus": 1,
            "items": data,
            "taxes": [
              {
                "account_head": "CANADA HST  5% - H",
                "rate": 5.0,
                "charge_type": "On Net Total",
                "description": "CANADA HST  5%"
              },
              {
                "account_head": "ONTRIO TAX RATE 8% - H",
                "rate": 8.0,
                "charge_type": "On Net Total",
                "description": "ONTRIO TAX RATE 8%"
              }
            ],
            // "payment_schedule": storedCartData.value.data!.paymentSchedule,
            "payment_schedule": [
              {
                "name": storedCartData.value.data!.paymentSchedule!.first.name,
                "owner":
                    storedCartData.value.data!.paymentSchedule!.first.owner,
                "creation": storedCartData
                    .value.data!.paymentSchedule!.first.creation
                    .toString(),
                "modified": storedCartData
                    .value.data!.paymentSchedule!.first.modified
                    .toString(),
                "modified_by": storedCartData
                    .value.data!.paymentSchedule!.first.modified
                    .toString(),
                "parent":
                    storedCartData.value.data!.paymentSchedule!.first.parent,
                "parentfield": storedCartData
                    .value.data!.paymentSchedule!.first.parentfield,
                "parenttype": storedCartData
                    .value.data!.paymentSchedule!.first.parenttype,
                "idx": storedCartData.value.data!.paymentSchedule!.first.idx,
                "docstatus":
                    storedCartData.value.data!.paymentSchedule!.first.docstatus,
                "due_date": storedCartData
                    .value.data!.paymentSchedule!.first.dueDate
                    .toString(),
                "invoice_portion": storedCartData
                    .value.data!.paymentSchedule!.first.invoicePortion,
                "discount_type": storedCartData
                    .value.data!.paymentSchedule!.first.discountType,
                "discount_date": storedCartData
                    .value.data!.paymentSchedule!.first.discountDate,
                "discount":
                    storedCartData.value.data!.paymentSchedule!.first.discount,
                "payment_amount": storedCartData
                    .value.data!.paymentSchedule!.first.paymentAmount,
                "outstanding": storedCartData
                    .value.data!.paymentSchedule!.first.outstanding,
                "paid_amount": storedCartData
                    .value.data!.paymentSchedule!.first.paidAmount,
                "discounted_amount": storedCartData
                    .value.data!.paymentSchedule!.first.discountedAmount,
                "base_payment_amount": storedCartData
                    .value.data!.paymentSchedule!.first.basePaymentAmount,
                "doctype":
                    storedCartData.value.data!.paymentSchedule!.first.doctype
              }
            ]
          };

    // log("--->hee${storedCartData.value.data!.items.first.discountData!.invoiceDiscount!}---x100----/---${storedCartData.value.data!.items.first.amount!}");

    var requestData = customerData;

    log("Request Data---$requestData");

    final response = await NetworkRepository().updateQuotation(
      context,
      qid: activeCartData.value.data!.name,
      data: requestData,
    );
    log("DATA---${response["body"]}");
    if (response != null && response['statusCode'] == 200) {
      // log("${response["body"]}");

      // qtycontroller.value.text = "1";
      log("\x1B[33m GET ITEMS LIST [ITEM DETAILS SCREEN] LEN ${mainItemsDataList.value.data!.length} \x1B[0m");
    } else if (response != null && response['statusCode'] == 404) {
      // showCustomerListDialog(context).whenComplete(() {
      //   selectedCustomer.value = dataStorages.read("customer_name");
      // });
    } else {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: "Unknown error occured",
        type: 'error',
      );
    }
  }

  RxList<double> discountAmount = <double>[].obs;
  Future updateCartDiscount(context) async {
    List data = [];
    // log("c----${activeCartData.value.data!.name.toString()}");
    for (var element in activeCartList) {
      log("discount---${element.basePriceListRate}---${element.qty!}-----${element.discountAmount!}---${element.discountAmount! * 100 / element.basePriceListRate! * element.qty!}");
      data.add(
        (element.discountType == "amount")
            ? {
                "name": element.name,
                "item_name": element.itemName,
                // "description": element.description,
                "uom": element.uom,
                "conversion_factor": element.conversionFactor,
                "item_code": element.itemCode,
                "qty": CommonMethod().convertToDouble(element.qty),
                "margin_type": "Amount",
                "discount_amount":
                    CommonMethod().convertToDouble(element.discountAmount),
                // : element.discountData!.basePrice -
                //     element.discountData!.discountBasePrice,
                "discount_percentage": (element.discountAmount! * 100) /
                    (element.basePriceListRate! * element.qty!)
              }
            : {
                "name": element.name,
                "item_name": element.itemName,
                // "description": element.description,
                "uom": element.uom,
                "conversion_factor": element.conversionFactor,
                "item_code": element.itemCode,
                "qty": CommonMethod().convertToDouble(element.qty),
                // if (element.discountType != null)
                "discount_percentage": element.discountPercentage,
              },
      );
    }

    // log("--->hee${storedCartData.value.data!.items.first.discountData!.invoiceDiscount!}---x100----/---${storedCartData.value.data!.items.first.amount!}");

    var requestData = {
      if (storedCartData.value.data!.additionalDiscountPercentage != 0.0 ||
          storedCartData.value.data!.discountAmount != 0.0)
        "apply_discount_on": "Net Total",
      if (storedCartData.value.data!.additionalDiscountPercentage != 0.0 ||
          storedCartData.value.data!.discountAmount != 0.0 &&
              storedCartData.value.data!.items.first.totaldiscountType ==
                  "percentage")
        "additional_discount_percentage":
            storedCartData.value.data!.additionalDiscountPercentage,
      // if (storedCartData.value.data!.discountAmount != 0.0 &&
      //     storedCartData.value.data!.items.first.totaldiscountType == "amount")
      //   "additional_discount_percentage":
      //       (storedCartData.value.data!.discountAmount! * 100) /
      //           storedCartData.value.data!.baseTotal!,
      if (storedCartData.value.data!.additionalDiscountPercentage != 0.0 ||
          storedCartData.value.data!.discountAmount != 0.0 &&
              storedCartData.value.data!.items.first.totaldiscountType ==
                  "amount")
        "discount_amount": storedCartData.value.data!.discountAmount,
      // "docstatus": 1,
      "items": data,
      "taxes": [
        {
          "account_head": "CANADA HST  5% - H",
          "rate": 5.0,
          "charge_type": "On Net Total",
          "description": "CANADA HST  5%"
        },
        {
          "account_head": "ONTRIO TAX RATE 8% - H",
          "rate": 8.0,
          "charge_type": "On Net Total",
          "description": "ONTRIO TAX RATE 8%"
        }
      ],
    };

    log("Request Data---$requestData");

    final response = await NetworkRepository().updateQuotation(
      context,
      qid: dataStorages.read("qID"),
      data: requestData,
    );
    log("DATA---${response["body"]}");
    if (response != null && response['statusCode'] == 200) {
      qtycontroller.value.text = "1";
      var cartData = GetAllCartDataModel.fromJson(response["body"]);
      log("body----${cartData.data}");
      List<ProductItem> dd = [];
      // log("message--${cartData.toJson()}");

      for (var i in cartData.data!.items) {
        dd.add(i);
        i.discountData = DiscountData();
      }
      activeCartData.value = cartData;
      // todo: uncomment line below later. date 8th jan 2023
      // activeCartList.value =
      //     data.map((item) => ProductItem({...item})).toList();

      activeCartData.refresh();
      activeCartList.refresh();
      log("\x1B[33m GET ITEMS LIST [ITEM DETAILS SCREEN] LEN ${activeCartData.toJson()} \x1B[0m");
    } else if (response != null && response['statusCode'] == 404) {
      // showCustomerListDialog(context).whenComplete(() {
      //   selectedCustomer.value = dataStorages.read("customer_name");
      // });
    } else {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: "Unknown error occured",
        type: 'error',
      );
    }
  }

  RxList<Map<String, dynamic>> abc = <Map<String, dynamic>>[].obs;

  Future updateCart(
    context, {
    itemCode,
    quotationid,
    fromcart,
    itemPrice,
    fromDetails,
    itemname,
    description,
    uom,
    confactor,
  }) async {
    // ignore update cart
    log("TF CHECK ==> $fromcart");
    abc.refresh();
    activeCartList.refresh();
    activeCartData.refresh();

    abc.value = activeCartList.map((element) {
      return (element.discountType == "amount")
          ? {
              "name": element.name,
              "item_name": element.itemName,
              // "description": element.description,
              "uom": element.uom,
              "conversion_factor": element.conversionFactor,
              "item_code": element.itemCode,
              "qty": CommonMethod().convertToDouble(element.qty),
              "margin_type": "Amount",
              "discount_amount":
                  (element.discountData!.discountBasePrice == element.rate)
                      ? 0.00
                      : element.discountAmount,
              // : element.discountData!.basePrice -
              //     element.discountData!.discountBasePrice,
              "discount_percentage":
                  element.discountAmount! * 100 / element.rate!,
            }
          : {
              "name": element.name,
              "item_name": element.itemName,
              // "description": element.description,
              "uom": element.uom,
              "conversion_factor": element.conversionFactor,
              "item_code": element.itemCode,
              "qty": CommonMethod().convertToDouble(element.qty),
              // if (element.discountType != null)
              "discount_percentage": element.discountPercentage,
            };
    }).toList();

    activeCartList.refresh();
    abc.refresh();

    log("update cart items value---$abc");
    if (fromcart == false) {
      abc.add(formatCartItem({
        "item_code": itemCode,
        "qty": 1.0,
        "rate": CommonMethod().convertToDouble(itemPrice),
        "item_name": itemname,
        "description": description,
        "uom": uom,
        "conversion_factor": confactor,
      }));
    }
    // : null;
    if (fromDetails) {
      abc.add(formatCartItem({
        "item_code": itemCode,
        "qty": CommonMethod().convertToDouble(qtycontroller.value.text),
        "rate": CommonMethod().convertToDouble(itemPrice),
        "item_name": itemname,
        "description": description,
        "uom": uom,
        "conversion_factor": confactor,
      }));
    }
    abc.refresh();
    log("in cart update");

    // ignore the api which is unnecessary don't call

    // return;
    // end of blocked code

    // todo: here also update total net weight etc on frontend on updatecart.
    var mappedItems = [];
    for (var item in abc.value) {
      var mappedItem = formatCartItem(item);
      mappedItems.add(mappedItem);
    }

    var currentCartDataJson = activeCartData.value.toJson();
    final updateCartData = {
      ...currentCartDataJson['data'],
      "customer_name": dataStorages.read("customer_name"),
      "items": mappedItems,
      "taxes": [
        {
          "account_head": "CANADA HST  5% - H",
          "rate": 5.0,
          "charge_type": "On Net Total",
          "description": "CANADA HST  5%"
        },
        {
          "account_head": "ONTRIO TAX RATE 8% - H",
          "rate": 8.0,
          "charge_type": "On Net Total",
          "description": "ONTRIO TAX RATE 8%"
        }
      ],
    };

    final response = await NetworkRepository().updateCart(
      context,
      updateCartData,
      quotationid: dataStorages.read("qID"),
    );

    activeCartList.refresh();
    activeCartData.refresh();
    quotationID = '';

    await getCartData(context, quotationID);
    qtycontroller.value.text = "1";
    if (abc.isEmpty) {
      manualDiscountValue.value = 0.00;
      manualAmountcnt.value.text = "";
      log("Empty------££££");
    }
    refreshallAmounts('updateCart()');
    activeCartList.refresh();
    activeCartData.refresh();
  }

  Rx<GetAllCartDataModel> activeCartData = GetAllCartDataModel().obs;
  Rx<GetAllCartDataModel> storedCartData = GetAllCartDataModel().obs;
  RxList<GetAllCartDataModel> storedList = <GetAllCartDataModel>[].obs;
  RxList<GetAllCartDataModel> storedCartDataList = <GetAllCartDataModel>[].obs;
  RxList<ProductItem> activeCartList = <ProductItem>[].obs;
  RxList<DiscountData> savedCartList = <DiscountData>[].obs;
  Rx<DiscountData> savedCartData = DiscountData().obs;
  RxDouble totalTax = 0.0.obs;
  RxBool isEditSalesOrder = false.obs;

//! CALCULATE CART PRICE
  List<double> calcdiscountBasePrice() {
    discountedPriceList.value = activeCartList.map((element) {
      log("message--- 1 -$discountedPriceList-------${element.discount}-----${element.baseAmount}----${element.manualProductDiscount!}");
      return (selectpresent.value != -1)
          ? double.parse((element.basePriceListRate! * element.qty! -
                  (element.basePriceListRate! * element.qty!) *
                      (element.dialogDiscount ?? 0) /
                      100)
              .toStringAsFixed(2))
          : (selectedType.value == 0)
              ? ((element.basePriceListRate ?? 0)! * (element.qty ?? 0)!) -
                  (element.dialogDiscount ?? 0)
              : (double.parse((element.baseAmount -
                      element.baseAmount * element.discount / 100)
                  .toStringAsFixed(2)));
    }).toList();

    // activeCartList.forEach((element) {
    //   // for (var i = 0; i < activeCartList.length; i++) {
    //   element.discountData!.discountBasePrice =
    //       discountedPriceList[activeCartList.indexOf(element)];
    //   log("discount price---${element.discountData!.discountBasePrice}");
    // });

    log("Discount--- 1 ---$discountedPriceList");
    discountedPriceList.refresh();
    return discountedPriceList;
  }

  double calcsubTotalAmount() {
    discountedsubtotalPriceList.value = activeCartList.map((element) {
      return (selectpresent.value != -1)
          ? double.parse(
              (element.baseAmount - element.baseAmount * element.discount / 100)
                  .toStringAsFixed(2))
          : (selectedType.value == 0)
              ? element.baseAmount - element.manualProductDiscount!
              : double.parse((element.baseAmount -
                          element.baseAmount * element.discount / 100)
                      .toStringAsFixed(2)) -
                  (double.parse((element.baseAmount -
                              element.baseAmount * element.discount / 100)
                          .toStringAsFixed(2))) *
                      element.manualProductDiscount! /
                      100;
    }).toList();
    subTotal.value = (discountedsubtotalPriceList.fold(0, (p, c) => p + c));
    log("Discount--- 2 ---${subTotal.value.toString()}----->$discountedsubtotalPriceList------${(selectpresent.value != -1)}=-------${(selectedType.value == 0)}");
    discountedsubtotalPriceList.refresh();

    update();
    return subTotal.value;
  }

  double calctotalDiscountedAmount() {
    // Future.delayed(Duration(milliseconds: 10), () {
    discountedPrice.value = activeCartList
        .map((element) => element.baseAmount)
        .toList()
        .fold(0, (p, c) => p + c);
    log("Discount--- 3 ---${discountedPrice.value}");
    // });
    update();
    return discountedPrice.value;
  }

  double calctotalTaxPayable() {
    totalTaxPayableAmount.value =
        double.parse((subTotal.value * 13 / 100).toStringAsFixed(2));
    log("Discount--- 4 ---${double.parse((subTotal.value * 13 / 100).toStringAsFixed(2))}");

    update();
    return totalTaxPayableAmount.value;
  }

  double calcfinalTotalAmount() {
    totalAmount.value = (selectedOverallType.value == 0)
        ? double.parse((subTotal.value + totalTaxPayableAmount.value)
                .clamp(0, subTotal.value + totalTaxPayableAmount.value)
                .toStringAsFixed(2)) -
            invoiceDiscount.value
        : double.parse((subTotal.value + totalTaxPayableAmount.value)
                .clamp(0, subTotal.value + totalTaxPayableAmount.value)
                .toStringAsFixed(2)) -
            invoiceDiscount.value;

    // log("Discount--- 56 ---${totalAmount.value}----${double.parse((subTotal.value + totalTaxPayableAmount.value).clamp(0, subTotal.value + totalTaxPayableAmount.value).toStringAsFixed(2)) - (double.parse((subTotal.value + totalTaxPayableAmount.value).clamp(0, subTotal.value + totalTaxPayableAmount.value).toStringAsFixed(2)) * invoiceDiscount.value / 100)}-------${subTotal.value}----${totalTaxPayableAmount.value}------${invoiceDiscount.value}-----${totalAmount.value}----${selectedOverallType.value == 0}");
    log("Discount--- 56 ---${totalAmount.value}----${subTotal.value}---${totalTaxPayableAmount.value}---${invoiceDiscount.value}----${double.parse((subTotal.value + totalTaxPayableAmount.value).toString())}----${double.parse(((subTotal.value + totalTaxPayableAmount.value) * invoiceDiscount.value / 100).toString())}");

    update();
    return totalAmount.value;
  }

  updateCartTotalLocally() async {
    double baseTotal = 0;
    double discountAmount = storedCartData.value.data?.discountAmount ?? 0;

    double totalTaxesAndCharges = 0;
    double grandTotal = 0;
    double totalNetWeight = 0;

    for (var item in activeCartList) {
      var qty = (item.qty ?? 0);

      // discountAmount
      // discountType
      // discountPercentage

      // use amount because it considers discount
      var itemPrice = (item.basePriceListRate! - (item.discountAmount ?? 0));
      item.amount = itemPrice * qty;
      baseTotal += itemPrice * qty;

      // todo: work out later how to merge discount from product with normal discount dialog
      // discountAmount += item.overallDiscount ?? 0;
      totalNetWeight += (item.totalWeight ?? 0) * qty;
      grandTotal += itemPrice * qty;
    }

// tax calculation

    num totalTaxPercent = 0;
    for (var tax in storedCartData.value.data?.taxes ?? []) {
      totalTaxPercent += tax?['rate'] ?? 0;
    }

    baseTotal = CommonMethod().round2(baseTotal);

    var discountPercentage =
        storedCartData.value.data?.additionalDiscountPercentage ?? 0;

    if (discountPercentage > 0) {
      discountAmount = discountPercentage * baseTotal * 0.01;
    }
    log('discountPercentage $discountPercentage');

    discountAmount = CommonMethod().round2(discountAmount);

    grandTotal = grandTotal - discountAmount;

    totalTaxesAndCharges = totalTaxPercent * 0.01 * grandTotal;
    grandTotal += totalTaxesAndCharges;

    grandTotal = CommonMethod().round2(grandTotal);
    totalNetWeight = CommonMethod().round2(totalNetWeight);
    totalTaxesAndCharges = CommonMethod().round2(totalTaxesAndCharges);

    activeCartData.value.data!.baseTotal = baseTotal;
    activeCartData.value.data!.discountAmount = discountAmount;
    activeCartData.value.data!.totalTaxesAndCharges = totalTaxesAndCharges;
    activeCartData.value.data!.grandTotal = grandTotal;
    activeCartData.value.data!.totalNetWeight = totalNetWeight;

    final response = await NetworkRepository().getCart(null, '');

    response['base_total'] = baseTotal;
    response['discount_amount'] = discountAmount;
    response['total_taxes_and_charges'] = totalTaxesAndCharges;
    response['grand_total'] = grandTotal;
    response['total_net_weight'] = grandTotal;

    // store the update data
    activeCartData.refresh();
    // await NetworkRepository().updateCart(null, response);
  }

  refreshallAmounts([msg = '']) async {
    print('refresh all amounts: $msg');
    updateCartTotalLocally();
    // Timer(Duration(seconds: 1), () {
    //   updateCartTotalLocally();
    // });
    // calcdiscountBasePrice();
    // calcsubTotalAmount();
    // calctotalDiscountedAmount();
    // calctotalTaxPayable();
    // calcfinalTotalAmount();
    // activeCartData.refresh();
    // discountedPriceList.refresh();
  }

  refreshdata() {
    // calcdiscountBasePrice();
    calcsubTotalAmount();
    calctotalDiscountedAmount();
    calctotalTaxPayable();
    calcfinalTotalAmount();
    calcdialogDiscount();
    activeCartData.refresh();
    discountedPriceList.refresh();
  }

  clearSelectedCustomer() {
    dataStorages.write("customer", '');
    dataStorages.write("customer_name", 'guest');
    if (activeCartData.value.data != null) {
      activeCartData.value.data!.customerName = 'guest';
      activeCartData.value.data!.customer = null;
    }
    isGuestCustomer.value = true;
    selectedCustomer.value = '';
    activeCartData.refresh();
  }

  restoreSelectedCustomer(customer, customerName) {
    dataStorages.write("customer", customer ?? '');
    dataStorages.write("customer_name", customerName ?? 'guest');

    if (customerName == null ||
        customerName.isEmpty ||
        customerName == 'guest') {
      isGuestCustomer.value = true;
    } else {
      isGuestCustomer.value = false;
      selectedCustomer.value = customerName;
    }
  }

  setAmountLocal() async {
    List<double> basePrice =
        activeCartList.map((element) => element.basePriceListRate!).toList();
    List<double> discountedPrice =
        activeCartList.map((element) => element.amount!).toList();

    await dataStorages.write("basePrice", basePrice);
    await dataStorages.write("discountedBasePrice", discountedPrice);
    await dataStorages.write("subTotal", activeCartData.value.data!.baseTotal);
    await dataStorages.write(
        "invoiceDiscount", activeCartData.value.data!.discountAmount);
    await dataStorages.write(
        "totalTax", activeCartData.value.data!.totalTaxesAndCharges);
    await dataStorages.write(
        "totalAmount", activeCartData.value.data!.grandTotal);
    await dataStorages.write("cartId", activeCartData.value.data!.name);

    List dd = dataStorages.read('discountedBasePrice');
    log("before---$discountedPriceList----${subTotal.value}----${invoiceDiscount.value}---${totalTaxPayableAmount.value}----${totalAmount.value}----${activeCartData.value.data!.name}");
    for (var i in activeCartData.value.data!.items) {
      log("--------------------");
      // log("index--\n\n\n\n\n---${activeCartData.value.data!.items.indexWhere((element) => element.itemCode == i.itemCode)}");
      // log(activeCartData.value.data!.items.length.toString());

      // if (dataStorages.read("discount") != null) {
      //   i.discount = dataStorages.read("discount");
      // }
      log("discount base price----->1--${i.discountData!.invoiceDiscount}");
      i.discountData = DiscountData(
        itemCode: i.itemCode,
        basePrice: i.baseAmount,
        discountBasePrice: i.amount,
        subtotal: dataStorages.read('subTotal'),
        invoiceDiscount: dataStorages.read('invoiceDiscount'),
        totalTax: dataStorages.read('totalTax'),
        finalTotal: dataStorages.read('totalAmount'),
        cartId: dataStorages.read('cartId'),
        cartName: dataStorages.read('cartName'),
        createdAt: dataStorages.read('createdAt'),
      );
      i.discountType = dataStorages.read('discountType');
      i.totaldiscountType = dataStorages.read('totaldiscountType');

      activeCartList.value = activeCartData.value.data!.items;
      activeCartData.value.data!.customerName =
          dataStorages.read("customer_name");
      log("discount base price----->${i.discountData!.discountBasePrice}");
    }
    storedCartData.value = activeCartData.value;
    storedCartData.refresh();
  }

  //! Only calculate for Discount dialog
  calcdialogDiscount() {
    dialogDiscount.value = activeCartList.map((element) {
      log("message-----------${element.dialogDiscount}-----${element.baseAmount}----${element.dialogDiscount!}----${selectpresent.value != -1}----${selectedType.value == 0}");
      return (selectpresent.value != -1)
          ? double.parse((element.basePriceListRate! * element.qty! -
                  (element.basePriceListRate! * element.qty!) *
                      element.dialogDiscount! /
                      100)
              .toStringAsFixed(2))
          : (selectedType.value == 0)
              ? ((element.basePriceListRate ?? 0)! * (element.qty ?? 0)!) -
                  (element.dialogDiscount ?? 0)!
              : (double.parse(
                  ((element.basePriceListRate ?? 0)! * (element.qty ?? 0)! -
                          (element.basePriceListRate ?? 0)! *
                              (element.qty ?? 0)! *
                              (element.dialogDiscount ?? 0)! /
                              100)
                      .toStringAsFixed(2)));
    }).toList();
    log("message---->->->->---$dialogDiscount");
  }

  calcInvoiceDiscount() {
    // invoiceDiscount.value = dialogTotalDiscount.value;
    invoiceDiscount.value = (selectedOverallType.value == 0)
        ? dialogTotalDiscount.value
        : (double.parse((subTotal.value + totalTaxPayableAmount.value)
                .clamp(0, subTotal.value + totalTaxPayableAmount.value)
                .toStringAsFixed(2)) *
            dialogTotalDiscount.value /
            100);
    log("invoice----${invoiceDiscount.value}");
  }

  calcDialogTotalAmount() {
    // dialogTotalAmount.value = (selectedOverallType.value == 0)
    //     ? totalAmount.value - dialogTotalDiscount.value
    //     : totalAmount.value -
    //         (totalAmount.value * dialogTotalDiscount.value / 100);

    dialogTotalAmount.value = (selectedOverallType.value == 0)
        ? double.parse(((activeCartData.value.data!.baseTotal ?? 0))
                .toStringAsFixed(2)) -
            dialogTotalDiscount.value
        : double.parse(
                ((activeCartData.value.data!.baseTotal ?? 0)!).toString()) -
            (double.parse(((activeCartData.value.data!.baseTotal ?? 0)!)
                    .toStringAsFixed(2)) *
                dialogTotalDiscount.value /
                100);

    update();
    return totalAmount.value;
  }
  // calcDialogTotalAmount() {
  //   // dialogTotalAmount.value = (selectedOverallType.value == 0)
  //   //     ? totalAmount.value - dialogTotalDiscount.value
  //   //     : totalAmount.value -
  //   //         (totalAmount.value * dialogTotalDiscount.value / 100);

  //   for (var e in activeCartData.value.data!.items) {
  //     dialogTotalAmount.value = (selectedOverallType.value == 0)
  //         ? e.discountData.first.subtotal! +
  //             e.discountData.first.totalTax! -
  //             e.discountData.first.invoiceDiscount!
  //         : (e.discountData.first.subtotal! +
  //                 e.discountData.first.totalTax! -
  //                 e.discountData.first.invoiceDiscount!) -
  //             (e.discountData.first.subtotal! +
  //                     e.discountData.first.totalTax! -
  //                     e.discountData.first.invoiceDiscount!) *
  //                 e.discountData.first.invoiceDiscount! /
  //                 100;
  //     log("Discount--- 5 ---${e.discountData.first.subtotal}----${e.discountData.first.totalTax}-------${e.discountData.first.invoiceDiscount}----");
  //   }

  //   update();
  //   return totalAmount.value;
  // }

  decrementCart(ProductItem data) {
    var qty = storedCartData.value.data?.items
            .firstWhere((item) => item.itemCode == data.itemCode)
            .qty ??
        0;

    data.baseAmount -= (data.baseNetRate ?? 0)!;
    subTotal.value -= (data.baseNetRate ?? 0)!;

    totalTaxPayableAmount.value =
        double.parse((subTotal.value * 13 / 100).toStringAsFixed(2));
    totalAmount.value =
        subTotal.value + totalTaxPayableAmount.value - invoiceDiscount.value;
    data.qty = qty - 1;

    var i = 0;
    List<ProductItem> newItems = [];
    for (var item in activeCartData.value.data!.items) {
      if (data.itemCode == item.itemCode) {
        newItems.add(data);
      } else {
        newItems.add(item);
      }
      i++;
    }

    activeCartData.value.data!.items = newItems;
    activeCartList.value = newItems;

    activeCartList.refresh();
    activeCartData.refresh();
    refreshallAmounts('decrementCart()');
  }

  incrementCart(
    context,
    ProductItem data,
  ) async {
    // check stock here
    var itemStock = data.stockQty ?? 0;
    // var itemStock = 5;

    storedCartData.refresh();

    print('inside increment cart---');
    // get the most uptodate to avoid issue from product item adding
    var qty = storedCartData.value.data?.items
            .firstWhere((item) => item.itemCode == data.itemCode)
            .qty ??
        0;

    // var qty = (data?.qty ?? 0);

    var isEditMode = isEditSalesOrder.value;

    if (!isEditMode && itemStock <= qty) {
      return CommonMethod().showToast(
        context,
        title: "Stock limit reached!",
        message: "Not enough items in stock.",
        type: 'error',
      );
    }

    data.baseAmount += (data.baseNetRate ?? 0)!;
    subTotal.value += (data.baseNetRate ?? 0)!;

    totalTaxPayableAmount.value =
        double.parse((subTotal.value * 13 / 100).toStringAsFixed(2));
    totalAmount.value =
        subTotal.value + totalTaxPayableAmount.value - invoiceDiscount.value;
    data.qty = qty + 1;
    // data.amount = (CommonMethod().convertToDouble(data.priceListRate) -
    //         (data.discountAmount ?? 0)) *
    //     qty;

    var i = 0;
    List<ProductItem> newItems = [];
    for (var item in activeCartData.value.data!.items) {
      if (data.itemCode == item.itemCode) {
        newItems.add(data);
      } else {
        newItems.add(item);
      }
      i++;
    }
    activeCartData.value.data!.items = newItems;
    activeCartList.value = activeCartData.value.data!.items;

    activeCartList.refresh();
    activeCartData.refresh();
    refreshallAmounts('incrementCart()');
  }

  RxBool noData = true.obs;
  Future getCartData(context, quotationid) async {
    final response = await NetworkRepository().getCart(context, quotationid);
    noData.value = false;
    activeCartData.value = GetAllCartDataModel.fromJson({'data': response});
    activeCartList.clear();
    refreshallAmounts('getCartData()');

    for (var i in activeCartData.value.data!.items) {
      List dd = [];
      if (dataStorages.read("discountedBasePrice") != null) {
        dd = dataStorages.read('discountedBasePrice');
      }
      if ((dataStorages.read("qId") != null)) {
        dataStorages.write("qId", activeCartData.value.data!.name);
      }
      i.discountData = DiscountData(
        itemCode: i.itemCode,
        basePrice: i.baseAmount,
        discountBasePrice: dd.isEmpty ? 0.00 : i.amount,
        subtotal: dataStorages.read('subTotal'),
        invoiceDiscount: dataStorages.read('invoiceDiscount'),
        totalTax: dataStorages.read('totalTax'),
        finalTotal: dataStorages.read('totalAmount'),
        cartId: dataStorages.read('cartId'),
        cartName: dataStorages.read('cartName'),
        createdAt: dataStorages.read('createdAt'),
      );
      activeCartData.value.data!.customerName =
          dataStorages.read("customer_name");
      if (dataStorages.read("customer_name") != null) {
        selectedCustomer.value = dataStorages.read("customer_name");
      }
      activeCartList.add(ProductItem.products(i));
    }
    storedCartData.value = activeCartData.value;
    storedCartData.refresh();
    log("stored cart---${storedCartData.value.toJson()}");

    activeCartList.refresh();
    activeCartData.refresh();
    discountedPrice.value = activeCartList
        .map((element) => element.baseAmount)
        .toList()
        .fold(0, (p, c) => p + c);

    refreshallAmounts('getCartData()');
    calcdialogDiscount();
    calcDialogTotalAmount();
  }

  Rx<GetFilterTypeModel> getTypeFilterData = GetFilterTypeModel().obs;

  Future getFilterOptions(context) async {
    final response = await NetworkRepository().getFilterOptions(context);
    if (response['statusCode'] == 200) {
      var result = response['body']['result'];
      var weights = {'data': result['weights']};
      var strains = {'data': result['strains']};
      var terpenes = {'data': result['terpenes']};
      getTypeFilterData.value = GetFilterTypeModel.fromJson(strains);
      getTapereneFilterData.value = GetFilterTapereneModel.fromJson(terpenes);
      getWeightFilterData.value = GetFilterWeightModel.fromJson(weights);
    } else {
      noData.value = true;
      activeCartData.refresh();
    }
  }

  Future getFilerTypes(context) async {
    final response = await NetworkRepository().getAllType(context);
    log("GET ALL TYPE FOR FILTERS CONTROLLER==> ${response['statusCode']}");
    if (response['statusCode'] == 200) {
      getTypeFilterData.value = GetFilterTypeModel.fromJson(response['body']);
      log("GET ALL TYPE FOR FILTERS CONTROLLER ==> ${getTypeFilterData.value.toJson()}");
    } else {
      noData.value = true;
      activeCartData.refresh();
    }
  }
  // Future getFilerTypes(context) async {
  //   final response = await NetworkRepository().getAllType(context);
  //   log("GET ALL TYPE FOR FILTERS CONTROLLER==> ${response['statusCode']}");
  //   if (response['statusCode'] == 200) {
  //     getTypeFilterData.value = GetFilterTypeModel.fromJson(response['body']);
  //     log("GET ALL TYPE FOR FILTERS CONTROLLER ==> ${getTypeFilterData.value.toJson()}");
  //   } else {
  //     noData.value = true;
  //     activeCartData.refresh();
  //   }
  // }

  Rx<GetFilterTapereneModel> getTapereneFilterData =
      GetFilterTapereneModel().obs;
  Future getFilerTaperene(context) async {
    final response = await NetworkRepository().getAllTaperene(context);
    log("GET ALL TAPERENE FOR FILTERS CONTROLLER==> ${response['statusCode']}");
    if (response['statusCode'] == 200) {
      getTapereneFilterData.value =
          GetFilterTapereneModel.fromJson(response['body']);
      log("GET ALL TAPERENE FOR FILTERS CONTROLLER ==> ${getTypeFilterData.value.toJson()}");
    } else {
      noData.value = true;
      activeCartData.refresh();
    }
  }

  Rx<GetFilterWeightModel> getWeightFilterData = GetFilterWeightModel().obs;
  Future getFilerWeight(context) async {
    final response = await NetworkRepository().getAllWeight(context);
    log("GET ALL WEIGHT FOR FILTERS CONTROLLER==> ${response['statusCode']}");
    if (response['statusCode'] == 200) {
      getWeightFilterData.value =
          GetFilterWeightModel.fromJson(response['body']);
      log("GET ALL WEIGHT FOR FILTERS CONTROLLER ==> ${getTypeFilterData.value.toJson()}");
    } else {
      noData.value = true;
      activeCartData.refresh();
    }
  }

  Future deleteCArt(context, quotationid) async {
    final response = await NetworkRepository().deleteCart(context, quotationid);
    // await getCartData(context, quotationID);
    activeCartData.value.data = null;
    isSelectedCustomer.value = false;
    clearSelectedCustomer();
    // storedCartData.value.data = null;
    activeCartList.clear();
    noData.value = true;
    manualDiscountValue.value = 0.00;
    activeCartData.refresh();
    storedCartData.refresh();
    activeCartList.refresh();
    dataStorages.remove("qID");

    invoiceDiscount.value = 0.00;
    totaldiscountAmountcnt.value.clear();
    // log("DELETE CART RESPONSE");
  }
}
