// To parse this JSON data, do
//
//     final getAllItemsGroupModel = getAllItemsGroupModelFromJson(jsonString);

import 'dart:convert';

GetAllItemsGroupModel getAllItemsGroupModelFromJson(String str) =>
    GetAllItemsGroupModel.fromJson(json.decode(str));

String getAllItemsGroupModelToJson(GetAllItemsGroupModel data) =>
    json.encode(data.toJson());

class GetAllItemsGroupModel {
  List<ItemGroupData>? data;

  GetAllItemsGroupModel({
    this.data,
  });

  factory GetAllItemsGroupModel.fromJson(Map<String, dynamic> json) =>
      GetAllItemsGroupModel(
        data: json["result"] == null
            ? []
            : List<ItemGroupData>.from(
                json["result"]!.map((x) => ItemGroupData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemGroupData {
  String? id;
  String? name;

  ItemGroupData({
    this.id,
    this.name,
  });

  factory ItemGroupData.fromJson(Map<String, dynamic> json) => ItemGroupData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
