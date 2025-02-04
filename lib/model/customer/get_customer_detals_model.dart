// To parse this JSON data, do
//
//     final getCustomerByDetailModel = getCustomerByDetailModelFromJson(jsonString);

import 'dart:convert';

GetCustomerByDetailModel getCustomerByDetailModelFromJson(String str) =>
    GetCustomerByDetailModel.fromJson(json.decode(str));

String getCustomerByDetailModelToJson(GetCustomerByDetailModel data) =>
    json.encode(data.toJson());

class GetCustomerByDetailModel {
  Data? data;

  GetCustomerByDetailModel({
    this.data,
  });

  factory GetCustomerByDetailModel.fromJson(Map<String, dynamic> json) =>
      GetCustomerByDetailModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? name;
  String? owner;
  String? phoneNo;
  String? mobileNo;
  String? emailId;
  String? governmentId;
  String? governmentIdNumber;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? idx;
  num? docstatus;
  String? namingSeries;
  String? customerName;
  String? firstName;
  String? image;
  String? lastName;
  String? medicalPatient;
  String? favouriteStore;
  DateTime? dateOfBirth;
  String? customerType;
  String? gstCategory;
  String? allowMarketing;
  String? temporaryMedicalLicense;
  String? customerGroup;
  String? territory;
  bool? soRequired;
  bool? dnRequired;
  bool? disabled;
  bool? isInternalCustomer;
  String? language;
  bool? isFrozen;
  num? defaultCommissionRate;
  String? doctype;
  String? notes;
  List<dynamic>? companies;
  List<dynamic>? accounts;
  List<dynamic>? creditLimits;
  List<dynamic>? salesTeam;

  Data({
    this.id,
    this.name,
    this.phoneNo,
    this.mobileNo,
    this.emailId,
    this.favouriteStore,
    this.governmentId,
    this.governmentIdNumber,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.namingSeries,
    this.customerName,
    this.firstName,
    this.image,
    this.lastName,
    this.medicalPatient,
    this.dateOfBirth,
    this.customerType,
    this.gstCategory,
    this.allowMarketing,
    this.temporaryMedicalLicense,
    this.customerGroup,
    this.territory,
    this.soRequired,
    this.dnRequired,
    this.disabled,
    this.isInternalCustomer,
    this.language,
    this.isFrozen,
    this.defaultCommissionRate,
    this.doctype,
    this.companies,
    this.accounts,
    this.creditLimits,
    this.salesTeam,
    this.notes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: "${json['first_name'] ?? ''} ${json['last_name'] ?? ''}",
        owner: json["owner"],
        emailId: json['email_id'],
        phoneNo: json['phone_no'],
        mobileNo: json['mobile_no'],
        favouriteStore: json['favourite_store'],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: null,
        docstatus: json["docstatus"],
        namingSeries: json["naming_series"],
        customerName: json["customer_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        medicalPatient: json["medical_patient"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        customerType: json["customer_type"],
        image: json["image"],
        gstCategory: json["gst_category"],
        allowMarketing: json["allow_marketing"],
        temporaryMedicalLicense: json["temporary_medical_license"],
        customerGroup: json["customer_group"],
        territory: json["territory"],
        governmentId: json["government_id"],
        governmentIdNumber: json["government_id_number"],
        soRequired: json["so_required"],
        dnRequired: json["dn_required"],
        disabled: json["disabled"],
        isInternalCustomer: json["is_internal_customer"],
        language: json["language"],
        isFrozen: json["is_frozen"],
        defaultCommissionRate: json["default_commission_rate"],
        doctype: json["doctype"],
        notes: json["notes"],
        companies: json["companies"] == null
            ? []
            : List<dynamic>.from(json["companies"]!.map((x) => x)),
        accounts: json["accounts"] == null
            ? []
            : List<dynamic>.from(json["accounts"]!.map((x) => x)),
        creditLimits: json["credit_limits"] == null
            ? []
            : List<dynamic>.from(json["credit_limits"]!.map((x) => x)),
        salesTeam: json["sales_team"] == null
            ? []
            : List<dynamic>.from(json["sales_team"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notes": notes,
        "name": name,
        "owner": owner,
        "phone_no": phoneNo,
        "mobile_no": mobileNo,
        "image": image,
        "government_id": governmentId,
        "government_id_number": governmentIdNumber,
        "favourite_store": favouriteStore,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "naming_series": namingSeries,
        "customer_name": customerName,
        "first_name": firstName,
        "last_name": lastName,
        "medical_patient": medicalPatient,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "customer_type": customerType,
        "gst_category": gstCategory,
        "allow_marketing": allowMarketing,
        "temporary_medical_license": temporaryMedicalLicense,
        "customer_group": customerGroup,
        "territory": territory,
        "so_required": soRequired,
        "dn_required": dnRequired,
        "disabled": disabled,
        "is_internal_customer": isInternalCustomer,
        "language": language,
        "is_frozen": isFrozen,
        "default_commission_rate": defaultCommissionRate,
        "doctype": doctype,
        "companies": companies == null
            ? []
            : List<dynamic>.from(companies!.map((x) => x)),
        "accounts":
            accounts == null ? [] : List<dynamic>.from(accounts!.map((x) => x)),
        "credit_limits": creditLimits == null
            ? []
            : List<dynamic>.from(creditLimits!.map((x) => x)),
        "sales_team": salesTeam == null
            ? []
            : List<dynamic>.from(salesTeam!.map((x) => x)),
      };
}
