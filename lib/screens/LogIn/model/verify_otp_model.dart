// To parse this JSON data, do
//
//     final verifyOtpRequestModel = verifyOtpRequestModelFromJson(jsonString);

import 'dart:convert';

import 'dart:developer';

VerifyOtpRequestModel verifyOtpRequestModelFromJson(String str) =>
    VerifyOtpRequestModel.fromJson(json.decode(str));

String verifyOtpRequestModelToJson(VerifyOtpRequestModel data) =>
    json.encode(data.toJson());

class VerifyOtpRequestModel {
  VerifyOtpRequestModel({
    this.otpSms,
    this.customerId,
  });

  String? otpSms;
  String? customerId;

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequestModel(
        otpSms: json["otp"], customerId: json["customer_id"]);
  }

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "otp": otpSms,
      };
}

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) =>
    VerifyOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) =>
    json.encode(data.toJson());

class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  CustomerData? data;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      status: json["status"],
      message: json["message"],
      data: CustomerData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class CustomerData {
  CustomerData({
    this.customerId,
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.customerPincode,
    this.customerEmail,
    this.branchId,
  });

  String? customerId;
  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerPincode;
  String? customerEmail;
  String? branchId;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        customerPincode: json["customer_pincode"],
        customerEmail: json["customer_email"],
        branchId: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "customer_address": customerAddress,
        "customer_pincode": customerPincode,
        "customer_email": customerEmail,
        "branch_id": branchId,
      };
}
