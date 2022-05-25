// To parse this JSON data, do
//
//     final verifyOtpRequestModel = verifyOtpRequestModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpRequestModel verifyOtpRequestModelFromJson(String str) => VerifyOtpRequestModel.fromJson(json.decode(str));

String verifyOtpRequestModelToJson(VerifyOtpRequestModel data) => json.encode(data.toJson());

class VerifyOtpRequestModel {
  VerifyOtpRequestModel({
    this.customerMobile,
    this.otpSms,
    this.otpToken,
  });

  String? customerMobile;
  String? otpSms;
  String? otpToken;

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) => VerifyOtpRequestModel(
    customerMobile: json["customer_mobile"],
    otpSms: json["otp_sms"],
    otpToken: json["otp_token"],
  );

  Map<String, dynamic> toJson() => {
    "customer_mobile": customerMobile,
    "otp_sms": otpSms,
    "otp_token": otpToken,
  };
}



VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());

class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
    this.status,
    this.data,
  });

  int? status;
  CustomerData? data;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponseModel(
    status: json["status"],
    data: CustomerData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
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
    this.customerVehicleno,
    this.customerEmail,
    this.branchId,
    this.customerCreatedAt,
    this.customerUpdatedAt,
    this.otpId,
    this.otpUserId,
    this.otpUserType,
    this.otpSms,
    this.otpMobile,
    this.otpToken,
    this.otpCreatedAt,
    this.otpUpdatedAt,
  });

  String? customerId;
  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerPincode;
  dynamic? customerVehicleno;
  String? customerEmail;
  String? branchId;
  String? customerCreatedAt;
  dynamic? customerUpdatedAt;
  String? otpId;
  String? otpUserId;
  String? otpUserType;
  String? otpSms;
  String? otpMobile;
  String? otpToken;
  String? otpCreatedAt;
  String? otpUpdatedAt;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerMobile: json["customer_mobile"],
    customerAddress: json["customer_address"],
    customerPincode: json["customer_pincode"],
    customerVehicleno: json["customer_vehicleno"],
    customerEmail: json["customer_email"],
    branchId: json["branch_id"],
    customerCreatedAt: json["customer_created_at"],
    customerUpdatedAt: json["customer_updated_at"],
    otpId: json["otp_id"],
    otpUserId: json["otp_user_id"],
    otpUserType: json["otp_user_type"],
    otpSms: json["otp_sms"],
    otpMobile: json["otp_mobile"],
    otpToken: json["otp_token"],
    otpCreatedAt: json["otp_created_at"],
    otpUpdatedAt: json["otp_updated_at"],
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
    "otp_id": otpId,
    "otp_user_id": otpUserId,
    "otp_user_type": otpUserType,
    "otp_sms": otpSms,
    "otp_mobile": otpMobile,
    "otp_token": otpToken,
    "otp_created_at": otpCreatedAt,
    "otp_updated_at": otpUpdatedAt,
  };
}

