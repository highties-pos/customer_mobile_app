import 'dart:developer';
import 'package:intl/intl.dart';

import '../../components/export.dart';
import '../../components/common_methos.dart';
import 'package:get/get.dart' as GetPackage;
import '../../model/customer/get_all_store_model.dart';
import 'package:dio/src/form_data.dart' as fd;

WebPosNetworkRepository networkRepository = WebPosNetworkRepository();

class WebPosNetworkRepository {
  static final WebPosNetworkRepository _networkRepository =
      WebPosNetworkRepository._internal();
  static final dataStorage = GetStorage();

  factory WebPosNetworkRepository() {
    return _networkRepository;
  }

  WebPosNetworkRepository._internal();

  static Future getItemsList(
    context, {
    start = 0,
    limit = 100,
    itemGroup = null,
    searchTerm = "",
    posProfile = "TENTHLINE_D1",
    sortBy = '',
    thc = '',
    cbd = '',
    weights = '',
    terpenes = '',
    strains = '',
  }) async {
    try {
      print(itemGroup);
      itemGroup =
          itemGroup == null || itemGroup == '' ? "All Items" : itemGroup;
      var priceList = "Standard Selling";

      var savedWareHouse = getSavedWareHouse();
      var baseItemUrl =
          '${ApiAppConstants.apiEndPoint}${ApiAppConstants.webPosGetItemsList}';

      var basicSearch =
          'warehouse_id=${savedWareHouse?['id'] ?? ''}&limit=$limit&start=$start&item_group=$itemGroup&search=$searchTerm&sort_by=$sortBy';
      var filterSearch =
          'thc=$thc&cbd=$cbd&weights=$weights&terpenes=$terpenes&strains=$strains';

      var url = '$baseItemUrl?$basicSearch&$filterSearch';
      log('url for item search $url');
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            // todo: pass item group $itemGroup
            url,
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

  static Future gteAllAItemsGroup(context) async {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${ApiAppConstants.apiEndPoint}'
            'item-groups',
        // '${ApiAppConstants.apiEndPoint}${ApiAppConstants.webPosSearchLink}?doctype=Item Group&query=erpnext.selling.page.point_of_sale.point_of_sale.item_group_query&filters={"pos_profile":""}&page_length=90&txt=',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      if (response['statusCode'] == 200) {}
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

  static Future getAllGovtIds(context) async {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: '${ApiAppConstants.apiEndPoint}'
            'govt-ids',
        // '${ApiAppConstants.apiEndPoint}${ApiAppConstants.webPosSearchLink}?doctype=Item Group&query=erpnext.selling.page.point_of_sale.point_of_sale.item_group_query&filters={"pos_profile":""}&page_length=90&txt=',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      if (response['statusCode'] == 200) {}
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

  static Future getAllCustomerGroups(context) async {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
    try {
      var jsonData = {
        "txt": "",
        "doctype": "Customer Group",
        "ignore_user_permissions": "0",
        "reference_doctype": "Customer",
        "is_group": "0",
        "filters": "{\"is_group\":0}",
      };
      log('json data is ${jsonData}');
      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        data: FormData.fromMap(jsonData),
        url:
            '${ApiAppConstants.apiEndPoint}${ApiAppConstants.webPosSearchLink}',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      if (response['statusCode'] == 200) {
        // sort by name and store in data.
        var data = response["body"]['results'].toList();
      }
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

  static Future getPosProfileList(context) async {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
    try {
      var savedWareHouse = getSavedWareHouse();

      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            // '${ApiAppConstants.apiEndPoint}${ApiAppConstants.webPosSearchLink}?doctype=POS Profile&query=erpnext.accounts.doctype.pos_profile.pos_profile.pos_profile_query&filters={"company":"HighTies Cannabis Store"}&txt=&reference_doctype=',
            '${ApiAppConstants.apiEndPoint}${ApiAppConstants.safeDrawers}?warehouseId=${savedWareHouse?['id']}',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      //
      // if (response['statusCode'] == 200) {
      //   // sort by name and store in data.
      //   response["body"]['data'] = response["body"]['results'];
      // }
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

  static Future getDrawers(context,
      {required posProfileName, status = ''}) async {
    NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url:
            '${ApiAppConstants.apiEndPoint}${ApiAppConstants.safeDrawers}?parent=$posProfileName&isOpen=${status ?? ''}',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
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

  static Future openDrawerEntry(
    context, {
    required posProfileName,
    cashAmount = 0,
    creditCardAmount = 0,
    giftCardAmount = 0,
  }) async {
    try {
      // safeDrawerId
      var currentDateFormats = CommonMethod().currentDateFormats();
      print('received posprpofile name');
      print(posProfileName);
      print(posProfileName.runtimeType);
      var mobileAmountData = {
        'cashAmount': cashAmount,
        'creditCardAmount': creditCardAmount,
        'giftCardAmount': giftCardAmount,
      };
      print('mobileAmountData is $mobileAmountData');
      var data = {
        "safeDrawerId": posProfileName.runtimeType == String
            ? posProfileName
            : posProfileName['safeDrawerId'],
        "mobileAmountData": mobileAmountData,
      };

      print('data to open drawer is ${jsonEncode(data)}');
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

  static Future fetchInvoicesOfDrawer(
    context, {
    startDate,
    posProfileName,
  }) async {
    try {
      var currentDateFormats = CommonMethod().currentDateFormats();

      var jsonData = {
        "pos_profile": posProfileName,
        "start": startDate,
        "end": currentDateFormats['date'],
        "user": getUsername(),
      };

      log('the json data for mapping is');
      log(jsonEncode(jsonData));

      var response = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        data: FormData.fromMap(jsonData),
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.webPosInvoicesOfDrawer,
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

  static Future getOpenDrawerEntryDetails(
    context, {
    openingEntryName,
  }) async {
    try {
      var response = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.openDrawerEntryDetails +
            '?doctype=POS+Opening+Entry&name=$openingEntryName',
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

  static Future closeDrawerEntry(
    context, {
    data,
  }) async {
    try {
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: data,
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.closePOSProfile,
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

  //! CREATE NEW CUSTOMER
  createNewCustomer(context, {data}) async {
    // log("\x1B[32m CREATE NEW CUSTOMER} \x1B[0m");
    log("\x1B[32m CREATE NEW CUSTOMER URL 777 $data \x1B[0m");

    try {
      var formDataJson = {
        "doc": jsonEncode(data),
        "action": "Save",
        // doc: {
        //   docstatus: 0,
        //   doctype: "Customer",
        //   name: "new-customer-1",
        //   __islocal: 1,
        //   __unsaved: 1,
        //   owner: "cms@highties.ca",
        //   naming_series: "CUST-.YYYY.-",
        //   medical_patient: "No",
        //   customer_type: "Company",
        //   gst_category: "Unregistered",
        //   export_type: "",
        //   allow_marketing: "Yes",
        //   temporary_medical_license: "Yes",
        //   so_required: 0,
        //   dn_required: 0,
        //   disabled: 0,
        //   is_internal_customer: 0,
        //   language: "en-GB",
        //   is_frozen: 0,
        //   represents_company: "",
        //   customer_name: "Baraja+Swargiary",
        //   first_name: "Baraja",
        //   last_name: "Swargiary",
        //   date_of_birth: "2000-01-18",
        //   customer_group: "Student",
        //   territory: "Canada",
        // },
      };

      // log('the form data is ${jsonEncode(formDataJson)}');
      var formData = FormData.fromMap(formDataJson);

      var response = await NetworkDioHttp.postDioHttpMethod(
        data: formData,
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.webPosSaveDocs,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      debugPrint('\x1b[99m CREATE NEW CUSTOMER : $response');

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

  //! CREATE NEW CUSTOMER
  getPosInvoiceList(context,
      {start, limit, searchText, startDate, endDate}) async {
    // log("\x1B[32m CREATE NEW CUSTOMER} \x1B[0m");
    try {
      var filterCode = !searchText.isEmpty
          ? '["POS Invoice","name","like","%${searchText}%"],'
          : '';

      var dateFilter = !startDate.isEmpty &&
              !endDate.isEmpty &&
              startDate != 'null' &&
              endDate != 'null'
          ? '["POS Invoice","posting_date","Between",["${startDate}","${endDate}"]],'
          : !startDate.isEmpty && startDate != 'null'
              ? '["POS Invoice","posting_date",">=","${startDate}"],'
              : !endDate.isEmpty && endDate != 'null'
                  ? '["POS Invoice","posting_date","<=","${endDate}"],'
                  : '';

      var filters =
          '[${dateFilter}${filterCode}["POS Invoice","company","=","HighTies Cannabis Store"]]';

      log('the filters for invoice search is ${filters}');
      var formDataJson = {
        "doctype": "POS Invoice",
        "fields":
            '["`tabPOS Invoice`.`name`","`tabPOS Invoice`.`total_qty`","`tabPOS Invoice`.`posting_date`","`tabPOS Invoice`.`owner`","`tabPOS Invoice`.`creation`","`tabPOS Invoice`.`modified`","`tabPOS Invoice`.`modified_by`","`tabPOS Invoice`.`_user_tags`","`tabPOS Invoice`.`_comments`","`tabPOS Invoice`.`_assign`","`tabPOS Invoice`.`_liked_by`","`tabPOS Invoice`.`docstatus`","`tabPOS Invoice`.`parent`","`tabPOS Invoice`.`parenttype`","`tabPOS Invoice`.`parentfield`","`tabPOS Invoice`.`idx`","`tabPOS Invoice`.`total`","`tabPOS Invoice`.`net_total`","`tabPOS Invoice`.`total_taxes_and_charges`","`tabPOS Invoice`.`discount_amount`","`tabPOS Invoice`.`grand_total`","`tabPOS Invoice`.`rounding_adjustment`","`tabPOS Invoice`.`rounded_total`","`tabPOS Invoice`.`total_advance`","`tabPOS Invoice`.`outstanding_amount`","`tabPOS Invoice`.`paid_amount`","`tabPOS Invoice`.`change_amount`","`tabPOS Invoice`.`write_off_amount`","`tabPOS Invoice`.`status`","`tabPOS Invoice`.`title`","`tabPOS Invoice`.`customer`","`tabPOS Invoice`.`customer_name`","`tabPOS Invoice`.`base_grand_total`","`tabPOS Invoice`.`due_date`","`tabPOS Invoice`.`company`","`tabPOS Invoice`.`currency`","`tabPOS Invoice`.`is_return`","`tabPOS Invoice`.`_seen`","`tabPOS Invoice`.`party_account_currency`"]',
        "filters": filters,
        "order_by": "`tabPOS Invoice`.`modified` desc",
        "start": start,
        "page_length": limit,
        "view": "List",
        "group_by": "`tabPOS Invoice`.`name`",
        "with_comment_count": true
      };

      // log('the form data is ${jsonEncode(formDataJson)}');
      var formData = FormData.fromMap(formDataJson);
      var response = await NetworkDioHttp.getDioHttpMethod(
        data: formData,
        context: context,
        url: ApiAppConstants.apiEndPoint +
            ApiAppConstants.invoiceListErp +
            '?warehouse=${getSavedWareHouse()?['name']}&start=$start&limit=$limit&search=$searchText&start_date=${startDate != '' ? startDate.substring(0, 10) : ''}&end_date=${endDate != '' ? endDate.substring(0, 10) : ''}',
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );
      return response['body']['result'];
    } catch (e, st) {
      CommonMethod().showToast(
        context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
    }
  }

  //! CREATE NEW CUSTOMER
  getPosInvoiceListOld(context,
      {start, limit, searchText, startDate, endDate}) async {
    // log("\x1B[32m CREATE NEW CUSTOMER} \x1B[0m");
    try {
      var filterCode = !searchText.isEmpty
          ? '["POS Invoice","name","like","%${searchText}%"],'
          : '';

      var dateFilter = !startDate.isEmpty &&
              !endDate.isEmpty &&
              startDate != 'null' &&
              endDate != 'null'
          ? '["POS Invoice","posting_date","Between",["${startDate}","${endDate}"]],'
          : !startDate.isEmpty && startDate != 'null'
              ? '["POS Invoice","posting_date",">=","${startDate}"],'
              : !endDate.isEmpty && endDate != 'null'
                  ? '["POS Invoice","posting_date","<=","${endDate}"],'
                  : '';

      var filters =
          '[${dateFilter}${filterCode}["POS Invoice","company","=","HighTies Cannabis Store"]]';

      log('the filters for invoice search is ${filters}');
      var formDataJson = {
        "doctype": "POS Invoice",
        "fields":
            '["`tabPOS Invoice`.`name`","`tabPOS Invoice`.`total_qty`","`tabPOS Invoice`.`posting_date`","`tabPOS Invoice`.`owner`","`tabPOS Invoice`.`creation`","`tabPOS Invoice`.`modified`","`tabPOS Invoice`.`modified_by`","`tabPOS Invoice`.`_user_tags`","`tabPOS Invoice`.`_comments`","`tabPOS Invoice`.`_assign`","`tabPOS Invoice`.`_liked_by`","`tabPOS Invoice`.`docstatus`","`tabPOS Invoice`.`parent`","`tabPOS Invoice`.`parenttype`","`tabPOS Invoice`.`parentfield`","`tabPOS Invoice`.`idx`","`tabPOS Invoice`.`total`","`tabPOS Invoice`.`net_total`","`tabPOS Invoice`.`total_taxes_and_charges`","`tabPOS Invoice`.`discount_amount`","`tabPOS Invoice`.`grand_total`","`tabPOS Invoice`.`rounding_adjustment`","`tabPOS Invoice`.`rounded_total`","`tabPOS Invoice`.`total_advance`","`tabPOS Invoice`.`outstanding_amount`","`tabPOS Invoice`.`paid_amount`","`tabPOS Invoice`.`change_amount`","`tabPOS Invoice`.`write_off_amount`","`tabPOS Invoice`.`status`","`tabPOS Invoice`.`title`","`tabPOS Invoice`.`customer`","`tabPOS Invoice`.`customer_name`","`tabPOS Invoice`.`base_grand_total`","`tabPOS Invoice`.`due_date`","`tabPOS Invoice`.`company`","`tabPOS Invoice`.`currency`","`tabPOS Invoice`.`is_return`","`tabPOS Invoice`.`_seen`","`tabPOS Invoice`.`party_account_currency`"]',
        "filters": filters,
        "order_by": "`tabPOS Invoice`.`modified` desc",
        "start": start,
        "page_length": limit,
        "view": "List",
        "group_by": "`tabPOS Invoice`.`name`",
        "with_comment_count": true
      };

      // log('the form data is ${jsonEncode(formDataJson)}');
      var formData = FormData.fromMap(formDataJson);
      var response = await NetworkDioHttp.postDioHttpMethod(
        data: formData,
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.webPosReportView,
        header: Options(
          headers: {
            'Cookie':
                'full_name=${dataStorage.read("fname")}; sid=${dataStorage.read("sid")}; system_user=yes; user_id=${dataStorage.read("uid")}; user_image=',
            "Authorization": dataStorages.read("token"),
          },
        ),
      );

      // log('body response outoutp');
      // log(jsonEncode(response['body']));
      var keys = [];
      var values = [];
      try {
        keys = response["body"]["message"]['keys'];
        values = response["body"]["message"]['values'];
      } catch (err) {}

      // format items
      dynamic invoices = [];
      for (var value in values) {
        var i = 0;
        Map itemObj = {};
        for (var key in keys) {
          itemObj[key] = value[i];
          i++;
        }
        invoices.add(itemObj);
      }
      return invoices;
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
}
