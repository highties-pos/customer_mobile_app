import 'dart:convert';

class SavedCartModel {
  List<double>? basePrice;
  List<double>? discountBasePrice;
  double? subtotal;
  double? invoiceDiscount;
  double? totalTax;
  double? finalTotal;
  String? cartName;
  String? cartId;
  String? createdAt;

  SavedCartModel({
    this.basePrice,
    this.discountBasePrice,
    this.subtotal = 0.00,
    this.invoiceDiscount = 0.00,
    this.totalTax = 0.00,
    this.finalTotal = 0.00,
    this.cartName = "",
    this.cartId = "",
    this.createdAt = "",
  });

  static String encode(List<SavedCartModel> dEncode) => json.encode(
      // dEncode.map((e) => e.toJson()).toList(),
      dEncode);

  static List<SavedCartModel> decode(String dEncode) =>
      (json.decode(dEncode) as List<dynamic>)
          .map<SavedCartModel>((item) => SavedCartModel.fromJson(item))
          .toList();

  factory SavedCartModel.fromJson(Map<String, dynamic> json) => SavedCartModel(
        basePrice: json["basePrice"] == null
            ? []
            : List<double>.from(json["basePrice"]!.map((x) => x)),
        discountBasePrice: json["discountBasePrice"] == null
            ? []
            : List<double>.from(json["discountBasePrice"]!.map((x) => x)),
        subtotal: json["subtotal"],
        invoiceDiscount: json["invoiceDiscount"],
        totalTax: json["totalTax"],
        finalTotal: json["finalTotal"],
        cartName: json["cartName"],
        cartId: json["cartId"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "basePrice": basePrice,
        "discountBasePrice": discountBasePrice,
        "subtotal": subtotal,
        "invoiceDiscount": invoiceDiscount,
        "totalTax": totalTax,
        "finalTotal": finalTotal,
        "cartId": cartId,
        "cartName": cartName,
        "createdAt": createdAt,
      };
}
