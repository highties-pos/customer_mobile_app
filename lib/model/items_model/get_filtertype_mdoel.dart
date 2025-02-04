// To parse this JSON data, do
//
//     final getFilterTapereneModel = getFilterTapereneModelFromJson(jsonString);

import 'dart:convert';

GetFilterTypeModel getFilterTapereneModelFromJson(String str) =>
    GetFilterTypeModel.fromJson(json.decode(str));

String getFilterTapereneModelToJson(GetFilterTypeModel data) =>
    json.encode(data.toJson());

class GetFilterTypeModel {
  String? message;
  List<String>? data;
  bool? success;
  List<String>? selectedData = [];

  GetFilterTypeModel({
    this.message,
    this.data,
    this.success,
    // this.isSelected,
  });

  factory GetFilterTypeModel.fromJson(Map<String, dynamic> json) =>
      GetFilterTypeModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
        success: json["success"],
        // isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "success": success,
        // "isSelected": isSelected,
      };
}
