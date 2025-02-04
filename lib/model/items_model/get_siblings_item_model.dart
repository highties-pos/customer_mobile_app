// To parse this JSON data, do
//
//     final getItemsGramsModel = getItemsGramsModelFromJson(jsonString);

import 'dart:convert';

GetItemsGramsModel getItemsGramsModelFromJson(String str) =>
    GetItemsGramsModel.fromJson(json.decode(str));

String getItemsGramsModelToJson(GetItemsGramsModel data) =>
    json.encode(data.toJson());

class GetItemsGramsModel {
  ItemSiblingsData? data;

  GetItemsGramsModel({
    this.data,
  });

  factory GetItemsGramsModel.fromJson(Map<String, dynamic> json) =>
      GetItemsGramsModel(
        data: json["data"] == null
            ? null
            : ItemSiblingsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ItemSiblingsData {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? idx;
  num? docstatus;
  String? namingSeries;
  String? itemCode;
  String? itemName;
  String? itemGroup;
  num? isNilExempt;
  num? isNonGst;
  num? isItemFromHub;
  String? stockUom;
  num? balanceQty;
  num? disabled;
  num? allowAlternativeItem;
  num? isStockItem;
  num? includeItemInManufacturing;
  num? openingStock;
  num? valuationRate;
  num? standardRate;
  num? isFixedAsset;
  num? autoCreateAssets;
  num? overDeliveryReceiptAllowance;
  num? overBillingAllowance;
  String? image;
  String? description;
  num? shelfLifeInDays;
  DateTime? endOfLife;
  String? defaultMaterialRequestType;
  String? valuationMethod;
  double? weightPerUnit;
  num? hasBatchNo;
  num? createNewBatch;
  num? hasExpiryDate;
  num? retainSample;
  num? sampleQuantity;
  num? hasSerialNo;
  num? hasVariants;
  String? variantBasedOn;
  num? isPurchaseItem;
  num? minOrderQty;
  num? safetyStock;
  num? leadTimeDays;
  num? lastPurchaseRate;
  num? isCustomerProvidedItem;
  num? deliveredBySupplier;
  num? isSalesItem;
  num? grantCommission;
  num? maxDiscount;
  num? enableDeferredRevenue;
  num? noOfMonths;
  num? enableDeferredExpense;
  num? noOfMonthsExp;
  num? inspectionRequiredBeforePurchase;
  num? inspectionRequiredBeforeDelivery;
  num? isSubContractedItem;
  String? customerCode;
  num? publishInHub;
  num? syncedWithHub;
  num? publishedInWebsite;
  num? totalProjectedQty;
  String? shortDescription;
  String? heroShotUri;
  String? curated;
  String? hasColorSwatch;
  String? vendorSku;
  String? manufacturerSku;
  String? upc;
  String? retailMarijuanaProductTypeCanada;
  String? strain;
  String? healthCanadaReportingCategory;
  String? equivalentTo;
  String? terpenes;
  String? thcMin;
  String? cbdMin;
  String? hasTieredPricing;
  String? hasShelfPricing;
  String? groupId;
  String? nonStock;
  num? thcMinimum;
  String? brand1;
  String? thcMax;
  num? sellingPrice;
  String? catalogSku;
  String? batchTracking;
  String? cbdMax;
  String? hasGroupPricing;
  String? productStatus;
  String? doctype;
  List<dynamic>? itemVariants;
  List<dynamic>? barcodes;
  List<dynamic>? reorderLevels;
  List<ItemDefault>? uoms;
  List<dynamic>? attributes;
  List<ItemDefault>? itemDefaults;
  List<dynamic>? supplierItems;
  List<dynamic>? customerItems;
  List<ItemDefault>? taxes;

  ItemSiblingsData({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.namingSeries,
    this.itemCode,
    this.itemName,
    this.itemGroup,
    this.isNilExempt,
    this.isNonGst,
    this.isItemFromHub,
    this.stockUom,
    this.balanceQty,
    this.disabled,
    this.allowAlternativeItem,
    this.isStockItem,
    this.includeItemInManufacturing,
    this.openingStock,
    this.valuationRate,
    this.standardRate,
    this.isFixedAsset,
    this.autoCreateAssets,
    this.overDeliveryReceiptAllowance,
    this.overBillingAllowance,
    this.image,
    this.description,
    this.shelfLifeInDays,
    this.endOfLife,
    this.defaultMaterialRequestType,
    this.valuationMethod,
    this.weightPerUnit,
    this.hasBatchNo,
    this.createNewBatch,
    this.hasExpiryDate,
    this.retainSample,
    this.sampleQuantity,
    this.hasSerialNo,
    this.hasVariants,
    this.variantBasedOn,
    this.isPurchaseItem,
    this.minOrderQty,
    this.safetyStock,
    this.leadTimeDays,
    this.lastPurchaseRate,
    this.isCustomerProvidedItem,
    this.deliveredBySupplier,
    this.isSalesItem,
    this.grantCommission,
    this.maxDiscount,
    this.enableDeferredRevenue,
    this.noOfMonths,
    this.enableDeferredExpense,
    this.noOfMonthsExp,
    this.inspectionRequiredBeforePurchase,
    this.inspectionRequiredBeforeDelivery,
    this.isSubContractedItem,
    this.customerCode,
    this.publishInHub,
    this.syncedWithHub,
    this.publishedInWebsite,
    this.totalProjectedQty,
    this.shortDescription,
    this.heroShotUri,
    this.curated,
    this.hasColorSwatch,
    this.vendorSku,
    this.manufacturerSku,
    this.upc,
    this.retailMarijuanaProductTypeCanada,
    this.strain,
    this.healthCanadaReportingCategory,
    this.equivalentTo,
    this.terpenes,
    this.thcMin,
    this.cbdMin,
    this.hasTieredPricing,
    this.hasShelfPricing,
    this.groupId,
    this.nonStock,
    this.thcMinimum,
    this.brand1,
    this.thcMax,
    this.sellingPrice,
    this.catalogSku,
    this.batchTracking,
    this.cbdMax,
    this.hasGroupPricing,
    this.productStatus,
    this.doctype,
    this.itemVariants,
    this.barcodes,
    this.reorderLevels,
    this.uoms,
    this.attributes,
    this.itemDefaults,
    this.supplierItems,
    this.customerItems,
    this.taxes,
  });

  factory ItemSiblingsData.fromJson(Map<String, dynamic> json) =>
      ItemSiblingsData(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        namingSeries: json["naming_series"],
        itemCode: json["item_code"],
        itemName: json["item_name"],
        itemGroup: json["item_group"],
        isNilExempt: json["is_nil_exempt"],
        isNonGst: json["is_non_gst"],
        isItemFromHub: json["is_item_from_hub"],
        stockUom: json["stock_uom"],
        balanceQty: json["balance_qty"],
        disabled: json["disabled"],
        allowAlternativeItem: json["allow_alternative_item"],
        isStockItem: json["is_stock_item"],
        includeItemInManufacturing: json["include_item_in_manufacturing"],
        openingStock: json["opening_stock"],
        valuationRate: json["valuation_rate"],
        standardRate: json["standard_rate"],
        isFixedAsset: json["is_fixed_asset"],
        autoCreateAssets: json["auto_create_assets"],
        overDeliveryReceiptAllowance: json["over_delivery_receipt_allowance"],
        overBillingAllowance: json["over_billing_allowance"],
        image: json["image"],
        description: json["description"],
        shelfLifeInDays: json["shelf_life_in_days"],
        endOfLife: json["end_of_life"] == null
            ? null
            : DateTime.parse(json["end_of_life"]),
        defaultMaterialRequestType: json["default_material_request_type"],
        valuationMethod: json["valuation_method"],
        weightPerUnit: json["weight_per_unit"],
        hasBatchNo: json["has_batch_no"],
        createNewBatch: json["create_new_batch"],
        hasExpiryDate: json["has_expiry_date"],
        retainSample: json["retain_sample"],
        sampleQuantity: json["sample_quantity"],
        hasSerialNo: json["has_serial_no"],
        hasVariants: json["has_variants"],
        variantBasedOn: json["variant_based_on"],
        isPurchaseItem: json["is_purchase_item"],
        minOrderQty: json["min_order_qty"],
        safetyStock: json["safety_stock"],
        leadTimeDays: json["lead_time_days"],
        lastPurchaseRate: json["last_purchase_rate"],
        isCustomerProvidedItem: json["is_customer_provided_item"],
        deliveredBySupplier: json["delivered_by_supplier"],
        isSalesItem: json["is_sales_item"],
        grantCommission: json["grant_commission"],
        maxDiscount: json["max_discount"],
        enableDeferredRevenue: json["enable_deferred_revenue"],
        noOfMonths: json["no_of_months"],
        enableDeferredExpense: json["enable_deferred_expense"],
        noOfMonthsExp: json["no_of_months_exp"],
        inspectionRequiredBeforePurchase:
            json["inspection_required_before_purchase"],
        inspectionRequiredBeforeDelivery:
            json["inspection_required_before_delivery"],
        isSubContractedItem: json["is_sub_contracted_item"],
        customerCode: json["customer_code"],
        publishInHub: json["publish_in_hub"],
        syncedWithHub: json["synced_with_hub"],
        publishedInWebsite: json["published_in_website"],
        totalProjectedQty: json["total_projected_qty"],
        shortDescription: json["short_description"],
        heroShotUri: json["hero_shot_uri"],
        curated: json["curated"],
        hasColorSwatch: json["has_color_swatch"],
        vendorSku: json["vendor_sku"],
        manufacturerSku: json["manufacturer_sku"],
        upc: json["upc"],
        retailMarijuanaProductTypeCanada:
            json["retail_marijuana_product_type__canada"],
        strain: json["strain"],
        healthCanadaReportingCategory: json["health_canada_reporting_category"],
        equivalentTo: json["equivalent_to"],
        terpenes: json["terpenes"],
        thcMin: json["thc_min"],
        cbdMin: json["cbd_min"],
        hasTieredPricing: json["has_tiered_pricing"],
        hasShelfPricing: json["has_shelf_pricing"],
        groupId: json["group_id"],
        nonStock: json["non_stock"],
        thcMinimum: json["thc_minimum"],
        brand1: json["brand1"],
        thcMax: json["thc_max"],
        sellingPrice: json["selling_price"],
        catalogSku: json["catalog_sku"],
        batchTracking: json["batch_tracking"],
        cbdMax: json["cbd_max"],
        hasGroupPricing: json["has_group_pricing"],
        productStatus: json["product_status"],
        doctype: json["doctype"],
        itemVariants: json["item_variants"] == null
            ? []
            : List<dynamic>.from(json["item_variants"]!.map((x) => x)),
        barcodes: json["barcodes"] == null
            ? []
            : List<dynamic>.from(json["barcodes"]!.map((x) => x)),
        reorderLevels: json["reorder_levels"] == null
            ? []
            : List<dynamic>.from(json["reorder_levels"]!.map((x) => x)),
        uoms: json["uoms"] == null
            ? []
            : List<ItemDefault>.from(
                json["uoms"]!.map((x) => ItemDefault.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        itemDefaults: json["item_defaults"] == null
            ? []
            : List<ItemDefault>.from(
                json["item_defaults"]!.map((x) => ItemDefault.fromJson(x))),
        supplierItems: json["supplier_items"] == null
            ? []
            : List<dynamic>.from(json["supplier_items"]!.map((x) => x)),
        customerItems: json["customer_items"] == null
            ? []
            : List<dynamic>.from(json["customer_items"]!.map((x) => x)),
        taxes: json["taxes"] == null
            ? []
            : List<ItemDefault>.from(
                json["taxes"]!.map((x) => ItemDefault.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "naming_series": namingSeries,
        "item_code": itemCode,
        "item_name": itemName,
        "item_group": itemGroup,
        "is_nil_exempt": isNilExempt,
        "is_non_gst": isNonGst,
        "is_item_from_hub": isItemFromHub,
        "stock_uom": stockUom,
        "balance_qty": balanceQty,
        "disabled": disabled,
        "allow_alternative_item": allowAlternativeItem,
        "is_stock_item": isStockItem,
        "include_item_in_manufacturing": includeItemInManufacturing,
        "opening_stock": openingStock,
        "valuation_rate": valuationRate,
        "standard_rate": standardRate,
        "is_fixed_asset": isFixedAsset,
        "auto_create_assets": autoCreateAssets,
        "over_delivery_receipt_allowance": overDeliveryReceiptAllowance,
        "over_billing_allowance": overBillingAllowance,
        "image": image,
        "description": description,
        "shelf_life_in_days": shelfLifeInDays,
        "end_of_life":
            "${endOfLife!.year.toString().padLeft(4, '0')}-${endOfLife!.month.toString().padLeft(2, '0')}-${endOfLife!.day.toString().padLeft(2, '0')}",
        "default_material_request_type": defaultMaterialRequestType,
        "valuation_method": valuationMethod,
        "weight_per_unit": weightPerUnit,
        "has_batch_no": hasBatchNo,
        "create_new_batch": createNewBatch,
        "has_expiry_date": hasExpiryDate,
        "retain_sample": retainSample,
        "sample_quantity": sampleQuantity,
        "has_serial_no": hasSerialNo,
        "has_variants": hasVariants,
        "variant_based_on": variantBasedOn,
        "is_purchase_item": isPurchaseItem,
        "min_order_qty": minOrderQty,
        "safety_stock": safetyStock,
        "lead_time_days": leadTimeDays,
        "last_purchase_rate": lastPurchaseRate,
        "is_customer_provided_item": isCustomerProvidedItem,
        "delivered_by_supplier": deliveredBySupplier,
        "is_sales_item": isSalesItem,
        "grant_commission": grantCommission,
        "max_discount": maxDiscount,
        "enable_deferred_revenue": enableDeferredRevenue,
        "no_of_months": noOfMonths,
        "enable_deferred_expense": enableDeferredExpense,
        "no_of_months_exp": noOfMonthsExp,
        "inspection_required_before_purchase": inspectionRequiredBeforePurchase,
        "inspection_required_before_delivery": inspectionRequiredBeforeDelivery,
        "is_sub_contracted_item": isSubContractedItem,
        "customer_code": customerCode,
        "publish_in_hub": publishInHub,
        "synced_with_hub": syncedWithHub,
        "published_in_website": publishedInWebsite,
        "total_projected_qty": totalProjectedQty,
        "short_description": shortDescription,
        "hero_shot_uri": heroShotUri,
        "curated": curated,
        "has_color_swatch": hasColorSwatch,
        "vendor_sku": vendorSku,
        "manufacturer_sku": manufacturerSku,
        "upc": upc,
        "retail_marijuana_product_type__canada":
            retailMarijuanaProductTypeCanada,
        "strain": strain,
        "health_canada_reporting_category": healthCanadaReportingCategory,
        "equivalent_to": equivalentTo,
        "terpenes": terpenes,
        "thc_min": thcMin,
        "cbd_min": cbdMin,
        "has_tiered_pricing": hasTieredPricing,
        "has_shelf_pricing": hasShelfPricing,
        "group_id": groupId,
        "non_stock": nonStock,
        "thc_minimum": thcMinimum,
        "brand1": brand1,
        "thc_max": thcMax,
        "selling_price": sellingPrice,
        "catalog_sku": catalogSku,
        "batch_tracking": batchTracking,
        "cbd_max": cbdMax,
        "has_group_pricing": hasGroupPricing,
        "product_status": productStatus,
        "doctype": doctype,
        "item_variants": itemVariants == null
            ? []
            : List<dynamic>.from(itemVariants!.map((x) => x)),
        "barcodes":
            barcodes == null ? [] : List<dynamic>.from(barcodes!.map((x) => x)),
        "reorder_levels": reorderLevels == null
            ? []
            : List<dynamic>.from(reorderLevels!.map((x) => x)),
        "uoms": uoms == null
            ? []
            : List<dynamic>.from(uoms!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
        "item_defaults": itemDefaults == null
            ? []
            : List<dynamic>.from(itemDefaults!.map((x) => x.toJson())),
        "supplier_items": supplierItems == null
            ? []
            : List<dynamic>.from(supplierItems!.map((x) => x)),
        "customer_items": customerItems == null
            ? []
            : List<dynamic>.from(customerItems!.map((x) => x)),
        "taxes": taxes == null
            ? []
            : List<dynamic>.from(taxes!.map((x) => x.toJson())),
      };
}

class ItemDefault {
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
  String? company;
  String? defaultWarehouse;
  String? doctype;
  String? itemTaxTemplate;
  num? minimumNetRate;
  num? maximumNetRate;
  String? uom;
  num? conversionFactor;

  ItemDefault({
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
    this.company,
    this.defaultWarehouse,
    this.doctype,
    this.itemTaxTemplate,
    this.minimumNetRate,
    this.maximumNetRate,
    this.uom,
    this.conversionFactor,
  });

  factory ItemDefault.fromJson(Map<String, dynamic> json) => ItemDefault(
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
        company: json["company"],
        defaultWarehouse: json["default_warehouse"],
        doctype: json["doctype"],
        itemTaxTemplate: json["item_tax_template"],
        minimumNetRate: json["minimum_net_rate"],
        maximumNetRate: json["maximum_net_rate"],
        uom: json["uom"],
        conversionFactor: json["conversion_factor"],
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
        "company": company,
        "default_warehouse": defaultWarehouse,
        "doctype": doctype,
        "item_tax_template": itemTaxTemplate,
        "minimum_net_rate": minimumNetRate,
        "maximum_net_rate": maximumNetRate,
        "uom": uom,
        "conversion_factor": conversionFactor,
      };
}
