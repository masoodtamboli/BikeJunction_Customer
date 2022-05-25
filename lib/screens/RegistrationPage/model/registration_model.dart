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
      this.vehicleno,
      this.customer_email,
      this.branch_id});

  String? name;
  String? mobile;
  String? address;
  String? pincode;
  String? vehicleno;
  String? customer_email;
  String? branch_id;

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) =>
      RegistrationRequestModel(
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        pincode: json["pincode"],
        vehicleno: json["vehicle_no"],
        customer_email: json["customer_email"],
        branch_id: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "address": address,
        "pincode": pincode,
        "vehicle_no": vehicleno,
        "customer_email": customer_email,
        "branch_id": branch_id,
      };
}

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    int? status,
    String? error,
    Messages? messages,
  }) {
    _status = status;
    _error = error;
    _messages = messages;
  }

  RegistrationModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    _messages =
        json['messages'] != null ? Messages.fromJson(json['messages']) : null;
  }

  int? _status;
  String? _error;
  Messages? _messages;

  int? get status => _status;

  String? get error => _error;

  Messages? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['error'] = _error;
    if (_messages != null) {
      map['messages'] = _messages?.toJson();
    }
    return map;
  }
}

/// success : "Customer created successfully"

class Messages {
  Messages({
    String? success,
  }) {
    _success = success;
  }

  Messages.fromJson(dynamic json) {
    _success = json['success'];
  }

  String? _success;

  String? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    return map;
  }
}
