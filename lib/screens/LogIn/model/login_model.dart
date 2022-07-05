// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.customerMobile,
  });

  String? customerMobile;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      customerMobile: json["customer_mobile"],
    );
  }

  Map<String, dynamic> toJson() => {
        "customer_mobile": customerMobile,
      };
}

LoginResponseModel loginResponseModelFromJson(String str) {
  return LoginResponseModel.fromJson(json.decode(str));
}

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.objectError,
    this.error,
    this.message,
    this.data,
  });

  int? status;
  String? error;
  Error? objectError;
  Data? data;
  String? message;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] == 200) {
      return LoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
    } else if (json["status"] == 403) {
      return LoginResponseModel(
        status: json["status"],
        error: json["error"],
      );
    } else if (json["status"] == 409) {
      return LoginResponseModel(
        status: json["status"],
        objectError: Error.fromJson(json["error"]),
      );
    } else {
      return LoginResponseModel(
        status: json["status"],
        error: "Something went wrong!",
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (status == 200) {
      return {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
    } else if (status == 403) {
      return {
        "status": status,
        "error": error,
      };
    } else if (status == 409) {
      return {
        "status": status,
        "error": objectError,
      };
    } else {
      return {
        "status": status,
        "error": "Something went wrong!",
      };
    }
  }
}

class Error {
  Error({
    this.mobileNo,
  });

  String? mobileNo;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        mobileNo: json["mobile_no"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_no": mobileNo,
      };
}

class Data {
  Data({
    this.customerId,
    this.customerName,
  });

  String? customerId;
  String? customerName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerId: json["customer_id"],
        customerName:
            json["customer_name"] == null ? "" : json["customer_name"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
      };
}
