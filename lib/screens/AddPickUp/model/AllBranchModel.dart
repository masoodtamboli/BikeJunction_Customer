// To parse this JSON data, do
//
//     final allBranchResponseModel = allBranchResponseModelFromJson(jsonString);

import 'dart:convert';

AllBranchResponseModel allBranchResponseModelFromJson(String str) => AllBranchResponseModel.fromJson(json.decode(str));

String allBranchResponseModelToJson(AllBranchResponseModel data) => json.encode(data.toJson());

class AllBranchResponseModel {
  AllBranchResponseModel({
    this.status,
    this.data,
  });

  int? status;
  List<AllBranchData>? data;

  factory AllBranchResponseModel.fromJson(Map<String, dynamic> json) => AllBranchResponseModel(
    status: json["status"],
    data: List<AllBranchData>.from(json["data"].map((x) => AllBranchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AllBranchData {
  AllBranchData({
    this.branchId,
    this.branchName,
    this.branchMobile,
    this.branchAddress,
    this.branchPincode,
    this.branchArea,
  });

  String? branchId;
  String? branchName;
  String? branchMobile;
  String? branchAddress;
  String? branchPincode;
  String? branchArea;

  factory AllBranchData.fromJson(Map<String, dynamic> json) => AllBranchData(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    branchMobile: json["branch_mobile"],
    branchAddress: json["branch_address"],
    branchPincode: json["branch_pincode"],
    branchArea: json["branch_area"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "branch_mobile": branchMobile,
    "branch_address": branchAddress,
    "branch_pincode": branchPincode,
    "branch_area": branchArea,
  };
}
