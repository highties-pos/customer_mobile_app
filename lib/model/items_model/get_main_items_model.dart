// To parse this JSON data, do
//
//     final mainItemsModel = mainItemsModelFromJson(jsonString);

import 'dart:convert';

MainItemsModel mainItemsModelFromJson(String str) =>
    MainItemsModel.fromJson(json.decode(str));

String mainItemsModelToJson(MainItemsModel data) => json.encode(data.toJson());

class MainItemsModel {
  List<MainItemData>? data;

  MainItemsModel({
    this.data,
  });

  factory MainItemsModel.fromJson(Map<String, dynamic> json) => MainItemsModel(
        data: json["data"] == null && json["message"] == null
            ? []
            : json["data"] == null
                ? List<MainItemData>.from(
                    json["message"]!.map((x) => MainItemData.fromJson(x)))
                : List<MainItemData>.from(
                    json["data"]!.map((x) => MainItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MainItemData {
  String? name;
  num? stockQty;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? owner;
  num? docstatus;
  dynamic parent;
  dynamic parentfield;
  dynamic parenttype;
  num? idx;
  String? namingSeries;
  String? itemCode;
  dynamic variantOf;
  String? itemName;
  String? itemGroup;
  num? isItemFromHub;
  String? stockUom;
  num? disabled;
  num? allowAlternativeItem;
  num? isStockItem;
  num? includeItemInManufacturing;
  num? openingStock;
  num? valuationRate;
  num? standardRate;
  num? isFixedAsset;
  num? autoCreateAssets;
  dynamic assetCategory;
  dynamic assetNamingSeries;
  num? overDeliveryReceiptAllowance;
  num? overBillingAllowance;
  String? image;
  String? brand;
  String? description;
  num? shelfLifeInDays;
  DateTime? endOfLife;
  String? defaultMaterialRequestType;
  String? valuationMethod;
  dynamic warrantyPeriod;
  num? weightPerUnit;
  dynamic weightUom;
  num? hasBatchNo;
  num? createNewBatch;
  dynamic batchNumberSeries;
  num? hasExpiryDate;
  num? retainSample;
  num? sampleQuantity;
  num? hasSerialNo;
  dynamic serialNoSeries;
  num? hasVariants;
  String? variantBasedOn;
  num? isPurchaseItem;
  dynamic purchaseUom;
  num? minOrderQty;
  num? safetyStock;
  num? leadTimeDays;
  num? lastPurchaseRate;
  num? isCustomerProvidedItem;
  dynamic customer;
  num? deliveredBySupplier;
  dynamic countryOfOrigin;
  dynamic customsTariffNumber;
  dynamic salesUom;
  num? isSalesItem;
  num? grantCommission;
  num? maxDiscount;
  dynamic deferredRevenueAccount;
  num? enableDeferredRevenue;
  num? noOfMonths;
  dynamic deferredExpenseAccount;
  num? enableDeferredExpense;
  num? noOfMonthsExp;
  dynamic qualityInspectionTemplate;
  num? inspectionRequiredBeforePurchase;
  num? inspectionRequiredBeforeDelivery;
  dynamic defaultBom;
  num? isSubContractedItem;
  String? customerCode;
  dynamic defaultItemManufacturer;
  dynamic defaultManufacturerPartNo;
  num? publishInHub;
  dynamic hubCategoryToPublish;
  dynamic hubWarehouse;
  num? syncedWithHub;
  num? publishedInWebsite;
  num? totalProjectedQty;
  dynamic userTags;
  dynamic comments;
  dynamic assign;
  dynamic likedBy;
  dynamic hubSyncId;
  String? shortDescription;
  dynamic modelName;
  dynamic releaseDate;
  dynamic manufacturer;
  String? heroShotUri;
  String? curated;
  dynamic colorDefinition;
  String? hasColorSwatch;
  dynamic asset;
  String? vendorSku;
  String? manufacturerSku;
  String? upc;
  String? onlineMenuName;
  String? onlineMenuBrand;
  String? onlineMenuCategory;
  String? retailMarijuanaProductTypeCanada;
  dynamic volume;
  String? equivalentTo;
  String? strain;
  String? healthCanadaReportingCategory;
  dynamic netWeight;
  String? brand1;
  dynamic brrand;
  String? terpenes;
  String? thcMin;
  String? thcMax;
  String? cbdMin;
  String? cbdMax;
  dynamic numegratedGiftCard;
  dynamic salePrice;
  String? hasTieredPricing;
  String? hasGroupPricing;
  String? hasShelfPricing;
  String? groupId;
  String? catalogSku;
  dynamic rmsId;
  String? productStatus;
  dynamic dateAddedUtc;
  dynamic dateUpdatedUtc;
  String? batchTracking;
  String? nonStock;
  num? sellingPrice;
  dynamic assetType;
  dynamic vendor;
  num? thcMinimum;
  dynamic MainItemDataAsset;
  String? casegtin;
  dynamic packagedondate;
  String? gtinbarcode;
  String? MainItemDataEachgtin;
  dynamic eachgtin;
  dynamic machineType;
  dynamic kop;
  dynamic gstHsnCode;
  num? balanceQty;
  num? isNilExempt;
  num? isNonGst;
  dynamic tch;
  dynamic chc;
  dynamic taperene;
  dynamic weight;
  dynamic type;
  dynamic? stockEntries;
  dynamic variantUnits;

  MainItemData({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.namingSeries,
    this.itemCode,
    this.variantOf,
    this.itemName,
    this.itemGroup,
    this.isItemFromHub,
    this.stockUom,
    this.stockQty,
    this.disabled,
    this.allowAlternativeItem,
    this.isStockItem,
    this.includeItemInManufacturing,
    this.openingStock,
    this.valuationRate,
    this.standardRate,
    this.isFixedAsset,
    this.autoCreateAssets,
    this.assetCategory,
    this.assetNamingSeries,
    this.overDeliveryReceiptAllowance,
    this.overBillingAllowance,
    this.image,
    this.brand,
    this.description,
    this.shelfLifeInDays,
    this.endOfLife,
    this.defaultMaterialRequestType,
    this.valuationMethod,
    this.warrantyPeriod,
    this.weightPerUnit,
    this.weightUom,
    this.hasBatchNo,
    this.createNewBatch,
    this.batchNumberSeries,
    this.hasExpiryDate,
    this.retainSample,
    this.sampleQuantity,
    this.hasSerialNo,
    this.serialNoSeries,
    this.hasVariants,
    this.variantBasedOn,
    this.isPurchaseItem,
    this.purchaseUom,
    this.minOrderQty,
    this.safetyStock,
    this.leadTimeDays,
    this.lastPurchaseRate,
    this.isCustomerProvidedItem,
    this.customer,
    this.deliveredBySupplier,
    this.countryOfOrigin,
    this.customsTariffNumber,
    this.salesUom,
    this.isSalesItem,
    this.grantCommission,
    this.maxDiscount,
    this.deferredRevenueAccount,
    this.enableDeferredRevenue,
    this.noOfMonths,
    this.deferredExpenseAccount,
    this.enableDeferredExpense,
    this.noOfMonthsExp,
    this.qualityInspectionTemplate,
    this.inspectionRequiredBeforePurchase,
    this.inspectionRequiredBeforeDelivery,
    this.defaultBom,
    this.isSubContractedItem,
    this.customerCode,
    this.defaultItemManufacturer,
    this.defaultManufacturerPartNo,
    this.publishInHub,
    this.hubCategoryToPublish,
    this.hubWarehouse,
    this.syncedWithHub,
    this.publishedInWebsite,
    this.totalProjectedQty,
    this.userTags,
    this.comments,
    this.assign,
    this.likedBy,
    this.hubSyncId,
    this.shortDescription,
    this.modelName,
    this.releaseDate,
    this.manufacturer,
    this.heroShotUri,
    this.curated,
    this.colorDefinition,
    this.hasColorSwatch,
    this.asset,
    this.vendorSku,
    this.manufacturerSku,
    this.upc,
    this.onlineMenuName,
    this.onlineMenuBrand,
    this.onlineMenuCategory,
    this.retailMarijuanaProductTypeCanada,
    this.volume,
    this.equivalentTo,
    this.strain,
    this.healthCanadaReportingCategory,
    this.netWeight,
    this.brand1,
    this.brrand,
    this.terpenes,
    this.thcMin,
    this.thcMax,
    this.cbdMin,
    this.cbdMax,
    this.numegratedGiftCard,
    this.salePrice,
    this.hasTieredPricing,
    this.hasGroupPricing,
    this.hasShelfPricing,
    this.groupId,
    this.catalogSku,
    this.rmsId,
    this.productStatus,
    this.dateAddedUtc,
    this.dateUpdatedUtc,
    this.batchTracking,
    this.nonStock,
    this.sellingPrice,
    this.assetType,
    this.vendor,
    this.thcMinimum,
    this.MainItemDataAsset,
    this.casegtin,
    this.packagedondate,
    this.gtinbarcode,
    this.MainItemDataEachgtin,
    this.eachgtin,
    this.machineType,
    this.kop,
    this.gstHsnCode,
    this.balanceQty,
    this.isNilExempt,
    this.isNonGst,
    this.tch,
    this.chc,
    this.taperene,
    this.weight,
    this.type,
    this.stockEntries,
    this.variantUnits,
  });

  factory MainItemData.fromJson(Map<String, dynamic> json) => MainItemData(
      name: json["name"],
      creation:
          json["creation"] == null ? null : DateTime.parse(json["creation"]),
      modified:
          json["modified"] == null ? null : DateTime.parse(json["modified"]),
      modifiedBy: json["modified_by"],
      owner: json["owner"],
      docstatus: json["docstatus"],
      parent: json["parent"],
      parentfield: json["parentfield"],
      parenttype: json["parenttype"],
      idx: json["idx"],
      namingSeries: json["naming_series"],
      itemCode: json["item_code"],
      variantOf: json["variant_of"],
      itemName: json["item_name"],
      itemGroup: json["item_group"],
      isItemFromHub: json["is_item_from_hub"],
      stockUom: json["stock_uom"],
      disabled: json["disabled"],
      stockQty: json["actual_qty"],
      allowAlternativeItem: json["allow_alternative_item"],
      isStockItem: json["is_stock_item"],
      includeItemInManufacturing: json["include_item_in_manufacturing"],
      openingStock: json["opening_stock"],
      valuationRate: json["valuation_rate"],
      standardRate: json["standard_rate"],
      isFixedAsset: json["is_fixed_asset"],
      autoCreateAssets: json["auto_create_assets"],
      assetCategory: json["asset_category"],
      assetNamingSeries: json["asset_naming_series"],
      overDeliveryReceiptAllowance: json["over_delivery_receipt_allowance"],
      overBillingAllowance: json["over_billing_allowance"],
      image: json["image"],
      brand: json["brand"],
      description: json["description"],
      shelfLifeInDays: json["shelf_life_in_days"],
      endOfLife: json["end_of_life"] == null
          ? null
          : DateTime.parse(json["end_of_life"]),
      defaultMaterialRequestType: json["default_material_request_type"],
      valuationMethod: json["valuation_method"],
      warrantyPeriod: json["warranty_period"],
      weightPerUnit: json["weight_per_unit"],
      weightUom: json["weight_uom"],
      hasBatchNo: json["has_batch_no"],
      createNewBatch: json["create_new_batch"],
      batchNumberSeries: json["batch_number_series"],
      hasExpiryDate: json["has_expiry_date"],
      retainSample: json["retain_sample"],
      sampleQuantity: json["sample_quantity"],
      hasSerialNo: json["has_serial_no"],
      serialNoSeries: json["serial_no_series"],
      hasVariants: json["has_variants"],
      variantBasedOn: json["variant_based_on"],
      isPurchaseItem: json["is_purchase_item"],
      purchaseUom: json["purchase_uom"],
      minOrderQty: json["min_order_qty"],
      safetyStock: json["safety_stock"],
      leadTimeDays: json["lead_time_days"],
      lastPurchaseRate: json["last_purchase_rate"],
      isCustomerProvidedItem: json["is_customer_provided_item"],
      customer: json["customer"],
      deliveredBySupplier: json["delivered_by_supplier"],
      countryOfOrigin: json["country_of_origin"],
      customsTariffNumber: json["customs_tariff_number"],
      salesUom: json["sales_uom"],
      isSalesItem: json["is_sales_item"],
      grantCommission: json["grant_commission"],
      maxDiscount: json["max_discount"],
      deferredRevenueAccount: json["deferred_revenue_account"],
      enableDeferredRevenue: json["enable_deferred_revenue"],
      noOfMonths: json["no_of_months"],
      deferredExpenseAccount: json["deferred_expense_account"],
      enableDeferredExpense: json["enable_deferred_expense"],
      noOfMonthsExp: json["no_of_months_exp"],
      qualityInspectionTemplate: json["quality_inspection_template"],
      inspectionRequiredBeforePurchase:
          json["inspection_required_before_purchase"],
      inspectionRequiredBeforeDelivery:
          json["inspection_required_before_delivery"],
      defaultBom: json["default_bom"],
      isSubContractedItem: json["is_sub_contracted_item"],
      customerCode: json["customer_code"],
      defaultItemManufacturer: json["default_item_manufacturer"],
      defaultManufacturerPartNo: json["default_manufacturer_part_no"],
      publishInHub: json["publish_in_hub"],
      hubCategoryToPublish: json["hub_category_to_publish"],
      hubWarehouse: json["hub_warehouse"],
      syncedWithHub: json["synced_with_hub"],
      publishedInWebsite: json["published_in_website"],
      totalProjectedQty: json["total_projected_qty"],
      userTags: json["_user_tags"],
      comments: json["_comments"],
      assign: json["_assign"],
      likedBy: json["_liked_by"],
      hubSyncId: json["hub_sync_id"],
      shortDescription: json["short_description"],
      modelName: json["model_name"],
      releaseDate: json["release_date"],
      manufacturer: json["manufacturer"],
      heroShotUri: json["hero_shot_uri"],
      curated: json["curated"],
      colorDefinition: json["color_definition"],
      hasColorSwatch: json["has_color_swatch"],
      asset: json["asset"],
      vendorSku: json["vendor_sku"],
      manufacturerSku: json["manufacturer_sku"],
      upc: json["upc"],
      onlineMenuName: json["online_menu_name"],
      onlineMenuBrand: json["online_menu_brand"],
      onlineMenuCategory: json["online_menu_category"],
      retailMarijuanaProductTypeCanada:
          json["retail_marijuana_product_type__canada"],
      volume: json["volume"],
      equivalentTo: json["equivalent_to"],
      strain: json["strain"],
      healthCanadaReportingCategory: json["health_canada_reporting_category"],
      netWeight: double.parse(json["net_weight"] ?? '0'),
      brand1: json["brand1"],
      brrand: json["brrand"],
      terpenes: json["terpenes"],
      thcMin: json["thc_min"] != null ? '${json["thc_min"]}' : null,
      thcMax: json["thc_max"] != null ? '${json["thc_max"]}' : null,
      cbdMin: json["cbd_min"] != null ? '${json["cbd_min"]}' : null,
      cbdMax: json["cbd_max"] != null ? '${json["cbd_max"]}' : null,
      numegratedGiftCard: json["numegrated_gift_card"],
      salePrice: json["sale_price"],
      hasTieredPricing: json["has_tiered_pricing"],
      hasGroupPricing: json["has_group_pricing"],
      hasShelfPricing: json["has_shelf_pricing"],
      groupId: json["group_id"],
      catalogSku: json["catalog_sku"],
      rmsId: json["rms_id"],
      productStatus: json["product_status"],
      dateAddedUtc: json["date_added_utc"],
      dateUpdatedUtc: json["date_updated_utc"],
      batchTracking: json["batch_tracking"],
      nonStock: json["non_stock"],
      sellingPrice: json["selling_price"],
      assetType: json["asset_type"],
      vendor: json["vendor"],
      thcMinimum: json["thc_minimum"],
      MainItemDataAsset: json["asset_"],
      casegtin: json["casegtin"],
      packagedondate: json["packagedondate"],
      gtinbarcode: json["gtinbarcode"],
      MainItemDataEachgtin: json["eachgtin"],
      eachgtin: json["_eachgtin"],
      machineType: json["machine_type"],
      kop: json["kop"],
      gstHsnCode: json["gst_hsn_code"],
      balanceQty: json["balance_qty"],
      isNilExempt: json["is_nil_exempt"],
      isNonGst: json["is_non_gst"],
      tch: json["tch"],
      chc: json["chc"],
      taperene: json["taperene"],
      weight: json["weight"],
      type: json["type"],
      stockEntries: json["stockEntries"],
      variantUnits: json["variant_units"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "owner": owner,
        "docstatus": docstatus,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "naming_series": namingSeries,
        "item_code": itemCode,
        "variant_of": variantOf,
        "item_name": itemName,
        "item_group": itemGroup,
        "is_item_from_hub": isItemFromHub,
        "stock_uom": stockUom,
        "disabled": disabled,
        "allow_alternative_item": allowAlternativeItem,
        "is_stock_item": isStockItem,
        "include_item_in_manufacturing": includeItemInManufacturing,
        "opening_stock": openingStock,
        "valuation_rate": valuationRate,
        "standard_rate": standardRate,
        "is_fixed_asset": isFixedAsset,
        "auto_create_assets": autoCreateAssets,
        "asset_category": assetCategory,
        "asset_naming_series": assetNamingSeries,
        "over_delivery_receipt_allowance": overDeliveryReceiptAllowance,
        "over_billing_allowance": overBillingAllowance,
        "image": image,
        "brand": brand,
        "description": description,
        "shelf_life_in_days": shelfLifeInDays,
        "end_of_life":
            "${endOfLife!.year.toString().padLeft(4, '0')}-${endOfLife!.month.toString().padLeft(2, '0')}-${endOfLife!.day.toString().padLeft(2, '0')}",
        "default_material_request_type": defaultMaterialRequestType,
        "valuation_method": valuationMethod,
        "warranty_period": warrantyPeriod,
        "weight_per_unit": weightPerUnit,
        "weight_uom": weightUom,
        "has_batch_no": hasBatchNo,
        "create_new_batch": createNewBatch,
        "batch_number_series": batchNumberSeries,
        "has_expiry_date": hasExpiryDate,
        "retain_sample": retainSample,
        "sample_quantity": sampleQuantity,
        "has_serial_no": hasSerialNo,
        "serial_no_series": serialNoSeries,
        "has_variants": hasVariants,
        "variant_based_on": variantBasedOn,
        "is_purchase_item": isPurchaseItem,
        "purchase_uom": purchaseUom,
        "min_order_qty": minOrderQty,
        "safety_stock": safetyStock,
        "lead_time_days": leadTimeDays,
        "last_purchase_rate": lastPurchaseRate,
        "is_customer_provided_item": isCustomerProvidedItem,
        "customer": customer,
        "delivered_by_supplier": deliveredBySupplier,
        "country_of_origin": countryOfOrigin,
        "customs_tariff_number": customsTariffNumber,
        "sales_uom": salesUom,
        "is_sales_item": isSalesItem,
        "grant_commission": grantCommission,
        "max_discount": maxDiscount,
        "deferred_revenue_account": deferredRevenueAccount,
        "enable_deferred_revenue": enableDeferredRevenue,
        "no_of_months": noOfMonths,
        "deferred_expense_account": deferredExpenseAccount,
        "enable_deferred_expense": enableDeferredExpense,
        "no_of_months_exp": noOfMonthsExp,
        "quality_inspection_template": qualityInspectionTemplate,
        "inspection_required_before_purchase": inspectionRequiredBeforePurchase,
        "inspection_required_before_delivery": inspectionRequiredBeforeDelivery,
        "default_bom": defaultBom,
        "is_sub_contracted_item": isSubContractedItem,
        "customer_code": customerCode,
        "default_item_manufacturer": defaultItemManufacturer,
        "default_manufacturer_part_no": defaultManufacturerPartNo,
        "publish_in_hub": publishInHub,
        "hub_category_to_publish": hubCategoryToPublish,
        "hub_warehouse": hubWarehouse,
        "synced_with_hub": syncedWithHub,
        "published_in_website": publishedInWebsite,
        "total_projected_qty": totalProjectedQty,
        "_user_tags": userTags,
        "_comments": comments,
        "_assign": assign,
        "_liked_by": likedBy,
        "hub_sync_id": hubSyncId,
        "short_description": shortDescription,
        "model_name": modelName,
        "release_date": releaseDate,
        "manufacturer": manufacturer,
        "hero_shot_uri": heroShotUri,
        "curated": curated,
        "color_definition": colorDefinition,
        "has_color_swatch": hasColorSwatch,
        "asset": asset,
        "vendor_sku": vendorSku,
        "manufacturer_sku": manufacturerSku,
        "upc": upc,
        "online_menu_name": onlineMenuName,
        "online_menu_brand": onlineMenuBrand,
        "online_menu_category": onlineMenuCategory,
        "retail_marijuana_product_type__canada":
            retailMarijuanaProductTypeCanada,
        "volume": volume,
        "equivalent_to": equivalentTo,
        "strain": strain,
        "health_canada_reporting_category": healthCanadaReportingCategory,
        "net_weight": netWeight,
        "brand1": brand1,
        "brrand": brrand,
        "terpenes": terpenes,
        "thc_min": thcMin,
        "thc_max": thcMax,
        "cbd_min": cbdMin,
        "cbd_max": cbdMax,
        "numegrated_gift_card": numegratedGiftCard,
        "sale_price": salePrice,
        "has_tiered_pricing": hasTieredPricing,
        "has_group_pricing": hasGroupPricing,
        "has_shelf_pricing": hasShelfPricing,
        "group_id": groupId,
        "catalog_sku": catalogSku,
        "rms_id": rmsId,
        "product_status": productStatus,
        "date_added_utc": dateAddedUtc,
        "date_updated_utc": dateUpdatedUtc,
        "batch_tracking": batchTracking,
        "non_stock": nonStock,
        "selling_price": sellingPrice,
        "asset_type": assetType,
        "vendor": vendor,
        "thc_minimum": thcMinimum,
        "asset_": MainItemDataAsset,
        "casegtin": casegtin,
        "packagedondate": packagedondate,
        "gtinbarcode": gtinbarcode,
        "eachgtin": MainItemDataEachgtin,
        "_eachgtin": eachgtin,
        "machine_type": machineType,
        "kop": kop,
        "gst_hsn_code": gstHsnCode,
        "balance_qty": balanceQty,
        "is_nil_exempt": isNilExempt,
        "is_non_gst": isNonGst,
        "tch": tch,
        "chc": chc,
        "taperene": taperene,
        "weight": weight,
        "type": type,
        'variant_units': variantUnits
      };
}
