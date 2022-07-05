import 'dart:convert';

RegistrationRequestModel registrationRequestModelFromJson(String str) =>
    RegistrationRequestModel.fromJson(json.decode(str));

String registrationRequestModelToJson(RegistrationRequestModel data) =>
    json.encode(data.toJson());

class RegistrationRequestModel {
  RegistrationRequestModel(
      {this.name,
      this.mobile,
      this.address,
      this.pincode,
      this.customerEmail,
      this.branchId});

  String? name;
  String? mobile;
  String? address;
  String? pincode;
  String? customerEmail;
  String? branchId;

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) =>
      RegistrationRequestModel(
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        pincode: json["pincode"],
        customerEmail: json["email"],
        branchId: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "address": address,
        "pincode": pincode,
        "email": customerEmail,
        "branch_id": branchId,
      };
}

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    this.status,
    this.error,
    this.objectError,
    this.message,
    this.data,
  });

  int? status;
  String? error;
  Error? objectError;
  String? message;
  Data? data;

  factory RegistrationModel.fromJson(dynamic json) {
    if (json["status"] == 200) {
      return RegistrationModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
    } else if (json["status"] == 403) {
      return RegistrationModel(
        status: json["status"],
        objectError: Error.fromJson(json["error"]),
      );
    } else if (json["status"] == 409) {
      return RegistrationModel(
        status: json["status"],
        objectError: Error.fromJson(json["error"]),
      );
    } else {
      return RegistrationModel(
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
        "error": objectError,
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
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.customerPincode,
    this.customerEmail,
    this.branchId,
  });

  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerPincode;
  String? customerVehicleNo;
  String? customerEmail;
  String? branchId;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        customerPincode: json["customer_pincode"],
        customerEmail: json["customer_email"],
        branchId: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "customer_address": customerAddress,
        "customer_pincode": customerPincode,
        "customer_vehicleno": customerVehicleNo,
        "customer_email": customerEmail,
        "branch_id": branchId,
      };
}

class Data {
  Data({
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.customerPincode,
    this.customerVehicleNo,
    this.customerEmail,
    this.branchId,
    this.id,
  });

  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerPincode;
  String? customerVehicleNo;
  String? customerEmail;
  String? branchId;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        customerPincode: json["customer_pincode"],
        customerVehicleNo: json["customer_vehicleno"],
        customerEmail: json["customer_email"],
        branchId: json["branch_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "customer_address": customerAddress,
        "customer_pincode": customerPincode,
        "customer_vehicleno": customerVehicleNo,
        "customer_email": customerEmail,
        "branch_id": branchId,
        "id": id,
      };
}
