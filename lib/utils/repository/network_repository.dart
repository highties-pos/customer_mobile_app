import 'dart:developer';

import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/model/cart_model/cart_data_model.dart';

import '../../../components/export.dart';
import '../../app.dart';
import '../../components/common_methos.dart';
import 'package:get/get.dart' as GetPackage;
import '../../model/customer/get_all_store_model.dart';
import '../../state/salesController.dart';
import 'package:dio/src/form_data.dart' as fd;

NetworkRepository networkRepository = NetworkRepository();

class NetworkRepository {
  static final NetworkRepository _networkRepository =
      NetworkRepository._internal();
  static final dataStorage = GetStorage();

  factory NetworkRepository() {
    return _networkRepository;
  }
  NetworkRepository._internal();

  FocusNode searchFocus = FocusNode();

  //! USER LOGIN
  userLogin(context, {email, password, passcode}) async {
    log("\x1B[32m USER LOGIN Email---${email}---Password---${password} \x1B[0m");
    log("\x1B[32m USER LOGIN URL ${ApiAppConstants.login()} \x1B[0m");

    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: ApiAppConstants.login(),
        data: jsonEncode({
          "username": email,
          "password":
              "${passcode != null && !passcode.isEmpty ? passcode : password}",
        }),
      );

      debugPrint('\x1b[99m  USER LOGIN RESPONSE : $response');

      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      throw Exception(e.toString());
    }
  }

  getItemBatchNumbers(context, {itemCode}) async {
    try {
      var data = {
        "doctype": "Batch",
        "filters":
            '{"item_code":"${itemCode}","warehouse":"${getSavedWareHouse()['name']}","posting_date":"2023-10-18"}',
        "query": "erpnext.controllers.queries.get_batch_no",
        "txt": ""
      };
      log('data is');
      log(jsonEncode(data));
      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        data: data,
        url: 'http://3.97.254.80/api/method/frappe.desk.search.search_link',
        // url: ApiAppConstants.getBatchNumbers,
        // data: data,
        // '?filters=[["item","=", "$itemCode"]]&fields=["*"]',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );

      throw Exception(e.toString());
    }
  }

  getItemsList(context, {url}) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );

      throw Exception(e.toString());
    }
  }

  static getCustomerGroups(context) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        // url: ApiAppConstants.apiEndPoint + ApiAppConstants.chartDiscount,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.customerGroups,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );

      throw Exception(e.toString());
    }
  }

  //! GET POS PROFILE
  getPOSProfilesBasedOnWarehouse(context, {url}) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      debugPrint('\x1b[99m GET POS PROFILE RESPONSE] : $response');
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );

      throw Exception(e.toString());
    }
  }

  getItemsListApi2(context, {data}) async {
    try {
      print('the get items list api2');
      print(context);
      print(data);
      var response = await NetworkDioHttp.putDioHttpMethod(
        data: {
          'warehouse': 'EMBRUN - H',
          'item_group': 'Capsules',
        },
        context: context,
        url: ApiAppConstants.mobileListProducts,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      print('the response record is');
      print(response['body']['message']['records']);
      return response;
    } catch (e) {
      print('error in sending request to api');
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      throw Exception(e.toString());
    }
  }

  getItemsListSearch(context, {url, data}) async {
    log("\x1B[32m SEARCH ITEMS LIST [HOME SCREEN]} \x1B[0m");
    log("\x1B[32m SEARCH ITEMS LIST [HOME SCREEN] URL 444 passingData=> $url ==>> $data \x1B[0m");

    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: data,
        context: context,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m SEARCH ITEMS LIST [HOME SCREEN] : $response');

      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );

      throw Exception(e.toString());
    }
  }

  getCart(context, quotationid) async {
    try {
      dynamic cartFromMemory = getCartFromMemory();
      dynamic cartModelData;
      return cartFromMemory;
      // if (cartFromMemory != null) {
      //   cartModelData = TotalCartData.fromJson(cartFromMemory);
      // }
      // return cartModelData;
      // for (var item in response['body']['data']['items']) {
      //   // batch number in sales controller is stored on add to cart.
      //   // simulate adding batch number in api by reading from local storage as api doesn't support it
      //   var batchNo = getSavedBatchNumber(item["item_code"]) ?? '';
      //   // print('adding batch no $batchNo');
      //   item['batch_no'] = batchNo;
      // }
    } catch (e) {
      print('error in get cart');
      print(e.toString());
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );

      throw Exception(e.toString());
    }
  }

  //! CREATE NEW CUSTOMER
  createNewCustomer(context, {data}) async {
    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: data,
        context: context,
        url: ApiAppConstants.apiEndPoint + "customers",
      );
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      throw Exception(e.toString());
    }
  }

  // update customer
  updateCustomer(context, {id, data}) async {
    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: data,
        context: context,
        url: ApiAppConstants.apiEndPoint + "customers/update/" + id,
      );
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrrr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  //! GET ALL CUSTOMER
  getAllCustomerbySearch(context, data) async {
    try {
      final url = ApiAppConstants.apiEndPoint +
          "${ApiAppConstants.getAllCustomerbySearch}?start=${data['start']}&limit=${data['limit']}&search=${data['query']}&limited_fields=true";
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        // data: data,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET CUSTOMER CUSTOMER search by url : $url');

      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrrr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  getAllCustomer(context, data, queryParameters) async {
    log("\x1B[32m GET ALL CUSTOMER} \x1B[0m");
    log("\x1B[32m GET ALL CUSTOMER URL $data---$queryParameters \x1B[0m");
    log("\x1B[32m GET ALL CUSTOMER URL-1 ${ApiAppConstants.apiEndPoint + ApiAppConstants.getAllCustomer} \x1B[0m");

    final queryUrl = queryParameters.entries.map((entry) {
      return '${entry.key}=${entry.value}';
    }).join('&');
    final url = ApiAppConstants.apiEndPoint +
        ApiAppConstants.getAllCustomer +
        '?' +
        queryUrl;

    // Uri customUri = Uri(
    //   scheme: ApiAppConstants.apiProtocol,
    //   host: ApiAppConstants.apiHost,
    //   path: '/api/resource/Customer',
    //   query: queryUrl,
    // );
    print('url to send is $url');
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        data: data,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET CUSTOMER CUSTOMER : $response');

      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrrr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  checkPOSProfileStatus(context, url) async {
    log("\x1B[32m CHECK POS PROFILE STATUS} \x1B[0m");
    log("\x1B[32m CHECK POS PROFILE STATUS URL $url \x1B[0m");

    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m CHECK POS PROFILE STATUS CUSTOMER : $response');

      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrrr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  //! GET ALL ITEMS GROUP
  filterItembyType(context,
      {required Map<String, dynamic> queryParameters,
      required Map<String, dynamic> data}) async {
    // NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
    log("\x1B[32m GET ALL Item Group data SINGLE");
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        // url: "http://3.97.254.80/api/resource/Item Group",
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.filterItem,
        queryParameters: queryParameters,
        data: fd.FormData.fromMap({...data}),
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET CUSTOMER CUSTOMER  GYGYGYG: $response');

      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrr yyyyr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  gteAllAItemsGroup(context) async {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);

    log("\x1B[32m GET ALL Item Group data (old api)} \x1B[0m");
    // log("\x1B[32m GET ALL CUSTOMER URL $data \x1B[0m");
    log("coockie ==> 'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image='");
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: "http://3.97.254.80/api/resource/Item Group",
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET CUSTOMER CUSTOMER  GYGYGYG: $response');

      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrr yyyyr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  //!Get Product Stock
  getProductStock(context, {url, queryParameters}) async {
    log("\x1B[32m GET Product Stock ---${queryParameters}\x1B[0m");
    log("\x1B[32m GET Product Stock URL---${url}\x1B[0m");
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
        // queryParameters: queryParameters,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET CUSTOMER CUSTOMER  GYGYGYG: $response');

      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log("rooorrrrr yyyyr==> $e ==> $st");
      throw Exception(e.toString());
    }
  }

  //! GET ITEMS BY ITEM CODE [ITEM DETAIL SCREEN]
  getItemsByCode(context, {itemCode}) async {
    try {
      var url = ApiAppConstants.getItemsDetail(itemCode: itemCode);
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
      );
      return response;
    } catch (e, st) {
      print('error in getting item by code');
      log(e.toString());
      log(st.toString());
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      // throw Exception(e.toString());
    }
  }

  //! CREATE FIRST CART
  createCart(context, data) async {
    log("\x1B[32m CRAETE CART PASSING DATA} \x1B[0m");
    try {
      saveCartToMemory(data);
      // store cart in storage
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Create Cart Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
      log(st.toString());
      // throw Exception(e.toString());
    }
  }

  //! OPEN POS PROFILE
  openPOSProfile(context, {data}) async {
    log("\x1B[32m OPEN POS PROFILE DATA} \x1B[0m");
    log("\x1B[32m OPEN POS PROFILE DATA ${jsonEncode(data)} \x1B[0m");
    log("\x1B[32m OPEN POS PROFILE URL ${ApiAppConstants.apiEndPoint + ApiAppConstants.openPOSProfile} \x1B[0m");
    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: data,
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.openPOSProfile,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      debugPrint('\x1b[99m OPEN POS PROFILE DATA : ${response.toString()}');
      log("after");
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  //! OPEN POS PROFILE
  getItemsGrams(context, {itemName}) async {
    log("\x1B[32m GET ITEM GRAMS API} \x1B[0m");
    log("\x1B[32m GET ITEM GRAMS $itemName \x1B[0m");
    log("\x1B[32m GET ITEM GRAMS URL ${ApiAppConstants.apiEndPoint + ApiAppConstants.openPOSProfile + itemName} \x1B[0m");

    var url =
        ApiAppConstants.apiEndPoint + ApiAppConstants.getItemGrams + itemName;
    print('the url for getItemGrams is $url');
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET ITEM GRAMS : ${response.toString()}');
      log("after");
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  //! CREATE SAVEORDER
  createSalesOrder(context, {data}) async {
    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.createsalesOrder,
        data: data,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  //! GET CUSTOMER BY SEARCH
  getCustomerbySearch(context, {queryParameters}) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getCustomerbySearch,
        queryParameters: queryParameters,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m GET ITEM GRAMS : ${response.toString()}');
      log("after");
      return response;
    } on DioException catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  //! CREATE SALES ORDER
  getSalesOrder(context,
      {String parameters = '', required bool isFilter}) async {
    var fields = '["*"]';
    var isFiltered = "$parameters";

    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            "${ApiAppConstants.apiEndPoint + ApiAppConstants.getsalesOrder}?$isFiltered",
        // queryParameters: parameters,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  static Future confirmAndTender(context, {orderId, skippedItemCodes}) async {
    // also skipped items are to be passed
    // equivalent to place order
    try {
      final apiUrl =
          ApiAppConstants.apiEndPoint + ApiAppConstants.skipConfirmAndTender;

      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: apiUrl,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
        data: {
          "sales_order_name": orderId,
          "skipped_item_codes": [skippedItemCodes]
        },
      );

      CommonMethod().showToast(
        context,
        title: "Success",
        message: "Sales Order tendered Successfully",
        type: 'success',
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  static Future<String> getPayfirmaAccessToken(context) async {
    // also skipped items are to be passed
    // equivalent to place order
    try {
      final apiUrl = ApiAppConstants.payfirmaCreateSale;
      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: apiUrl,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization":
                "Basic MjQxMTM2YWMyYTMwYTUwNTNkZDQwMzBjOGRiMjU1MjM6OTA5OTRiNTUwMWM2MzNiYTY2OGY5MDhmNjcwYjkwNjk=",
          },
        ),
        data: FormData.fromMap({
          'grant_type': 'client_credentials',
          'client_id': '241136ac2a30a5053dd4030c8db25523',
          'client_secret': '90994b5501c633ba668f908f670b9069',
        }),
      );
      log('payfirma access token:');
      log(jsonEncode(response));
      return 'test';
    } catch (e) {
      log('error in getting access token');
      log(e.toString());
    }
    return '';
  }

  static Future createSaleUsingPaymentGateway(
    context, {
    amount,
    card_expiry_month,
    card_expiry_year,
    card_number,
    cvv,
  }) async {
    // also skipped items are to be passed
    // equivalent to place order
    try {
      final apiUrl = ApiAppConstants.payfirmaCreateSale;
      // String payfirmaToken = await getPayfirmaAccessToken(context);
      // print('the access token for payment received is $payfirmaToken');
      // return;
      var dataMap = {
        "amount": double.parse(amount.toString()),
        "currency": "CAD",
        "card_expiry_month": int.parse(card_expiry_month.toString()),
        "card_expiry_year": int.parse(card_expiry_year.toString()),
        "card_number": int.parse(card_number.toString()),
        "cvv2": int.parse(cvv.toString())
      };
      dataMap.forEach((key, value) {
        print("$key: $value");
      });

      String token =
          "eyJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3NfdG9rZW4iOiIyMTM2N2M4MS0zOWJhLTRjNDAtOThjMC02Y2M3NmQxZjExNTgiLCJzY29wZSI6WyJhbmFseXRpY3MiLCJjdXN0b21lciIsInBsYW4iLCJ0cmFuc2FjdGlvbiJdLCJtZXJjaGFudF9pZCI6ImY0OWQ4ZTk3NTgiLCJleHAiOjIwMDg5MjM3Mzd9.I_vEHF6M5tLuXJqEmLGYGFokuTE-H0JiOuA7WckhNVA";
      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: apiUrl,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": "Bearer $token",
          },
        ),
        data: dataMap,
      );
      log('payfirma output!');
      log(jsonEncode(response['body']));
      return response['body'];
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  updateOrderStatus(context, {data, salesOrderName}) async {
    try {
      var response = await NetworkDioHttp.putDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.updateSalesOrderStatus +
            '${salesOrderName}/status',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
        data: data,
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  updateSalesOrder(context, {data, salesOrderName}) async {
    try {
      var response = await NetworkDioHttp.putDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.updateSalesOrder +
            '${salesOrderName}',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
        data: data,
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
    }
  }

  static getSalesInvoiceDetails(context, {invoiceId}) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.getPOSInvoiceDetail +
            '/$invoiceId/mobile',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error in loading invoice list",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  static getInvoices(context, {parameters}) async {
    try {
      final url = ApiAppConstants.apiEndPoint +
          ApiAppConstants.getPOSInvoiceDetail;
      print('invoice url is  $url');
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: url,
        header: Options(
          headers: {
            'Cookie':
            'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error in loading invoice list",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  static getSalesInvoiceList(
    context, {
    start = 0,
    limit = 10,
    searchText = "",
    startDate = '',
    endDate = '',
  }) async {
    try {
      var filters = [
        ["status", "=", "Paid"],
      ];
      if (!startDate.isEmpty) {
        filters.add(["posting_date", ">=", startDate]);
      }
      if (!endDate.isEmpty) {
        filters.add(["posting_date", "<=", endDate]);
      }
      if (!searchText.isEmpty) {
        filters.add(["name", "LIKE", '%${searchText}%']);
      }

      print(jsonEncode(filters));
      var filtersJson = jsonEncode(filters);

      // var response = await NetworkDioHttp.postDioHttpMethod(
      //   context: context,
      //   url: ApiAppConstants.apiEndPoint + ApiAppConstants.getPOSInvoice,
      //   header: Options(
      //     headers: {
      //       'Cookie':
      //           'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
      //       "Authorization": dataStorages.read("token"),
      //     },
      //   ),
      //   data: {
      //     'fields': '["*"]',
      //     'limit': limit,
      //     'limit_start': start,
      //     'filters': filtersJson
      //   },
      // );

      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.getPOSInvoice +
            '?fields=["*"]&limit=$limit&limit_start=$start&filters=$filtersJson',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error in loading invoice list",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  getSalesOrderDetails(context, {data, salesOrderId}) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.getsalesOrderDetails +
            '/${data['sales_order_name']}/mobile',
        data: data,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  updateQuotation(context, {data, qid}) async {
    log("\x1B[32m GET SAVEORDER API} \x1B[0m");
    log("\x1B[32m GET SAVEORDER $data \x1B[0m");
    log("\x1B[32m GET SAVEORDER URL ${ApiAppConstants.apiEndPoint + ApiAppConstants.updateQuotation + qid} \x1B[0m");

    try {
      var response = await NetworkDioHttp.putDioHttpMethod(
        context: context,
        url:
            ApiAppConstants.apiEndPoint + ApiAppConstants.updateQuotation + qid,
        data: data,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m UPDATE QUOTATION : ${response.toString()}');
      log("after");
      return response;
    } on DioException catch (e, t) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: "${e.toString()}---${t.toString()}",
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  //! CREATE FIRST CART
  deleteCart(context, quotationID) async {
    try {
      var cartDetails = new TotalCartData(totalNetWeight: 0, items: []);
      saveCartToMemory(cartDetails);
      return null;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
      log(st.toString());
    }
  }

  static cancelOrder(context, {orderId}) async {
    // also skipped items are to be passed
    // equivalent to place order
    try {
      final apiUrl = ApiAppConstants.apiEndPoint +
          ApiAppConstants.deleteSalesOrder +
          '/$orderId';

      var response = await NetworkDioHttp.deleteDioHttpMethod(
        context: context,
        url: apiUrl,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      if (response['statusCode'] == 200) {
        CommonMethod().showToast(
          context,
          title: "Success",
          message: "Sales Order Deleted Successfully",
          type: 'success',
        );
      } else {
        CommonMethod().showToast(
          context,
          title: "Failed",
          message: "Could not delete sales order!",
          type: 'error',
        );
      }
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());

      // throw Exception(e.toString());
    }
  }

  //! GET CUSTOEMR'S DETAILS BY ID
  getCUstomerDetailByID(context, customerID) async {
    log("get customer detail by id ==> ${ApiAppConstants.getCustomerByID + customerID}");
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.getCustomerByID +
            customerID,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      // expected old output:

      // "name": "Test Test",
      // "owner": "Administrator",
      // "creation": "2023-02-24 00:06:29.808894",
      // "modified": "2023-09-08 03:01:44.284143",
      // "modified_by": "Administrator",
      // "idx": 36808,
      // "docstatus": 0,
      // "naming_series": "CUST-.YYYY.-",
      // "customer_name": "Test Test",
      // "first_name": "Test",
      // "last_name": "Test",
      // "medical_patient": "Yes",
      // "customer_type": "Company",
      // "gst_category": "Unregistered",
      // "allow_marketing": "No",
      // "temporary_medical_license": "Yes",
      // "customer_group": "Person",
      // "territory": "All Territories",
      // "so_required": 0,
      // "dn_required": 0,
      // "disabled": 0,
      // "is_internal_customer": 0,
      // "language": "en-US",
      // "is_frozen": 0,
      // "default_commission_rate": 0.0,
      // "doctype": "Customer",
      // "companies": [],
      // "accounts": [],
      // "credit_limits": [],
      // "sales_team": []
      debugPrint('\x1b[99m GET CUSTOMERS DETAIL DATA : ${response.toString()}');
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
      log(st.toString());
    }
  }

  //! Create Invoive
  createInvoice(context, token, data) async {
    log("CREATE INVOICE API ==> $data");
    try {
      // var response = await NetworkDioHttp.postDioHttpMethod(
      //   context: context,
      //   url: ApiAppConstants.apiEndPoint + ApiAppConstants.createInvoice,
      //   data: data,
      //   header: Options(
      //     headers: {
      //       'Cookie':
      //           'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
      //       "Authorization": dataStorages.read("token"),
      //     },
      //   ),
      // );
      // debugPrint('\x1b[99m GET CUSTOMERS DETAIL DATA : ${response.toString()}');
      // return response;
      var url =  '/' +ApiAppConstants.createInvoice;
      print('create invoice $url');
      var response = await postReq(url, token, data);
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
    }
  }

  Future getWarehouseProducts( {warehouseId, categoryId}) async {
    try {
      var url = '/items/mobile-app?limit=12&start=0&warehouse_id=${warehouseId}&item_group=$categoryId';
      var warehouseProductsResponse = await getReq(url);

      if (warehouseProductsResponse.statusCode == 200) {
        var warehouseProductsData =
            jsonDecode(warehouseProductsResponse.body.toString());
        return warehouseProductsData['result'];
      } else {
        print("error");
        print(warehouseProductsResponse.body.toString());
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
    return [];
  }

  //! GET ALL STORES
  getStore(context) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getStore,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      log("before");

      debugPrint('\x1b[99m CRAETE CART PASSING DATA : ${response.toString()}');
      log("after");
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
      log(st.toString());
      // throw Exception(e.toString());
    }
  }

  //! GET ALL TYPE
  getAllType(context) async {
    log("\x1B[32m GET ALL TYPE FOR FILTERS} \x1B[0m");
    // log("\x1B[32m CRAETE CART PASSING DATA $data \x1B[0m");
    log("\x1B[32m GET ALL TYPE FOR FILTERS ${ApiAppConstants.apiEndPoint + ApiAppConstants.getType} \x1B[0m");

    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getType,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      debugPrint('\x1b[99m GET ALL TYPE FOR FILTERS : ${response.toString()}');
      log("after");
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
    }
  }

  //! GET ALL TAPERENE
  getAllTaperene(context) async {
    log("\x1B[32m GET ALL TAPERENE FOR FILTERS} \x1B[0m");
    // log("\x1B[32m CRAETE CART PASSING DATA $data \x1B[0m");
    log("\x1B[32m GET ALL TAPERENE FOR FILTERS ${ApiAppConstants.apiEndPoint + ApiAppConstants.getType} \x1B[0m");

    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getTaperene,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      debugPrint(
          '\x1b[99m GET ALL TAPERENE FOR FILTERS : ${response.toString()}');
      log("after");
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
    }
  }

  //! GET ALL WEIGHT
  getFilterOptions(context) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getFilterOptions,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
    }
  }

  //! GET ALL WEIGHT
  getAllWeight(context) async {
    log("\x1B[32m GET ALL WEIGHT FOR FILTERS} \x1B[0m");
    // log("\x1B[32m CRAETE CART PASSING DATA $data \x1B[0m");
    log("\x1B[32m GET ALL WEIGHT FOR FILTERS ${ApiAppConstants.apiEndPoint + ApiAppConstants.getWeight} \x1B[0m");

    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getWeight,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      debugPrint(
          '\x1b[99m GET ALL WEIGHT FOR FILTERS : ${response.toString()}');
      log("after");
      return response;
    } catch (e) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
    }
  }

  //! CREATE FIRST CART
  updateCart(context, data, {quotationid}) async {
    log("\x1B[32m UPDATE CART PASSING DATA} \x1B[0m");
    try {
      var existingCart = getCartFromMemory();
      if (existingCart != null) {
        for (var key in data.keys) {
          existingCart[key] = data[key];
        }
        saveCartToMemory(existingCart);
      }
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      log(e.toString());
      log(st.toString());
      // throw Exception(e.toString());
    }
  }

  static Future createInvoiceFromSavedOrder(context, {orderName}) async {
    try {
      print('the order name received for saved order invoice is---');
      print(orderName);

      var response = await NetworkDioHttp.postDioHttpMethod(
        data: {'sales_order_name': orderName},
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.salesInvoiceCreateFromSavedOrder,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      print('the response  of saved cart.. invoice generation is $response');
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      // throw Exception(e.toString());
    }
  }

  static Future createInvoiceFromCart(context, data) async {
    try {
      print('inside create invoice from cart function()');
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: data,
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.salesInvoiceCreateFromCart,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m  CART CREATE INVOICE RESPONSE : $response');
      return response;
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
      // throw Exception(e.toString());
    }
  }

  Future<void> checkResponse(
    response,
    modelResponse,
  ) async {
    log("response check------>$response---->Checked");
    if ((response['body']['status'] == 401 ||
            response['body']['status'] == 410) &&
        dataStorage.read("token") != null) {}
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body']['status'] == 200 ||
          response['body']['status'] == "200") {
        return modelResponse;
      } else if (response['body']['status'] == 500 ||
          response['body']['status'] == "500") {
        return modelResponse;
      } else {
        showErrorDialog(message: response['body']['message']);
      }
    } else {
      if (dataStorage.read("token") != null) {
        showErrorDialog(message: response['body']['message']);
      }
    }
  }

  Future<void> checkResponse2(
    response,
  ) async {
    log("response check------>2${response['body']['message']}---->Checked");
    if ((response['body']['status'] == 401 ||
            response['body']['status'] == 410) &&
        dataStorage.read("token") != null) {}
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body']['status'] == 200 ||
          response['body']['status'] == "200") {
        log('${response['body']}');
        return response['body'];
      } else if (response['body']['status'] == 500 ||
          response['body']['status'] == "500") {
        showErrorDialog(message: response['body']['message']);
        return response['body'];
      } else {
        showErrorDialog(message: response['body']['message']);
      }
    } else {
      if (dataStorage.read("token") != null) {
        showErrorDialog(message: response['error_description']);
      }
    }
  }

  void showErrorDialog({required String message}) {
    // due to missing context cannot convert to custom CommonMethod().showToast
    // CommonMethod().getXSnackBar("Error", message.toString(), red);
  }

  static logoutUser(final context,
      {moveToLoginScreen = false, loginScreenUsername = ''}) {
    // TODO: work on it. unable to run this part of code due to context issue.
    // but impolemented in home.
    // if (context != null) {
    //   HomeScreenController hct = GetPackage.Get.find<HomeScreenController>();
    //   hct.selectedMenu.value = 0;
    //   final ct = GetPackage.Get.find<CashController>();
    //   ct.isDrawerTotal.value = true;
    // }

    // clear all datastorage remove all except 2 keys
    clearDataStorageKeysExceptEssential();
    if (moveToLoginScreen) {
      // GetPackage.Get.offAll(
      //   () => LogInScreen(
      //     username: loginScreenUsername,
      //   ),
      // );
    } else {
      // GetPackage.Get.offAll(() => const LoginPickerScreen());
    }
  }
}
