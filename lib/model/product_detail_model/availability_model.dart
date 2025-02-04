// To parse this JSON data, do
//
//     final availabilityModel = availabilityModelFromJson(jsonString);

import 'dart:convert';

AvailabilityModel availabilityModelFromJson(String str) =>
    AvailabilityModel.fromJson(json.decode(str));

String availabilityModelToJson(AvailabilityModel data) =>
    json.encode(data.toJson());

class AvailabilityModel {
  Message? message;

  AvailabilityModel({
    this.message,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityModel(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  List<Result>? result;
  List<Column>? columns;
  dynamic message;
  dynamic chart;
  dynamic reportSummary;
  int? skipTotalRow;
  dynamic status;
  double? executionTime;
  int? addTotalRow;

  Message({
    this.result,
    this.columns,
    this.message,
    this.chart,
    this.reportSummary,
    this.skipTotalRow,
    this.status,
    this.executionTime,
    this.addTotalRow,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        columns: json["columns"] == null
            ? []
            : List<Column>.from(
                json["columns"]!.map((x) => Column.fromJson(x))),
        message: json["message"],
        chart: json["chart"],
        reportSummary: json["report_summary"],
        skipTotalRow: json["skip_total_row"],
        status: json["status"],
        executionTime: json["execution_time"]?.toDouble(),
        addTotalRow: json["add_total_row"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "columns": columns == null
            ? []
            : List<dynamic>.from(columns!.map((x) => x.toJson())),
        "message": message,
        "chart": chart,
        "report_summary": reportSummary,
        "skip_total_row": skipTotalRow,
        "status": status,
        "execution_time": executionTime,
        "add_total_row": addTotalRow,
      };
}

class Column {
  String? label;
  String? fieldname;
  String? fieldtype;
  int? width;
  String? options;
  String? convertible;

  Column({
    this.label,
    this.fieldname,
    this.fieldtype,
    this.width,
    this.options,
    this.convertible,
  });

  factory Column.fromJson(Map<String, dynamic> json) => Column(
        label: json["label"],
        fieldname: json["fieldname"],
        fieldtype: json["fieldtype"],
        width: json["width"],
        options: json["options"],
        convertible: json["convertible"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "fieldname": fieldname,
        "fieldtype": fieldtype,
        "width": width,
        "options": options,
        "convertible": convertible,
      };
}

class Result {
  DateTime? date;
  String? itemCode;
  String? warehouse;
  double? actualQty;
  double? qtyAfterTransaction;
  double? incomingRate;
  double? valuationRate;
  double? stockValue;
  String? voucherType;
  String? voucherNo;
  String? batchNo;
  String? serialNo;
  String? company;
  dynamic project;
  double? stockValueDifference;
  String? name;
  String? itemName;
  String? description;
  String? itemGroup;
  dynamic brand;
  String? stockUom;
  dynamic inQty;
  dynamic outQty;

  Result({
    this.date,
    this.itemCode,
    this.warehouse,
    this.actualQty,
    this.qtyAfterTransaction,
    this.incomingRate,
    this.valuationRate,
    this.stockValue,
    this.voucherType,
    this.voucherNo,
    this.batchNo,
    this.serialNo,
    this.company,
    this.project,
    this.stockValueDifference,
    this.name,
    this.itemName,
    this.description,
    this.itemGroup,
    this.brand,
    this.stockUom,
    this.inQty,
    this.outQty,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        itemCode: json["item_code"],
        warehouse: json["warehouse"],
        actualQty: json["actual_qty"],
        qtyAfterTransaction: json["qty_after_transaction"],
        incomingRate: json["incoming_rate"],
        valuationRate: json["valuation_rate"],
        stockValue: json["stock_value"],
        voucherType: json["voucher_type"],
        voucherNo: json["voucher_no"],
        batchNo: json["batch_no"],
        serialNo: json["serial_no"],
        company: json["company"],
        project: json["project"],
        stockValueDifference: json["stock_value_difference"],
        name: json["name"],
        itemName: json["item_name"],
        description: json["description"],
        itemGroup: json["item_group"],
        brand: json["brand"],
        stockUom: json["stock_uom"],
        inQty: json["in_qty"],
        outQty: json["out_qty"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "item_code": itemCode,
        "warehouse": warehouse,
        "actual_qty": actualQty,
        "qty_after_transaction": qtyAfterTransaction,
        "incoming_rate": incomingRate,
        "valuation_rate": valuationRate,
        "stock_value": stockValue,
        "voucher_type": voucherType,
        "voucher_no": voucherNo,
        "batch_no": batchNo,
        "serial_no": serialNo,
        "company": company,
        "project": project,
        "stock_value_difference": stockValueDifference,
        "name": name,
        "item_name": itemName,
        "description": description,
        "item_group": itemGroup,
        "brand": brand,
        "stock_uom": stockUom,
        "in_qty": inQty,
        "out_qty": outQty,
      };
}
