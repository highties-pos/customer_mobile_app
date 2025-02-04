// To parse this JSON data, do
//
//     final salesOrderDetailModel = salesOrderDetailModelFromJson(jsonString);

import 'dart:convert';

SalesOrderDetailModel salesOrderDetailModelFromJson(String str) =>
    SalesOrderDetailModel.fromJson(json.decode(str));

String salesOrderDetailModelToJson(SalesOrderDetailModel data) =>
    json.encode(data.toJson());

class SalesOrderDetailModel {
  SalesOrderData? data;

  SalesOrderDetailModel({
    this.data,
  });

  factory SalesOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      SalesOrderDetailModel(
        data:
            json["data"] == null ? null : SalesOrderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class SalesOrderData {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? title;
  String? namingSeries;
  String? customer;
  String? customerName;
  String? orderType;
  int? skipDeliveryNote;
  String? company;
  DateTime? transactionDate;
  DateTime? deliveryDate;
  String? contactPerson;
  String? contactDisplay;
  String? contactMobile;
  String? contactEmail;
  String? shippingAddressName;
  String? customerGroup;
  String? territory;
  String? currency;
  double? conversionRate;
  String? sellingPriceList;
  String? priceListCurrency;
  double? plcConversionRate;
  int? ignorePricingRule;
  double? totalQty;
  double? baseTotal;
  double? baseNetTotal;
  double? totalNetWeight;
  double? total;
  double? netTotal;
  String? taxCategory;
  double? baseTotalTaxesAndCharges;
  double? totalTaxesAndCharges;
  int? loyaltyPoints;
  double? loyaltyAmount;
  String? applyDiscountOn;
  double? baseDiscountAmount;
  double? additionalDiscountPercentage;
  double? discountAmount;
  double? baseGrandTotal;
  double? baseRoundingAdjustment;
  double? baseRoundedTotal;
  String? baseInWords;
  double? grandTotal;
  double? roundingAdjustment;
  double? roundedTotal;
  String? inWords;
  double? advancePaid;
  int? disableRoundedTotal;
  int? isInternalCustomer;
  String? language;
  int? groupSameItems;
  String? status;
  String? deliveryStatus;
  double? perDelivered;
  double? perBilled;
  double? perPicked;
  String? billingStatus;
  double? amountEligibleForCommission;
  double? commissionRate;
  double? totalCommission;
  String? doctype;
  List<SalesOrderItems>? items;
  List<dynamic>? packedItems;
  List<dynamic>? pricingRules;
  List<dynamic>? taxes;
  List<PaymentScheduleData>? paymentSchedule;
  List<dynamic>? salesTeam;

  SalesOrderData({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.title,
    this.namingSeries,
    this.customer,
    this.customerName,
    this.orderType,
    this.skipDeliveryNote,
    this.company,
    this.transactionDate,
    this.deliveryDate,
    this.contactPerson,
    this.contactDisplay,
    this.contactMobile,
    this.contactEmail,
    this.shippingAddressName,
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
    this.totalNetWeight,
    this.total,
    this.netTotal,
    this.taxCategory,
    this.baseTotalTaxesAndCharges,
    this.totalTaxesAndCharges,
    this.loyaltyPoints,
    this.loyaltyAmount,
    this.applyDiscountOn,
    this.baseDiscountAmount,
    this.additionalDiscountPercentage,
    this.discountAmount,
    this.baseGrandTotal,
    this.baseRoundingAdjustment,
    this.baseRoundedTotal,
    this.baseInWords,
    this.grandTotal,
    this.roundingAdjustment,
    this.roundedTotal,
    this.inWords,
    this.advancePaid,
    this.disableRoundedTotal,
    this.isInternalCustomer,
    this.language,
    this.groupSameItems,
    this.status,
    this.deliveryStatus,
    this.perDelivered,
    this.perBilled,
    this.perPicked,
    this.billingStatus,
    this.amountEligibleForCommission,
    this.commissionRate,
    this.totalCommission,
    this.doctype,
    this.items,
    this.packedItems,
    this.pricingRules,
    this.taxes,
    this.paymentSchedule,
    this.salesTeam,
  });

  factory SalesOrderData.fromJson(Map<String, dynamic> json) => SalesOrderData(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        title: json["title"],
        namingSeries: json["naming_series"],
        customer: json["customer"],
        customerName: json["customer_name"],
        orderType: json["order_type"],
        skipDeliveryNote: json["skip_delivery_note"],
        company: json["company"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        contactPerson: json["contact_person"],
        contactDisplay: json["contact_display"],
        contactMobile: json["contact_mobile"],
        contactEmail: json["contact_email"],
        shippingAddressName: json["shipping_address_name"],
        customerGroup: json["customer_group"],
        territory: json["territory"],
        currency: json["currency"],
        conversionRate: json["conversion_rate"],
        sellingPriceList: json["selling_price_list"],
        priceListCurrency: json["price_list_currency"],
        plcConversionRate: json["plc_conversion_rate"],
        ignorePricingRule: json["ignore_pricing_rule"],
        totalQty: json["total_qty"],
        baseTotal: json["base_total"]?.toDouble(),
        baseNetTotal: json["base_net_total"]?.toDouble(),
        totalNetWeight: json["total_net_weight"],
        total: json["total"]?.toDouble(),
        netTotal: json["net_total"]?.toDouble(),
        taxCategory: json["tax_category"],
        baseTotalTaxesAndCharges: json["base_total_taxes_and_charges"],
        totalTaxesAndCharges: json["total_taxes_and_charges"],
        loyaltyPoints: json["loyalty_points"],
        loyaltyAmount: json["loyalty_amount"],
        applyDiscountOn: json["apply_discount_on"],
        baseDiscountAmount: json["base_discount_amount"],
        additionalDiscountPercentage: json["additional_discount_percentage"],
        discountAmount: json["discount_amount"],
        baseGrandTotal: json["base_grand_total"]?.toDouble(),
        baseRoundingAdjustment: json["base_rounding_adjustment"]?.toDouble(),
        baseRoundedTotal: json["base_rounded_total"],
        baseInWords: json["base_in_words"],
        grandTotal: json["grand_total"]?.toDouble(),
        roundingAdjustment: json["rounding_adjustment"]?.toDouble(),
        roundedTotal: json["rounded_total"],
        inWords: json["in_words"],
        advancePaid: json["advance_paid"],
        disableRoundedTotal: json["disable_rounded_total"],
        isInternalCustomer: json["is_internal_customer"],
        language: json["language"],
        groupSameItems: json["group_same_items"],
        status: json["status"],
        deliveryStatus: json["delivery_status"],
        perDelivered: json["per_delivered"],
        perBilled: json["per_billed"],
        perPicked: json["per_picked"],
        billingStatus: json["billing_status"],
        amountEligibleForCommission:
            json["amount_eligible_for_commission"]?.toDouble(),
        commissionRate: json["commission_rate"],
        totalCommission: json["total_commission"],
        doctype: json["doctype"],
        items: json["items"] == null
            ? []
            : List<SalesOrderItems>.from(
                json["items"]!.map((x) => SalesOrderItems.fromJson(x))),
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
            : List<PaymentScheduleData>.from(json["payment_schedule"]!
                .map((x) => PaymentScheduleData.fromJson(x))),
        salesTeam: json["sales_team"] == null
            ? []
            : List<dynamic>.from(json["sales_team"]!.map((x) => x)),
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
        "customer": customer,
        "customer_name": customerName,
        "order_type": orderType,
        "skip_delivery_note": skipDeliveryNote,
        "company": company,
        "transaction_date":
            "${transactionDate!.year.toString().padLeft(4, '0')}-${transactionDate!.month.toString().padLeft(2, '0')}-${transactionDate!.day.toString().padLeft(2, '0')}",
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "contact_person": contactPerson,
        "contact_display": contactDisplay,
        "contact_mobile": contactMobile,
        "contact_email": contactEmail,
        "shipping_address_name": shippingAddressName,
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
        "total_net_weight": totalNetWeight,
        "total": total,
        "net_total": netTotal,
        "tax_category": taxCategory,
        "base_total_taxes_and_charges": baseTotalTaxesAndCharges,
        "total_taxes_and_charges": totalTaxesAndCharges,
        "loyalty_points": loyaltyPoints,
        "loyalty_amount": loyaltyAmount,
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
        "is_internal_customer": isInternalCustomer,
        "language": language,
        "group_same_items": groupSameItems,
        "status": status,
        "delivery_status": deliveryStatus,
        "per_delivered": perDelivered,
        "per_billed": perBilled,
        "per_picked": perPicked,
        "billing_status": billingStatus,
        "amount_eligible_for_commission": amountEligibleForCommission,
        "commission_rate": commissionRate,
        "total_commission": totalCommission,
        "doctype": doctype,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
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
        "sales_team": salesTeam == null
            ? []
            : List<dynamic>.from(salesTeam!.map((x) => x)),
      };
}

class SalesOrderItems {
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
  String? itemCode;
  int? ensureDeliveryBasedOnProducedSerialNo;
  DateTime? deliveryDate;
  String? itemName;
  String? description;
  String? itemGroup;
  String? image;
  double? qty;
  String? stockUom;
  double? pickedQty;
  String? uom;
  double? conversionFactor;
  double? stockQty;
  double? priceListRate;
  double? basePriceListRate;
  String? marginType;
  double? marginRateOrAmount;
  double? rateWithMargin;
  double? discountPercentage;
  double? discountAmount;
  double? baseRateWithMargin;
  double? rate;
  double? amount;
  String? itemTaxTemplate;
  double? baseRate;
  double? baseAmount;
  double? stockUomRate;
  int? isFreeItem;
  int? grantCommission;
  double? netRate;
  double? netAmount;
  double? baseNetRate;
  double? baseNetAmount;
  double? billedAmt;
  double? valuationRate;
  double? grossProfit;
  int? deliveredBySupplier;
  double? weightPerUnit;
  double? totalWeight;
  String? warehouse;
  String? prevdocDocname;
  int? againstBlanketOrder;
  double? blanketOrderRate;
  double? projectedQty;
  double? actualQty;
  double? orderedQty;
  double? plannedQty;
  double? workOrderQty;
  double? producedQty;
  double? deliveredQty;
  double? returnedQty;
  int? pageBreak;
  String? itemTaxRate;
  DateTime? transactionDate;
  String? catalogSku;
  String? doctype;

  SalesOrderItems({
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
    this.ensureDeliveryBasedOnProducedSerialNo,
    this.deliveryDate,
    this.itemName,
    this.description,
    this.itemGroup,
    this.image,
    this.qty,
    this.stockUom,
    this.pickedQty,
    this.uom,
    this.conversionFactor,
    this.stockQty,
    this.priceListRate,
    this.basePriceListRate,
    this.marginType,
    this.marginRateOrAmount,
    this.rateWithMargin,
    this.discountPercentage,
    this.discountAmount,
    this.baseRateWithMargin,
    this.rate,
    this.amount,
    this.itemTaxTemplate,
    this.baseRate,
    this.baseAmount,
    this.stockUomRate,
    this.isFreeItem,
    this.grantCommission,
    this.netRate,
    this.netAmount,
    this.baseNetRate,
    this.baseNetAmount,
    this.billedAmt,
    this.valuationRate,
    this.grossProfit,
    this.deliveredBySupplier,
    this.weightPerUnit,
    this.totalWeight,
    this.warehouse,
    this.prevdocDocname,
    this.againstBlanketOrder,
    this.blanketOrderRate,
    this.projectedQty,
    this.actualQty,
    this.orderedQty,
    this.plannedQty,
    this.workOrderQty,
    this.producedQty,
    this.deliveredQty,
    this.returnedQty,
    this.pageBreak,
    this.itemTaxRate,
    this.transactionDate,
    this.catalogSku,
    this.doctype,
  });

  factory SalesOrderItems.fromJson(Map<String, dynamic> json) =>
      SalesOrderItems(
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
        ensureDeliveryBasedOnProducedSerialNo:
            json["ensure_delivery_based_on_produced_serial_no"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        itemName: json["item_name"],
        description: json["description"],
        itemGroup: json["item_group"],
        image: json["image"],
        qty: json["qty"],
        stockUom: json["stock_uom"],
        pickedQty: json["picked_qty"],
        uom: json["uom"],
        conversionFactor: json["conversion_factor"],
        stockQty: json["stock_qty"],
        priceListRate: json["price_list_rate"]?.toDouble(),
        basePriceListRate: json["base_price_list_rate"]?.toDouble(),
        marginType: json["margin_type"],
        marginRateOrAmount: json["margin_rate_or_amount"],
        rateWithMargin: json["rate_with_margin"],
        discountPercentage: json["discount_percentage"],
        discountAmount: json["discount_amount"],
        baseRateWithMargin: json["base_rate_with_margin"],
        rate: json["rate"]?.toDouble(),
        amount: json["amount"]?.toDouble(),
        itemTaxTemplate: json["item_tax_template"],
        baseRate: json["base_rate"]?.toDouble(),
        baseAmount: json["base_amount"]?.toDouble(),
        stockUomRate: json["stock_uom_rate"]?.toDouble(),
        isFreeItem: json["is_free_item"],
        grantCommission: json["grant_commission"],
        netRate: json["net_rate"]?.toDouble(),
        netAmount: json["net_amount"]?.toDouble(),
        baseNetRate: json["base_net_rate"]?.toDouble(),
        baseNetAmount: json["base_net_amount"]?.toDouble(),
        billedAmt: json["billed_amt"],
        valuationRate: json["valuation_rate"],
        grossProfit: json["gross_profit"]?.toDouble(),
        deliveredBySupplier: json["delivered_by_supplier"],
        weightPerUnit: json["weight_per_unit"],
        totalWeight: json["total_weight"],
        warehouse: json["warehouse"],
        prevdocDocname: json["prevdoc_docname"],
        againstBlanketOrder: json["against_blanket_order"],
        blanketOrderRate: json["blanket_order_rate"],
        projectedQty: json["projected_qty"],
        actualQty: json["actual_qty"],
        orderedQty: json["ordered_qty"],
        plannedQty: json["planned_qty"],
        workOrderQty: json["work_order_qty"],
        producedQty: json["produced_qty"],
        deliveredQty: json["delivered_qty"],
        returnedQty: json["returned_qty"],
        pageBreak: json["page_break"],
        itemTaxRate: json["item_tax_rate"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        catalogSku: json["catalog_sku"],
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
        "item_code": itemCode,
        "ensure_delivery_based_on_produced_serial_no":
            ensureDeliveryBasedOnProducedSerialNo,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "item_name": itemName,
        "description": description,
        "item_group": itemGroup,
        "image": image,
        "qty": qty,
        "stock_uom": stockUom,
        "picked_qty": pickedQty,
        "uom": uom,
        "conversion_factor": conversionFactor,
        "stock_qty": stockQty,
        "price_list_rate": priceListRate,
        "base_price_list_rate": basePriceListRate,
        "margin_type": marginType,
        "margin_rate_or_amount": marginRateOrAmount,
        "rate_with_margin": rateWithMargin,
        "discount_percentage": discountPercentage,
        "discount_amount": discountAmount,
        "base_rate_with_margin": baseRateWithMargin,
        "rate": rate,
        "amount": amount,
        "item_tax_template": itemTaxTemplate,
        "base_rate": baseRate,
        "base_amount": baseAmount,
        "stock_uom_rate": stockUomRate,
        "is_free_item": isFreeItem,
        "grant_commission": grantCommission,
        "net_rate": netRate,
        "net_amount": netAmount,
        "base_net_rate": baseNetRate,
        "base_net_amount": baseNetAmount,
        "billed_amt": billedAmt,
        "valuation_rate": valuationRate,
        "gross_profit": grossProfit,
        "delivered_by_supplier": deliveredBySupplier,
        "weight_per_unit": weightPerUnit,
        "total_weight": totalWeight,
        "warehouse": warehouse,
        "prevdoc_docname": prevdocDocname,
        "against_blanket_order": againstBlanketOrder,
        "blanket_order_rate": blanketOrderRate,
        "projected_qty": projectedQty,
        "actual_qty": actualQty,
        "ordered_qty": orderedQty,
        "planned_qty": plannedQty,
        "work_order_qty": workOrderQty,
        "produced_qty": producedQty,
        "delivered_qty": deliveredQty,
        "returned_qty": returnedQty,
        "page_break": pageBreak,
        "item_tax_rate": itemTaxRate,
        "transaction_date":
            "${transactionDate!.year.toString().padLeft(4, '0')}-${transactionDate!.month.toString().padLeft(2, '0')}-${transactionDate!.day.toString().padLeft(2, '0')}",
        "catalog_sku": catalogSku,
        "doctype": doctype,
      };
}

class PaymentScheduleData {
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
  DateTime? dueDate;
  double? invoicePortion;
  String? discountType;
  double? discount;
  double? paymentAmount;
  double? outstanding;
  double? paidAmount;
  double? discountedAmount;
  double? basePaymentAmount;
  String? doctype;

  PaymentScheduleData({
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
    this.dueDate,
    this.invoicePortion,
    this.discountType,
    this.discount,
    this.paymentAmount,
    this.outstanding,
    this.paidAmount,
    this.discountedAmount,
    this.basePaymentAmount,
    this.doctype,
  });

  factory PaymentScheduleData.fromJson(Map<String, dynamic> json) =>
      PaymentScheduleData(
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
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        invoicePortion: json["invoice_portion"],
        discountType: json["discount_type"],
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
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "invoice_portion": invoicePortion,
        "discount_type": discountType,
        "discount": discount,
        "payment_amount": paymentAmount,
        "outstanding": outstanding,
        "paid_amount": paidAmount,
        "discounted_amount": discountedAmount,
        "base_payment_amount": basePaymentAmount,
        "doctype": doctype,
      };
}
