// // To parse this JSON data, do
// //
// //     final getFilterTapereneModel = getFilterTapereneModelFromJson(jsonString);

// import 'dart:convert';

// GetFilterTapereneModel getFilterTapereneModelFromJson(String str) =>
//     GetFilterTapereneModel.fromJson(json.decode(str));

// String getFilterTapereneModelToJson(GetFilterTapereneModel data) =>
//     json.encode(data.toJson());

// class GetFilterTapereneModel {
//   List<TapereneFilterData>? data;

//   GetFilterTapereneModel({
//     this.data,
//   });

//   factory GetFilterTapereneModel.fromJson(Map<String, dynamic> json) =>
//       GetFilterTapereneModel(
//         data: json["data"] == null
//             ? []
//             : List<TapereneFilterData>.from(
//                 json["data"]!.map((x) => TapereneFilterData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class TapereneFilterData {
//   String? name;
//   bool? isSelected;

//   TapereneFilterData({
//     this.name,
//     this.isSelected,
//   });

//   factory TapereneFilterData.fromJson(Map<String, dynamic> json) =>
//       TapereneFilterData(
//         name: json["name"],
//         isSelected: json["isSelected"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "isSelected": isSelected,
//       };
// }

// To parse this JSON data, do
//
//     final getFilterTapereneModel = getFilterTapereneModelFromJson(jsonString);

import 'dart:convert';

GetFilterTapereneModel getFilterTapereneModelFromJson(String str) =>
    GetFilterTapereneModel.fromJson(json.decode(str));

String getFilterTapereneModelToJson(GetFilterTapereneModel data) =>
    json.encode(data.toJson());

class GetFilterTapereneModel {
  String? message;
  List<String>? data;
  bool? success;
  List<String>? selectedData = [];

  GetFilterTapereneModel({
    this.message,
    this.data,
    this.success,
  });

  factory GetFilterTapereneModel.fromJson(Map<String, dynamic> json) =>
      GetFilterTapereneModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "success": success,
      };
}
