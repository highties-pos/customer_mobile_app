// To parse this JSON data, do
//
//     final posProfileBasedOnWarehouseModel = posProfileBasedOnWarehouseModelFromJson(jsonString);

import 'dart:convert';

DrawerModel drawerModelFromJson(String str) =>
    DrawerModel.fromJson(json.decode(str));

String drawerModelToJson(DrawerModel data) => json.encode(data.toJson());

class DrawerModel {
  List<DrawerModelData>? data;

  DrawerModel({
    this.data,
  });

  factory DrawerModel.fromJson(Map<String, dynamic> json) => DrawerModel(
        data: json["result"] == null
            ? []
            : List<DrawerModelData>.from(
                json["result"]!.map((x) => DrawerModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DrawerModelData {
  String? posProfileName;
  String? name;

  // todo: remove old properties later

  String? buttonName;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  num? docstatus;
  String? parent;
  String? parentfield;
  String? parenttype;
  num? idx;
  String? periodStartDate;
  String? periodEndDate;
  String? status;
  String? postingDate;
  num? setPostingDate;
  String? company;
  String? posProfile;
  String? posClosingEntry;
  String? user;
  String? amendedFrom;
  String? userTags;
  String? comments;
  String? assign;
  String? likedBy;

  // new properties

  String? id;
  String? warehouseId;
  bool? cashManagementEnabled;
  String? description;
  int? totalSales;
  int? totalTransactions;
  bool? isOpen;
  int? totalAmount;
  int? totalCashAmount;
  int? totalNonCashAmount;
  String? lastClosedAt;
  String? lastOpenedAt;
  String? createdAt;
  String? updatedAt;

  DrawerModelData({
    this.posProfileName,
    this.buttonName,
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
    this.periodStartDate,
    this.periodEndDate,
    this.status,
    this.postingDate,
    this.setPostingDate,
    this.company,
    this.posProfile,
    this.posClosingEntry,
    this.user,
    this.amendedFrom,
    this.userTags,
    this.comments,
    this.assign,
    this.likedBy,

    // new properties

    this.id,
    this.warehouseId,
    this.cashManagementEnabled,
    this.description,
    this.totalSales,
    this.totalTransactions,
    this.isOpen,
    this.totalAmount,
    this.totalCashAmount,
    this.totalNonCashAmount,
    this.lastClosedAt,
    this.lastOpenedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory DrawerModelData.fromJson(Map<String, dynamic> json) =>
      DrawerModelData(
        name: json["name"],
        posProfileName: json["pos_profile_name"],
        creation: json['creation'],
        buttonName: json['button_name'],
        modified: json['modified'],
        modifiedBy: json['modified_by'],
        owner: json['owner'],
        docstatus: json['docstatus'],
        parent: json['parent'],
        parentfield: json['parentfield'],
        parenttype: json['parenttype'],
        idx: json['idx'],
        periodStartDate: json['period_start_date'],
        periodEndDate: json['period_end_date'],
        status: json['status'],
        postingDate: json['posting_date'],
        setPostingDate: json['set_posting_date'],
        company: json['company'],
        posProfile: json['pos_profile'],
        posClosingEntry: json['pos_closing_entry'],
        user: json['user'],
        amendedFrom: json['amended_from'],
        userTags: json['_user_tags'],
        comments: json['_comments'],
        assign: json['_assign'],
        likedBy: json['_liked_by'],

        // new properties

        id: json['id'],
        warehouseId: json['warehouseId'],
        cashManagementEnabled: json['cashManagementEnabled'],
        description: json['description'],
        totalSales: json['totalSales'],
        totalTransactions: json['totalTransactions'],
        isOpen: json['isOpen'],
        totalAmount: json['totalAmount'],
        totalCashAmount: json['totalCashAmount'],
        totalNonCashAmount: json['totalNonCashAmount'],
        lastClosedAt: json['lastClosedAt'],
        lastOpenedAt: json['lastOpenedAt'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
