// // To parse this JSON data, do
// //
// //     final getFilterWeightModel = getFilterWeightModelFromJson(jsonString);

// import 'dart:convert';

// GetFilterWeightModel getFilterWeightModelFromJson(String str) =>
//     GetFilterWeightModel.fromJson(json.decode(str));

// String getFilterWeightModelToJson(GetFilterWeightModel data) =>
//     json.encode(data.toJson());

// class GetFilterWeightModel {
//   List<WeightFilterData>? data;

//   GetFilterWeightModel({
//     this.data,
//   });

//   factory GetFilterWeightModel.fromJson(Map<String, dynamic> json) =>
//       GetFilterWeightModel(
//         data: json["data"] == null
//             ? []
//             : List<WeightFilterData>.from(
//                 json["data"]!.map((x) => WeightFilterData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class WeightFilterData {
//   String? name;
//   bool? isSelected;

//   WeightFilterData({
//     this.name,
//     this.isSelected,
//   });

//   factory WeightFilterData.fromJson(Map<String, dynamic> json) =>
//       WeightFilterData(
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

GetFilterWeightModel getFilterTapereneModelFromJson(String str) =>
    GetFilterWeightModel.fromJson(json.decode(str));

String getFilterTapereneModelToJson(GetFilterWeightModel data) =>
    json.encode(data.toJson());

class GetFilterWeightModel {
  String? message;
  List<String>? data;
  bool? success;
  List<String>? selectedData = [];

  GetFilterWeightModel({
    this.message,
    this.data,
    this.success,
  });

  factory GetFilterWeightModel.fromJson(Map<String, dynamic> json) =>
      GetFilterWeightModel(
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
