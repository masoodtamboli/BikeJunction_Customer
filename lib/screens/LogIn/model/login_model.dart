// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

import 'dart:developer';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.customerMobile,
  });

  String? customerMobile;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        customerMobile: json["customer_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "customer_mobile": customerMobile,
      };
}

LoginResponseModel loginResponseModelFromJson(String str) {
  dynamic test = json.decode(str);
  log("Hello ${test['message']}");
  return LoginResponseModel.fromJson(json.decode(str));
}

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.customerId,
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.customerPincode,
    this.customerVehicleno,
    this.customerEmail,
    this.branchId,
    this.customerCreatedAt,
    this.customerUpdatedAt,
    this.otpToken,
    this.otpSms,
  });

  String? customerId;
  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerPincode;
  dynamic customerVehicleno;
  String? customerEmail;
  String? branchId;
  String? customerCreatedAt;
  dynamic customerUpdatedAt;
  String? otpToken;
  String? otpSms;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerId: json["customer_id"],
        customerName:
            json["customer_name"] == null ? "" : json["customer_name"],
        customerMobile:
            json["customer_mobile"] == null ? "" : json["customer_mobile"],
        customerAddress:
            json["customer_address"] == null ? "" : json["customer_address"],
        customerPincode:
            json["customer_pincode"] == null ? "" : json["customer_pincode"],
        customerVehicleno: json["customer_vehicleno"] == null
            ? ""
            : json["customer_vehicleno"],
        customerEmail: json["customer_email"],
        branchId: json["branch_id"],
        customerCreatedAt: json["customer_created_at"],
        customerUpdatedAt: json["customer_updated_at"],
        otpToken: json["otp_token"],
        otpSms: json["otp_sms"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "customer_address": customerAddress,
        "customer_pincode": customerPincode,
        "customer_vehicleno": customerVehicleno,
        "customer_email": customerEmail,
        "branch_id": branchId,
        "customer_created_at": customerCreatedAt,
        "customer_updated_at": customerUpdatedAt,
        "otp_token": otpToken,
        "otp_sms": otpSms,
      };
}
