// To parse this JSON data, do
//
//     final posProfileBasedOnWarehouseModel = posProfileBasedOnWarehouseModelFromJson(jsonString);

import 'dart:convert';

PosProfileBasedOnWarehouseModel posProfileBasedOnWarehouseModelFromJson(
        String str) =>
    PosProfileBasedOnWarehouseModel.fromJson(json.decode(str));

String posProfileBasedOnWarehouseModelToJson(
        PosProfileBasedOnWarehouseModel data) =>
    json.encode(data.toJson());

class PosProfileBasedOnWarehouseModel {
  List<PosProfileData>? data;

  PosProfileBasedOnWarehouseModel({
    this.data,
  });

  factory PosProfileBasedOnWarehouseModel.fromJson(Map<String, dynamic> json) =>
      PosProfileBasedOnWarehouseModel(
        data: json["result"] == null
            ? []
            : List<PosProfileData>.from(
                json["result"]!.map((x) => PosProfileData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PosProfileData {
  String? id;
  String? name;

  PosProfileData({
    this.id,
    this.name,
  });

  factory PosProfileData.fromJson(Map<String, dynamic> json) => PosProfileData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
