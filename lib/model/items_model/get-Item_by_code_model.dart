// To parse this JSON data, do
//
//     final itemDetailData = itemDetailDataFromJson(jsonString);

import 'dart:convert';

import 'package:highties_cannabis/components/common_methos.dart';

ItemDetailData itemDetailDataFromJson(String str) =>
    ItemDetailData.fromJson(json.decode(str));

String itemDetailDataToJson(ItemDetailData data) => json.encode(data.toJson());

class ItemDetailData {
  String? message;
  Data? data;
  bool? success;

  ItemDetailData({
    this.message,
    this.data,
    this.success,
  });

  factory ItemDetailData.fromJson(Map<String, dynamic> json) => ItemDetailData(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}

class Data {
  dynamic productImage;
  String? productCode;
  String? productName;
  String? brand;
  String? uom;
  DateTime? endOfLife;
  num? weightPerUnit;
  num? netWeight;
  dynamic modelName;
  dynamic description;
  dynamic shortDescription;
  dynamic releaseDate;
  dynamic manufacturer;
  dynamic heroShotUri;
  String? curated;
  dynamic volume;
  dynamic strain;
  dynamic thcMin;
  dynamic thcMax;
  dynamic cbdMin;
  dynamic cbdMax;
  dynamic? terpenes;
  num? productPrice;
  num? productStock;
  dynamic itemLinking;
  List stockEntries;

  Data({
    this.productImage,
    this.productCode,
    this.productName,
    this.brand,
    this.uom,
    this.endOfLife,
    this.weightPerUnit,
    this.netWeight,
    this.modelName,
    this.description,
    this.shortDescription,
    this.releaseDate,
    this.manufacturer,
    this.heroShotUri,
    this.curated,
    this.volume,
    this.strain,
    this.thcMin,
    this.thcMax,
    this.cbdMin,
    this.cbdMax,
    this.productPrice,
    this.productStock,
    this.itemLinking,
    this.terpenes,
    this.stockEntries = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        productImage: json["product_image"],
        productCode: json["product_code"],
        productName: json["product_name"],
        brand: json["brand"],
        uom: json["uom"],
        endOfLife: json["end_of_life"] == null
            ? null
            : DateTime.parse(json["end_of_life"]),
        weightPerUnit: json["weight_per_unit"],
        netWeight: CommonMethod().convertToDouble(json['net_weight'] ?? 0),
        modelName: json["model_name"],
        description: json["description"],
        shortDescription: json["short_description"],
        releaseDate: json["release_date"],
        manufacturer: json["manufacturer"],
        heroShotUri: json["hero_shot_uri"],
        curated: json["curated"],
        volume: json["volume"],
        strain: json["strain"],
        thcMin: json["thc_min"],
        thcMax: json["thc_max"],
        cbdMin: json["cbd_min"],
        cbdMax: json["cbd_max"],
        productPrice: json["product_price"],
        productStock: json["product_stock"],
        itemLinking: json["item_linking"],
        terpenes: json['terpenes'],
        stockEntries: json['stockEntries'],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "product_code": productCode,
        "product_name": productName,
        "brand": brand,
        "uom": uom,
        "end_of_life":
            "${endOfLife!.year.toString().padLeft(4, '0')}-${endOfLife!.month.toString().padLeft(2, '0')}-${endOfLife!.day.toString().padLeft(2, '0')}",
        "weight_per_unit": weightPerUnit,
        "model_name": modelName,
        "description": description,
        "short_description": shortDescription,
        'net_weight': netWeight,
        "release_date": releaseDate,
        "manufacturer": manufacturer,
        "hero_shot_uri": heroShotUri,
        "curated": curated,
        "volume": volume,
        "strain": strain,
        "thc_min": thcMin,
        "thc_max": thcMax,
        "cbd_min": cbdMin,
        "cbd_max": cbdMax,
        "product_price": productPrice,
        "product_stock": productStock,
        "item_linking": itemLinking,
      };
}
