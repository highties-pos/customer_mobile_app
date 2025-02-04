class ApiAppConstants {
  // static String apiEndPoint = "http://3.97.254.80/api/";
  static String apiEndPoint = "http://3.96.170.126:4000/api/";
  static String apiRootUrl = "http://3.96.170.126:4000";
  static String apiProtocol = "http";
  static String apiHost = "3.97.254.80";

  // Authentication
  // static const String login =
  //     "http://3.97.254.80/api/method/highties.highties.custom.mobile.login?login_id=${administrator}&password=admin@2022";

  // todo: later replace all urls properly
  static String login() {
    return "${apiEndPoint}auth/login";
  }

  static String getItemsByName({
    String? itemType,
    int? pageCount,
    String? itemName,
    String? itemCode,
  }) {
    return "http://3.97.254.80/api/method/highties.highties.custom.mobile.get_product_details?item_group=$itemType&page_length=$pageCount&item_name=$itemName&item_code=";
  }

  static String getItemsDetail({String? itemCode}) {
    return "${apiEndPoint}items/mobile-app?item_code=$itemCode";
    return "http://3.97.254.80/api/method/highties.highties.custom.mobile.get_item_details?item_code=$itemCode";
  }

  static String createNewCustomer({
    String? itemCode,
    String? customerName,
    String? lastName,
    String? customerNo,
    String? customerEmail,
    String? customerDOB,
  }) {
    return "http://3.97.254.80/api/method/highties.highties.custom.mobile.set_customer?first_name=$customerName&last_name=$lastName&mobile_no=$customerNo&email_id=$customerEmail&date_of_birth=$customerDOB";
  }

  static String getCustomers({
    String? customersName,
  }) {
    return "http://3.97.254.80/api/method/highties.highties.custom.mobile.get_customer";
  }

  static String getUserCart({
    String? quotationid,
  }) {
    return "http://3.97.254.80/api/resource/Quotation/$quotationid";
  }

  // static String updateCart() {
  //   return "http://3.97.254.80/api/resource/Quotation/";
  // }

  //fonts
  static const String barlow = 'barlow';
  static const String getSaleItems =
      'method/highties.highties.custom.mobile.get_product_details';
  static const String getAllCustomerbySearch = 'customers';
  // old api don't use !!!
  // 'method/highties.highties.custom.mobile.search_customer';
  // new api
  // 'method/highties.highties.custom.mobile.customer_list';
  static const String getAllCustomer = 'resource/Customer';
  static const String getAllItemsGroup = 'resource/Item Group';
  static const String createCart = 'resource/Quotation';
  static const String deleteCart = 'resource/Quotation/';
  static const String updateCart = 'resource/Quotation/';
  static const String getStore = 'warehouses';
  static const String mobileListItems =
      'method/highties.highties.custom.mobile.list_items';
  static const String mobileListProducts =
      'method/highties.highties.custom.mobile.list_product';
  static const String getType =
      'method/highties.highties.custom.mobile.get_item_groups';
  // static const String getType =
  //     'method/highties.highties.custom.mobile.get_item_types';
  static const String getTaperene =
      'method/highties.highties.custom.mobile.get_item_terpenes';
  static const String getWeight =
      'method/highties.highties.custom.mobile.get_item_weights';
  static const String getFilterOptions = 'items/filter-options';
  // static const String getType = 'resource/Item%20Type';
  // static const String getTaperene = 'resource/Taperene';
  // static const String getWeight = 'resource/Item%20Weight';
  static const String safeDrawers = 'safe-drawers';
  static const String openPOSProfile = 'safe-drawers/cash-in';
  static const String closePOSProfile = 'resource/POS Closing Entry';
  static const String getBatchNumbers = 'resource/Batch';
  static const String getItemGrams = 'resource/Item/';
  static const String filterItem = 'resource/Item';
  static const String getCustomerByID = 'customers/';
  static const String createInvoice = 'invoices';
  static const String getPOSInvoice = 'resource/POS Invoice';
  // static const String getPOSInvoiceDetail = 'resource/POS Invoice';
  static const String getPOSInvoiceDetail = 'invoices';
  static const String createsalesOrder = 'sales-orders';
  // 'method/highties.highties.custom.mobile.create_so_from_quote';
  static const String getsalesOrder = 'sales-orders';
  // static const String getsalesOrderDetails = 'resource/Sales Order/';
  static const String getsalesOrderDetails = 'sales-orders';
  // 'method/highties.highties.custom.mobile.get_sales_order_with_custom_fields';
  static const String updateSalesOrderStatus = 'sales-orders/';
  static const String updateSalesOrder = 'sales-orders/';
  static const String updateQuotation = 'resource/Quotation/';
  static const String getProductStock = 'method/frappe.desk.query_report.run';
  static const String getCustomerbySearch =
      'method/frappe.desk.search.search_link';
  static const String skipConfirmAndTender =
      'method/highties.highties.custom.mobile.confirm_and_tender_so';
  static const String deleteSalesOrder = 'sales-orders';
  static const String customerGroups = 'customer-groups/groups-for-mobile';
  static const String chartDiscount =
      'resource/Promotional Scheme/ChartDiscount';
  static const String getSalesInvoiceList = "resource/Sales Invoice";
  static const String salesInvoiceCreateFromCart = "resource/Sales Invoice";
  static const String salesInvoiceCreateFromSavedOrder =
      "method/highties.highties.custom.mobile.create_invoice";

  // static const String getCustomers =
  //     'http://3.97.254.80/api/method/highties.highties.custom.mobile.get_customer';

// payment gateway related.
  static const String payfirmaOauthToken =
      "https://auth.payfirma.com/oauth/token";
  static const String payfirmaCreateSale =
      'https://apigateway.payfirma.com/transaction-service/sale';

  // web pos apis (used after oct 19th 2023)
  static const String webPosSearchLink =
      "method/frappe.desk.search.search_link";
  static const String openDrawerEntryDetails = "method/frappe.client.get";

  static const String webPosGetItemsList = "items/mobile-app";

  static const String webPosInvoicesOfDrawer =
      "method/erpnext.accounts.doctype.pos_closing_entry.pos_closing_entry.get_pos_invoices";

  static const String webPosSaveDocs = "method/frappe.desk.form.save.savedocs";
  static const String webPosReportView = "method/frappe.desk.reportview.get";
  static const String invoiceListErp = "invoices";
}
