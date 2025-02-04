// To parse this JSON data, do
//
//     final salesOrderModel = salesOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:highties_cannabis/components/common_methos.dart';

class SalesOrderModel {
  List<OrderData> data;

  SalesOrderModel({
    required this.data,
  });

  factory SalesOrderModel.fromRawJson(String str) =>
      SalesOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) =>
      SalesOrderModel(
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  String name;
  DateTime creation;
  DateTime modified;
  dynamic modifiedBy;
  dynamic owner;
  dynamic docstatus;
  dynamic parent;
  dynamic parentfield;
  dynamic parenttype;
  dynamic idx;
  dynamic title;
  dynamic namingSeries;
  dynamic customer;
  dynamic customerName;
  dynamic orderType;
  dynamic skipDeliveryNote;
  dynamic amendedFrom;
  dynamic company;
  DateTime transactionDate;
  DateTime deliveryDate;
  dynamic poNo;
  dynamic poDate;
  dynamic taxId;
  dynamic costCenter;
  dynamic project;
  dynamic customerAddress;
  dynamic addressDisplay;
  dynamic contactPerson;
  dynamic contactDisplay;
  dynamic contactPhone;
  dynamic contactMobile;
  dynamic contactEmail;
  dynamic companyAddress;
  dynamic companyAddressDisplay;
  dynamic shippingAddressName;
  dynamic shippingAddress;
  dynamic dispatchAddressName;
  dynamic dispatchAddress;
  dynamic customerGroup;
  dynamic territory;
  dynamic currency;
  dynamic conversionRate;
  dynamic sellingPriceList;
  dynamic priceListCurrency;
  dynamic plcConversionRate;
  dynamic ignorePricingRule;
  dynamic setWarehouse;
  dynamic scanBarcode;
  dynamic totalQty;
  dynamic baseTotal;
  dynamic baseNetTotal;
  dynamic totalNetWeight;
  dynamic total;
  dynamic netTotal;
  dynamic taxCategory;
  dynamic shippingRule;
  dynamic taxesAndCharges;
  dynamic otherChargesCalculation;
  dynamic baseTotalTaxesAndCharges;
  dynamic totalTaxesAndCharges;
  dynamic loyaltyPoints;
  dynamic loyaltyAmount;
  dynamic couponCode;
  dynamic applyDiscountOn;
  dynamic baseDiscountAmount;
  dynamic additionalDiscountPercentage;
  dynamic discountAmount;
  dynamic baseGrandTotal;
  dynamic baseRoundingAdjustment;
  dynamic baseRoundedTotal;
  dynamic baseInWords;
  dynamic grandTotal;
  dynamic roundingAdjustment;
  dynamic roundedTotal;
  dynamic inWords;
  dynamic advancePaid;
  dynamic disableRoundedTotal;
  dynamic paymentTermsTemplate;
  dynamic tcName;
  dynamic terms;
  dynamic isInternalCustomer;
  dynamic representsCompany;
  dynamic interCompanyOrderReference;
  dynamic? partyAccountCurrency;
  dynamic source;
  dynamic campaign;
  dynamic language;
  dynamic letterHead;
  dynamic selectPrintHeading;
  dynamic groupSameItems;
  dynamic status;
  dynamic deliveryStatus;
  dynamic markOrderStatus;
  dynamic perDelivered;
  dynamic perBilled;
  dynamic perPicked;
  dynamic billingStatus;
  dynamic salesPartner;
  dynamic amountEligibleForCommission;
  dynamic commissionRate;
  dynamic totalCommission;
  dynamic fromDate;
  dynamic toDate;
  dynamic autoRepeat;
  dynamic userTags;
  dynamic comments;
  dynamic assign;
  dynamic likedBy;
  dynamic seen;
  dynamic branch;

  OrderData({
    required this.name,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.owner,
    required this.docstatus,
    this.parent,
    this.parentfield,
    this.parenttype,
    required this.idx,
    required this.title,
    required this.namingSeries,
    required this.customer,
    required this.customerName,
    required this.orderType,
    required this.skipDeliveryNote,
    this.amendedFrom,
    required this.company,
    required this.transactionDate,
    required this.deliveryDate,
    this.poNo,
    this.poDate,
    this.taxId,
    this.costCenter,
    this.project,
    this.customerAddress,
    this.addressDisplay,
    this.contactPerson,
    this.contactDisplay,
    this.contactPhone,
    this.contactMobile,
    this.contactEmail,
    this.companyAddress,
    this.companyAddressDisplay,
    required this.shippingAddressName,
    this.shippingAddress,
    this.dispatchAddressName,
    this.dispatchAddress,
    required this.customerGroup,
    required this.territory,
    required this.currency,
    required this.conversionRate,
    required this.sellingPriceList,
    required this.priceListCurrency,
    required this.plcConversionRate,
    required this.ignorePricingRule,
    this.setWarehouse,
    this.scanBarcode,
    required this.totalQty,
    required this.baseTotal,
    required this.baseNetTotal,
    required this.totalNetWeight,
    required this.total,
    required this.netTotal,
    required this.taxCategory,
    this.shippingRule,
    this.taxesAndCharges,
    this.otherChargesCalculation,
    required this.baseTotalTaxesAndCharges,
    required this.totalTaxesAndCharges,
    required this.loyaltyPoints,
    required this.loyaltyAmount,
    this.couponCode,
    required this.applyDiscountOn,
    required this.baseDiscountAmount,
    required this.additionalDiscountPercentage,
    required this.discountAmount,
    required this.baseGrandTotal,
    required this.baseRoundingAdjustment,
    required this.baseRoundedTotal,
    required this.baseInWords,
    required this.grandTotal,
    required this.roundingAdjustment,
    required this.roundedTotal,
    required this.inWords,
    required this.advancePaid,
    required this.disableRoundedTotal,
    this.paymentTermsTemplate,
    this.tcName,
    this.terms,
    required this.isInternalCustomer,
    this.representsCompany,
    this.interCompanyOrderReference,
    this.partyAccountCurrency,
    this.source,
    this.campaign,
    required this.language,
    this.letterHead,
    this.selectPrintHeading,
    required this.groupSameItems,
    required this.status,
    required this.deliveryStatus,
    required this.markOrderStatus,
    required this.perDelivered,
    required this.perBilled,
    required this.perPicked,
    required this.billingStatus,
    this.salesPartner,
    required this.amountEligibleForCommission,
    required this.commissionRate,
    required this.totalCommission,
    this.fromDate,
    this.toDate,
    this.autoRepeat,
    this.userTags,
    this.comments,
    this.assign,
    this.likedBy,
    required this.seen,
    this.branch,
  });

  factory OrderData.fromRawJson(String str) =>
      OrderData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        name: json["name"],
        creation: DateTime.parse(json["creation"]),
        // creation: DateTime.parse("2024-01-24T00:00:00.000Z"),
        modified: DateTime.parse(json["updatedAt"]),
        modifiedBy: json["modified_by"] ?? '',
        owner: json["owner"] ?? '',
        docstatus: json["docstatus"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        title: json["title"],
        namingSeries: json["naming_series"] ?? '',
        customer: json["customer"],
        customerName: json["customer_name"],
        orderType: json["order_type"],
        skipDeliveryNote: json["skip_delivery_note"],
        amendedFrom: json["amended_from"],
        company: json["company"] ?? '',
        transactionDate:
            DateTime.parse(json["transaction_date"] ?? json['creation']),
        deliveryDate: DateTime.parse(json["delivery_date"] ?? json['creation']),
        poNo: json["po_no"],
        poDate: json["po_date"],
        taxId: json["tax_id"],
        costCenter: json["cost_center"],
        project: json["project"],
        customerAddress: json["customer_address"],
        addressDisplay: json["address_display"],
        contactPerson: json["contact_person"],
        contactDisplay: json["contact_display"],
        contactPhone: json["contact_phone"],
        contactMobile: json["contact_mobile"],
        contactEmail: json["contact_email"],
        companyAddress: json["company_address"],
        companyAddressDisplay: json["company_address_display"],
        shippingAddressName: json["shipping_address_name"] ?? '',
        shippingAddress: json["shipping_address"],
        dispatchAddressName: json["dispatch_address_name"],
        dispatchAddress: json["dispatch_address"],
        customerGroup: json["customer_group"] ?? '',
        territory: json["territory"] ?? '',
        currency: json["currency"] ?? '',
        conversionRate:
            CommonMethod().convertToDouble(json["conversion_rate"] ?? 0.0),
        sellingPriceList: json["selling_price_list"] ?? '0',
        priceListCurrency: json["price_list_currency"] ?? '',
        plcConversionRate:
            CommonMethod().convertToDouble(json["plc_conversion_rate"] ?? '0'),
        ignorePricingRule: json["ignore_pricing_rule"] ?? '',
        setWarehouse: json["set_warehouse"] ?? '',
        scanBarcode: json["scan_barcode"] ?? '',
        totalQty: CommonMethod().convertToDouble(json["total_qty"] ?? 0),
        baseTotal: CommonMethod().convertToDouble(json["base_total"] ?? 0),
        baseNetTotal:
            CommonMethod().convertToDouble(json["base_net_total"] ?? 0),
        totalNetWeight:
            CommonMethod().convertToDouble(json["total_net_weight"] ?? 0),
        total: CommonMethod().convertToDouble(json["total"] ?? 0),
        netTotal: CommonMethod().convertToDouble(json["net_total"] ?? 0),
        taxCategory: json["tax_category"],
        shippingRule: json["shipping_rule"],
        taxesAndCharges: json["taxes_and_charges"],
        otherChargesCalculation: json["other_charges_calculation"],
        baseTotalTaxesAndCharges: json["base_total_taxes_and_charges"],
        totalTaxesAndCharges: json["total_taxes_and_charges"],
        loyaltyPoints: json["loyalty_points"],
        loyaltyAmount: json["loyalty_amount"],
        couponCode: json["coupon_code"],
        applyDiscountOn: json["apply_discount_on"],
        baseDiscountAmount:
            CommonMethod().convertToDouble(json["base_discount_amount"] ?? '0'),
        additionalDiscountPercentage: CommonMethod()
            .convertToDouble(json["additional_discount_percentage"] ?? '0'),
        discountAmount:
            CommonMethod().convertToDouble(json["discount_amount"] ?? '0'),
        baseGrandTotal:
            CommonMethod().convertToDouble(json["base_grand_total"] ?? '0'),
        baseRoundingAdjustment: json["base_rounding_adjustment"],
        baseRoundedTotal:
            CommonMethod().convertToDouble(json["base_rounded_total"] ?? '0'),
        baseInWords:
            CommonMethod().convertToDouble(json["base_in_words"] ?? '0'),
        grandTotal: CommonMethod().convertToDouble(json["grand_total"] ?? '0'),
        roundingAdjustment:
            CommonMethod().convertToDouble(json["rounding_adjustment"] ?? '0'),
        roundedTotal: json["rounded_total"],
        inWords: json["in_words"],
        advancePaid: json["advance_paid"],
        disableRoundedTotal: json["disable_rounded_total"],
        paymentTermsTemplate: json["payment_terms_template"],
        tcName: json["tc_name"],
        terms: json["terms"],
        isInternalCustomer: json["is_internal_customer"],
        representsCompany: json["represents_company"],
        interCompanyOrderReference: json["inter_company_order_reference"],
        partyAccountCurrency: json["party_account_currency"],
        source: json["source"],
        campaign: json["campaign"],
        language: json["language"],
        letterHead: json["letter_head"],
        selectPrintHeading: json["select_print_heading"],
        groupSameItems: json["group_same_items"],
        status: json["status"],
        deliveryStatus: json["delivery_status"],
        markOrderStatus: json["mark_order_status"],
        perDelivered: json["per_delivered"],
        perBilled: json["per_billed"],
        perPicked: json["per_picked"],
        billingStatus: json["billing_status"],
        salesPartner: json["sales_partner"],
        amountEligibleForCommission: CommonMethod()
            .convertToDouble(json["amount_eligible_for_commission"] ?? 0),
        commissionRate: json["commission_rate"],
        totalCommission: json["total_commission"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        autoRepeat: json["auto_repeat"],
        userTags: json["_user_tags"],
        comments: json["_comments"],
        assign: json["_assign"],
        likedBy: json["_liked_by"],
        seen: json["_seen"],
        branch: json["branch"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "creation": creation.toIso8601String(),
        "modified": modified.toIso8601String(),
        "modified_by": modifiedBy,
        "owner": owner,
        "docstatus": docstatus,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "title": title,
        "naming_series": namingSeries,
        "customer": customer,
        "customer_name": customerName,
        "order_type": orderType,
        "skip_delivery_note": skipDeliveryNote,
        "amended_from": amendedFrom,
        "company": company,
        "transaction_date":
            "${transactionDate.year.toString().padLeft(4, '0')}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.day.toString().padLeft(2, '0')}",
        "delivery_date":
            "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "po_no": poNo,
        "po_date": poDate,
        "tax_id": taxId,
        "cost_center": costCenter,
        "project": project,
        "customer_address": customerAddress,
        "address_display": addressDisplay,
        "contact_person": contactPerson,
        "contact_display": contactDisplay,
        "contact_phone": contactPhone,
        "contact_mobile": contactMobile,
        "contact_email": contactEmail,
        "company_address": companyAddress,
        "company_address_display": companyAddressDisplay,
        "shipping_address_name": shippingAddressName,
        "shipping_address": shippingAddress,
        "dispatch_address_name": dispatchAddressName,
        "dispatch_address": dispatchAddress,
        "customer_group": customerGroup,
        "territory": territory,
        "currency": currency,
        "conversion_rate": conversionRate,
        "selling_price_list": sellingPriceList,
        "price_list_currency": priceListCurrency,
        "plc_conversion_rate": plcConversionRate,
        "ignore_pricing_rule": ignorePricingRule,
        "set_warehouse": setWarehouse,
        "scan_barcode": scanBarcode,
        "total_qty": totalQty,
        "base_total": baseTotal,
        "base_net_total": baseNetTotal,
        "total_net_weight": totalNetWeight,
        "total": total,
        "net_total": netTotal,
        "tax_category": taxCategory,
        "shipping_rule": shippingRule,
        "taxes_and_charges": taxesAndCharges,
        "other_charges_calculation": otherChargesCalculation,
        "base_total_taxes_and_charges": baseTotalTaxesAndCharges,
        "total_taxes_and_charges": totalTaxesAndCharges,
        "loyalty_points": loyaltyPoints,
        "loyalty_amount": loyaltyAmount,
        "coupon_code": couponCode,
        "apply_discount_on": applyDiscountOn,
        "base_discount_amount": baseDiscountAmount,
        "additional_discount_percentage": additionalDiscountPercentage,
        "discount_amount": discountAmount,
        "base_grand_total": baseGrandTotal,
        "base_rounding_adjustment": baseRoundingAdjustment,
        "base_rounded_total": baseRoundedTotal,
        "base_in_words": baseInWords,
        "grand_total": grandTotal,
        "rounding_adjustment": roundingAdjustment,
        "rounded_total": roundedTotal,
        "in_words": inWords,
        "advance_paid": advancePaid,
        "disable_rounded_total": disableRoundedTotal,
        "payment_terms_template": paymentTermsTemplate,
        "tc_name": tcName,
        "terms": terms,
        "is_internal_customer": isInternalCustomer,
        "represents_company": representsCompany,
        "inter_company_order_reference": interCompanyOrderReference,
        "party_account_currency": partyAccountCurrency,
        "source": source,
        "campaign": campaign,
        "language": language,
        "letter_head": letterHead,
        "select_print_heading": selectPrintHeading,
        "group_same_items": groupSameItems,
        "status": status,
        "delivery_status": deliveryStatus,
        "mark_order_status": markOrderStatus,
        "per_delivered": perDelivered,
        "per_billed": perBilled,
        "per_picked": perPicked,
        "billing_status": billingStatus,
        "sales_partner": salesPartner,
        "amount_eligible_for_commission": amountEligibleForCommission,
        "commission_rate": commissionRate,
        "total_commission": totalCommission,
        "from_date": fromDate,
        "to_date": toDate,
        "auto_repeat": autoRepeat,
        "_user_tags": userTags,
        "_comments": comments,
        "_assign": assign,
        "_liked_by": likedBy,
        "_seen": seen,
        "branch": branch,
      };
}
