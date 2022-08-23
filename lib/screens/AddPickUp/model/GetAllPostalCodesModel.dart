import 'dart:convert';

GetAllPostalCodesResponseModel getAllPostalCodesResponseModelFromJson(
        String str) =>
    GetAllPostalCodesResponseModel.fromJson(json.decode(str));

String getAllPostalCodesResponseModelToJson(
        GetAllPostalCodesResponseModel data) =>
    json.encode(data.toJson());

class GetAllPostalCodesResponseModel {
  GetAllPostalCodesResponseModel({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory GetAllPostalCodesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] == 1) {
      return GetAllPostalCodesResponseModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
    } else {
      return GetAllPostalCodesResponseModel(
        status: json["status"],
        data: null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (status == 1) {
      return {
        "status": status,
        "data": List<dynamic>.from(data!.map((e) => e.toJson())),
      };
    } else {
      return {
        "status": status,
        "data": null,
      };
    }
  }
}

class Datum {
  Datum({
    this.id,
    this.pinCode,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? pinCode;
  String? branchId;
  String? createdAt;
  String? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        pinCode: json["pincode"],
        branchId: json["branch_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pincode": pinCode,
        "branch_id": branchId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
