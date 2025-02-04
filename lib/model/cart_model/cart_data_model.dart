// To parse this JSON data, do
//
//     final getAllCartDataModel = getAllCartDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:highties_cannabis/components/common_methos.dart';

GetAllCartDataModel getAllCartDataModelFromJson(String str) =>
    GetAllCartDataModel.fromJson(json.decode(str));

String getAllCartDataModelToJson(GetAllCartDataModel data) =>
    json.encode(data.toJson());

class GetAllCartDataModel {
  TotalCartData? data;

  GetAllCartDataModel({
    this.data,
  });

  factory GetAllCartDataModel.fromJson(Map<String, dynamic> json) =>
      GetAllCartDataModel(
        data:
            json["data"] == null ? null : TotalCartData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class TotalCartData {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? idx;
  num? docstatus;
  String? title;
  String? namingSeries;
  String? quotationTo;
  String? company;
  DateTime? transactionDate;
  String? orderType;
  String? customerGroup;
  String? territory;
  String? currency;
  num? conversionRate;
  String? sellingPriceList;
  String? priceListCurrency;
  num? plcConversionRate;
  num? ignorePricingRule;
  num? totalQty;
  double? baseTotal;
  num? baseNetTotal;
  num? total;
  num? netTotal;
  double totalNetWeight;
  num? baseTotalTaxesAndCharges;
  num? totalTaxesAndCharges;
  String? applyDiscountOn;
  num? baseDiscountAmount;
  num? additionalDiscountPercentage;
  double? discountAmount;
  num? baseGrandTotal;
  num? baseRoundingAdjustment;
  String? baseInWords;
  num? baseRoundedTotal;
  double? grandTotal;
  num? roundingAdjustment;
  num? roundedTotal;
  String? inWords;
  num? groupSameItems;
  String? status;
  String? doctype;
  List<ProductItem> items = [];
  List<dynamic>? packedItems;
  List<dynamic>? pricingRules;
  List<dynamic>? taxes;
  List<PaymentSchedule>? paymentSchedule;
  List<dynamic>? lostReasons;
  String? customer;
  String? customerName;
  String? markOrderStatus;

  TotalCartData({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.title,
    this.namingSeries,
    this.quotationTo,
    this.company,
    this.transactionDate,
    this.orderType,
    this.customerGroup,
    this.territory,
    this.currency,
    this.conversionRate,
    this.sellingPriceList,
    this.priceListCurrency,
    this.plcConversionRate,
    this.ignorePricingRule,
    this.totalQty,
    this.baseTotal,
    this.baseNetTotal,
    this.total,
    this.netTotal,
    required this.totalNetWeight,
    this.baseTotalTaxesAndCharges,
    this.totalTaxesAndCharges,
    this.applyDiscountOn,
    this.baseDiscountAmount,
    this.additionalDiscountPercentage,
    this.discountAmount,
    this.baseGrandTotal,
    this.baseRoundingAdjustment,
    this.baseInWords,
    this.baseRoundedTotal,
    this.grandTotal,
    this.roundingAdjustment,
    this.roundedTotal,
    this.inWords,
    this.groupSameItems,
    this.status,
    this.doctype,
    required this.items,
    this.packedItems,
    this.pricingRules,
    this.taxes,
    this.paymentSchedule,
    this.lostReasons,
    this.customer,
    this.customerName,
    this.markOrderStatus,
  });

  factory TotalCartData.fromJson(Map<String, dynamic> json) => TotalCartData(
        name: json["name"],
        owner: json["owner"],
        // its managed in frontend so just get it from sales controller.

        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        title: json["title"],
        namingSeries: json["naming_series"],
        quotationTo: json["quotation_to"],
        company: json["company"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        orderType: json["order_type"],
        customerGroup: json["customer_group"],
        territory: json["territory"],
        currency: json["currency"],
        conversionRate:
            CommonMethod().convertToDouble(json["conversion_rate"] ?? '0'),
        sellingPriceList: json["selling_price_list"],
        priceListCurrency: json["price_list_currency"],
        plcConversionRate:
            CommonMethod().convertToDouble(json["plc_conversion_rate"] ?? '0'),
        ignorePricingRule: json["ignore_pricing_rule"],
        totalQty: CommonMethod().convertToDouble(json["total_qty"] ?? '0'),
        baseTotal: CommonMethod().convertToDouble(json["base_total"] ?? 0),
        baseNetTotal:
            CommonMethod().convertToDouble(json["base_net_total"] ?? 0),
        total: CommonMethod().convertToDouble(json["total"] ?? 0),
        netTotal: CommonMethod().convertToDouble(json["net_total"] ?? 0),
        totalNetWeight:
            CommonMethod().convertToDouble(json["total_net_weight"] ?? 0.0),
        baseTotalTaxesAndCharges: CommonMethod()
            .convertToDouble(json["base_total_taxes_and_charges"] ?? 0),
        totalTaxesAndCharges: CommonMethod()
            .convertToDouble(json["total_taxes_and_charges"] ?? 0),
        applyDiscountOn: json["apply_discount_on"],
        baseDiscountAmount:
            CommonMethod().convertToDouble(json["base_discount_amount"] ?? 0),
        additionalDiscountPercentage: CommonMethod()
            .convertToDouble(json["additional_discount_percentage"] ?? '0'),
        discountAmount:
            CommonMethod().convertToDouble(json["discount_amount"] ?? '0'),
        baseGrandTotal:
            CommonMethod().convertToDouble(json["base_grand_total"] ?? '0'),
        baseRoundingAdjustment: CommonMethod()
            .convertToDouble(json["base_rounding_adjustment"] ?? '0'),
        baseInWords: json["base_in_words"],
        baseRoundedTotal:
            CommonMethod().convertToDouble(json["base_rounded_total"] ?? '0'),
        grandTotal: CommonMethod().convertToDouble(json["grand_total"] ?? '0'),
        roundingAdjustment:
            CommonMethod().convertToDouble(json["rounding_adjustment"] ?? 0),
        roundedTotal:
            CommonMethod().convertToDouble(json["rounded_total"] ?? 0),
        inWords: json["in_words"],
        groupSameItems: json["group_same_items"],
        status: json["status"],
        doctype: json["doctype"],
        items: json["items"] == null
            ? []
            : List<ProductItem>.from(
                json["items"]!.map((x) => ProductItem.fromJson(x))),
        packedItems: json["packed_items"] == null
            ? []
            : List<dynamic>.from(json["packed_items"]!.map((x) => x)),
        pricingRules: json["pricing_rules"] == null
            ? []
            : List<dynamic>.from(json["pricing_rules"]!.map((x) => x)),
        taxes: json["taxes"] == null
            ? []
            : List<dynamic>.from(json["taxes"]!.map((x) => x)),
        paymentSchedule: json["payment_schedule"] == null
            ? []
            : List<PaymentSchedule>.from(json["payment_schedule"]!
                .map((x) => PaymentSchedule.fromJson(x))),
        lostReasons: json["lost_reasons"] == null
            ? []
            : List<dynamic>.from(json["lost_reasons"]!.map((x) => x)),
        customer: json["customer"],
        customerName: json["customer_name"],
        markOrderStatus: json["mark_order_status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "title": title,
        "naming_series": namingSeries,
        "quotation_to": quotationTo,
        "company": company,
        "transaction_date": transactionDate == null
            ? null
            : "${transactionDate!.year.toString().padLeft(4, '0')}-${transactionDate!.month.toString().padLeft(2, '0')}-${transactionDate!.day.toString().padLeft(2, '0')}",
        "order_type": orderType,
        "customer_group": customerGroup,
        "territory": territory,
        "currency": currency,
        "conversion_rate": conversionRate,
        "selling_price_list": sellingPriceList,
        "price_list_currency": priceListCurrency,
        "plc_conversion_rate": plcConversionRate,
        "ignore_pricing_rule": ignorePricingRule,
        "total_qty": totalQty,
        "base_total": baseTotal,
        "base_net_total": baseNetTotal,
        "total": total,
        "net_total": netTotal,
        "total_net_weight": totalNetWeight,
        "base_total_taxes_and_charges": baseTotalTaxesAndCharges,
        "total_taxes_and_charges": totalTaxesAndCharges,
        "apply_discount_on": applyDiscountOn,
        "base_discount_amount": baseDiscountAmount,
        "additional_discount_percentage": additionalDiscountPercentage,
        "discount_amount": discountAmount,
        "base_grand_total": baseGrandTotal,
        "base_rounding_adjustment": baseRoundingAdjustment,
        "base_in_words": baseInWords,
        "base_rounded_total": baseRoundedTotal,
        "grand_total": grandTotal,
        "rounding_adjustment": roundingAdjustment,
        "rounded_total": roundedTotal,
        "in_words": inWords,
        "group_same_items": groupSameItems,
        "status": status,
        "doctype": doctype,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "packed_items": packedItems == null
            ? []
            : List<dynamic>.from(packedItems!.map((x) => x)),
        "pricing_rules": pricingRules == null
            ? []
            : List<dynamic>.from(pricingRules!.map((x) => x)),
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
        "payment_schedule": paymentSchedule == null
            ? []
            : List<dynamic>.from(paymentSchedule!.map((x) => x.toJson())),
        "lost_reasons": lostReasons == null
            ? []
            : List<dynamic>.from(lostReasons!.map((x) => x)),
        "customer": customer,
        "customer_name": customerName,
        "mark_order_status": markOrderStatus,
      };
}

class ProductItem {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  num? idx;
  num? docstatus;
  String? itemCode;
  String? batchNo;
  String? itemName;
  String? description;
  String? itemGroup;
  String? brand;
  String? image;
  double? qty;
  String? stockUom;
  String? uom;
  num? conversionFactor;
  num? stockQty;
  num? priceListRate;
  double? basePriceListRate;
  String? margnumype;
  num? marginRateOrAmount;
  num? rateWithMargin;
  num? discountPercentage;
  num? discountAmount;
  num? baseRateWithMargin;
  double? rate;
  num? netRate;
  double? amount;
  num? netAmount;
  num? baseRate;
  num? baseNetRate;
  double baseAmount;
  num? baseNetAmount;
  num? stockUomRate;
  num? isFreeItem;
  num? valuationRate;
  num? grossProfit;
  double? weightPerUnit;
  num? totalWeight;
  String? warehouse;
  num? againstBlanketOrder;
  num? blanketOrderRate;
  num? projectedQty;
  num? actualQty;
  String? itemTaxRate;
  num? pageBreak;
  String? doctype;
  double discount = 0.00;
  double? manualProductDiscount = 0.00;
  double? dialogDiscount = 0.00;
  double? overallDiscount = 0.00;
  DiscountData? discountData;
  String? discountType;
  String? totaldiscountType;
  String? catalogSku;

  ProductItem({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.itemCode,
    this.batchNo,
    this.itemName,
    this.description,
    this.itemGroup,
    this.brand,
    this.image,
    this.qty,
    this.stockUom,
    this.uom,
    this.conversionFactor,
    this.stockQty,
    this.priceListRate,
    this.basePriceListRate,
    this.margnumype,
    this.marginRateOrAmount,
    this.rateWithMargin,
    this.discountPercentage,
    this.discountAmount,
    this.baseRateWithMargin,
    this.rate,
    this.netRate,
    this.amount,
    this.netAmount,
    this.baseRate,
    this.baseNetRate,
    required this.baseAmount,
    this.baseNetAmount,
    this.stockUomRate,
    this.isFreeItem,
    this.valuationRate,
    this.grossProfit,
    this.weightPerUnit,
    this.totalWeight,
    this.warehouse,
    this.againstBlanketOrder,
    this.blanketOrderRate,
    this.projectedQty,
    this.actualQty,
    this.itemTaxRate,
    this.pageBreak,
    this.doctype,
    required this.discount,
    this.discountData,
    this.discountType,
    this.totaldiscountType,
    this.catalogSku,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        itemCode: json["item_code"],
        // batch no is managed in frontend, so read its read from sales controller
        batchNo: json["batch_no"],
        itemName: json["item_name"],
        description: json["description"],
        itemGroup: json["item_group"],
        brand: json["brand"],
        image: json["image"],
        qty: CommonMethod().convertToDouble(json["qty"] ?? 0),
        stockUom: json["stock_uom"],
        uom: json["uom"],
        conversionFactor: json["conversion_factor"],
        stockQty: CommonMethod().convertToDouble(json["stock_qty"] ?? 0),
        priceListRate:
            CommonMethod().convertToDouble(json["price_list_rate"] ?? 0),
        basePriceListRate:
            CommonMethod().convertToDouble(json["base_price_list_rate"] ?? 0),
        margnumype: json["margin_type"],
        marginRateOrAmount: json["margin_rate_or_amount"],
        rateWithMargin: json["rate_with_margin"] ?? 0,
        discountPercentage: json["discount_percentage"] ?? 0,
        discountAmount: json["discount_amount"] ?? 0,
        baseRateWithMargin: json["base_rate_with_margin"] ?? 0,
        rate: CommonMethod().convertToDouble(json["rate"] ?? 0),
        netRate: CommonMethod().convertToDouble(json["net_rate"] ?? 0),
        amount: CommonMethod().convertToDouble(json["amount"] ?? 0),
        netAmount: CommonMethod().convertToDouble(json["net_amount"] ?? 0),
        baseRate: CommonMethod().convertToDouble(json["base_rate"] ?? 0),
        baseNetRate: CommonMethod().convertToDouble(json["base_net_rate"] ?? 0),
        baseAmount: json["base_amount"] != null
            ? CommonMethod().convertToDouble(json["base_amount"] ?? 0)
            : 0.0,
        baseNetAmount:
            CommonMethod().convertToDouble(json["base_net_amount"] ?? 0),
        stockUomRate:
            CommonMethod().convertToDouble(json["stock_uom_rate"] ?? 0),
        isFreeItem: json["is_free_item"],

        valuationRate: json["valuation_rate"],
        grossProfit: json["gross_profit"],
        weightPerUnit:
            CommonMethod().convertToDouble(json["weight_per_unit"] ?? 0),
        totalWeight: CommonMethod().convertToDouble(json["total_weight"] ?? 0),
        warehouse: json["warehouse"],
        againstBlanketOrder: json["against_blanket_order"],
        blanketOrderRate: json["blanket_order_rate"],
        projectedQty: json["projected_qty"],
        actualQty: json["actual_qty"],
        itemTaxRate: json["item_tax_rate"],
        pageBreak: json["page_break"],
        doctype: json["doctype"],
        discount: json["discount"] ?? 0.00,
        discountData: json["discount"] == null
            ? json["discountData"] != null
                ? DiscountData.fromJson(json["discountData"])
                : null
            : null,
        discountType: json["discountType"],
        totaldiscountType: json["totaldiscountType"],
        catalogSku: json["catalog_sku"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "docstatus": docstatus,
        "item_code": itemCode,
        "item_name": itemName,
        "description": description,
        "item_group": itemGroup,
        "brand": brand,
        "image": image,
        "qty": qty,
        "stock_uom": stockUom,
        "uom": uom,
        "conversion_factor": conversionFactor,
        "stock_qty": stockQty,
        "price_list_rate": priceListRate,
        "base_price_list_rate": basePriceListRate,
        "margin_type": margnumype,
        "margin_rate_or_amount": marginRateOrAmount,
        "rate_with_margin": rateWithMargin,
        "discount_percentage": discountPercentage,
        "discount_amount": discountAmount,
        "base_rate_with_margin": baseRateWithMargin,
        "rate": rate,
        "net_rate": netRate,
        "amount": amount,
        "net_amount": netAmount,
        "base_rate": baseRate,
        "base_net_rate": baseNetRate,
        "base_amount": baseAmount,
        "base_net_amount": baseNetAmount,
        "stock_uom_rate": stockUomRate,
        "is_free_item": isFreeItem,
        "valuation_rate": valuationRate,
        "gross_profit": grossProfit,
        "weight_per_unit": weightPerUnit,
        "total_weight": totalWeight,
        "warehouse": warehouse,
        "against_blanket_order": againstBlanketOrder,
        "blanket_order_rate": blanketOrderRate,
        "projected_qty": projectedQty,
        "actual_qty": actualQty,
        "item_tax_rate": itemTaxRate,
        "page_break": pageBreak,
        "doctype": doctype,
        "discount": discount,
        "discountData": discountData != null ? discountData!.toJson() : null,
        "discountType": discountType,
        "totaldiscountType": totaldiscountType,
        "catalog_sku": catalogSku,
        'batch_no': batchNo,
      };

  static ProductItem products(ProductItem i) {
    return ProductItem(
      baseAmount: i.baseAmount,
      discountData: i.discountData,
      description: i.description,
      actualQty: i.actualQty,
      againstBlanketOrder: i.againstBlanketOrder,
      amount: i.amount,
      baseNetAmount: i.baseNetAmount,
      baseNetRate: i.baseNetRate,
      basePriceListRate: i.basePriceListRate,
      baseRate: i.baseRate,
      baseRateWithMargin: i.baseRateWithMargin,
      blanketOrderRate: i.blanketOrderRate,
      brand: i.brand,
      qty: i.qty,
      image: i.image,
      itemCode: i.itemCode,
      batchNo: i.batchNo,
      itemName: i.itemName,
      conversionFactor: i.conversionFactor,
      creation: i.creation,
      discountAmount: i.discountAmount,
      discountPercentage: i.discountPercentage,
      docstatus: i.docstatus,
      doctype: i.doctype,
      grossProfit: i.grossProfit,
      idx: i.idx,
      isFreeItem: i.isFreeItem,
      itemGroup: i.itemGroup,
      itemTaxRate: i.itemTaxRate,
      marginRateOrAmount: i.marginRateOrAmount,
      margnumype: i.margnumype,
      modified: i.modified,
      modifiedBy: i.modifiedBy,
      name: i.name,
      netAmount: i.netAmount,
      netRate: i.netRate,
      owner: i.owner,
      pageBreak: i.pageBreak,
      parent: i.parent,
      parentfield: i.parentfield,
      parenttype: i.parenttype,
      priceListRate: i.priceListRate,
      projectedQty: i.projectedQty,
      rate: i.rate,
      rateWithMargin: i.rateWithMargin,
      stockQty: i.stockQty,
      stockUom: i.stockUom,
      stockUomRate: i.stockUomRate,
      totalWeight: i.totalWeight,
      uom: i.uom,
      valuationRate: i.valuationRate,
      warehouse: i.warehouse,
      weightPerUnit: i.weightPerUnit,
      discount: i.discount,
      discountType: i.discountType,
      totaldiscountType: i.totaldiscountType,
      catalogSku: i.catalogSku,
    );
  }
}

// To parse this JSON data, do
//
//     final paymentSchedule = paymentScheduleFromJson(jsonString);

class PaymentSchedule {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  int? docstatus;
  dynamic paymentTerm;
  dynamic description;
  DateTime? dueDate;
  dynamic modeOfPayment;
  double? invoicePortion;
  dynamic discountType;
  dynamic discountDate;
  double? discount;
  double? paymentAmount;
  double? outstanding;
  double? paidAmount;
  double? discountedAmount;
  double? basePaymentAmount;
  String? doctype;

  PaymentSchedule({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.paymentTerm,
    this.description,
    this.dueDate,
    this.modeOfPayment,
    this.invoicePortion,
    this.discountType,
    this.discountDate,
    this.discount,
    this.paymentAmount,
    this.outstanding,
    this.paidAmount,
    this.discountedAmount,
    this.basePaymentAmount,
    this.doctype,
  });

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) =>
      PaymentSchedule(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        paymentTerm: json["payment_term"],
        description: json["description"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        modeOfPayment: json["mode_of_payment"],
        invoicePortion: json["invoice_portion"],
        discountType: json["discount_type"],
        discountDate: json["discount_date"],
        discount: json["discount"],
        paymentAmount: json["payment_amount"],
        outstanding: json["outstanding"],
        paidAmount: json["paid_amount"],
        discountedAmount: json["discounted_amount"],
        basePaymentAmount: json["base_payment_amount"],
        doctype: json["doctype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "docstatus": docstatus,
        "payment_term": paymentTerm,
        "description": description,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "mode_of_payment": modeOfPayment,
        "invoice_portion": invoicePortion,
        "discount_type": discountType,
        "discount_date": discountDate,
        "discount": discount,
        "payment_amount": paymentAmount,
        "outstanding": outstanding,
        "paid_amount": paidAmount,
        "discounted_amount": discountedAmount,
        "base_payment_amount": basePaymentAmount,
        "doctype": doctype,
      };
}

class DiscountData {
  String? itemCode;
  dynamic basePrice;
  dynamic discountBasePrice;
  double? subtotal;
  double? invoiceDiscount;
  double? totalTax;
  double? finalTotal;
  String? cartName;
  String? createdAt;
  String? cartId;

  DiscountData({
    this.itemCode,
    this.basePrice,
    this.discountBasePrice,
    this.subtotal,
    this.invoiceDiscount,
    this.totalTax,
    this.finalTotal,
    this.cartName,
    this.createdAt,
    this.cartId,
  });

  factory DiscountData.fromJson(Map<String, dynamic> json) => DiscountData(
        itemCode: json["itemCode"],
        basePrice: json["basePrice"],
        discountBasePrice: json["discountBasePrice"],
        subtotal: json["subtotal"],
        invoiceDiscount: json["invoiceDiscount"],
        totalTax: json["totalTax"],
        finalTotal: json["finalTotal"],
        cartName: json["cartName"],
        createdAt: json["createdAt"],
        cartId: json["cartId"],
      );

  Map<String, dynamic> toJson() => {
        "itemCode": itemCode,
        "basePrice": basePrice,
        "discountBasePrice": discountBasePrice,
        "subtotal": subtotal,
        "invoiceDiscount": invoiceDiscount,
        "totalTax": totalTax,
        "finalTotal": finalTotal,
        "cartName": cartName,
        "createdAt": createdAt,
        "cartId": cartId,
      };
}
