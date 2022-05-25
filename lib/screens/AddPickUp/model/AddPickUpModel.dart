// To parse this JSON data, do
//
//     final addPickUpRequestModel = addPickUpRequestModelFromJson(jsonString);

import 'dart:convert';

/*

AddPickUpRequestModel addPickUpRequestModelFromJson(String str) => AddPickUpRequestModel.fromJson(json.decode(str));

String addPickUpRequestModelToJson(AddPickUpRequestModel data) => json.encode(data.toJson());

class AddPickUpRequestModel {
  AddPickUpRequestModel({
    this.name,
    this.bikenumber,
    this.bikebrand,
    this.bikemodel,
    this.address,
    this.date,
    this.time,
    this.issues,
    this.services,
    this.mobileno,
    this.images,
    this.status,
    this.branch_id,
  });

  String? name;
  String? bikenumber;
  String? bikebrand;
  String? bikemodel;
  String? address;
  String? date;
  String? time;
  String? issues;
  String? services;
  String? mobileno;
  List<String>? images;
  String? status;
  String? branch_id;

  factory AddPickUpRequestModel.fromJson(Map<String, dynamic> json) => AddPickUpRequestModel(
    name: json["name"],
    bikenumber: json["bikenumber"],
    bikebrand: json["bikebrand"],
    bikemodel: json["bikemodel"],
    address: json["address"],
    date: json["date"],
    time: json["time"],
    issues: json["issues"],
    services: json["services"],
    mobileno: json["mobileno"],
    images: List<String>.from(json["images"].map((x) => x)),
    status: json["status"],
    branch_id: json["branch_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "bikenumber": bikenumber,
    "bikebrand": bikebrand,
    "bikemodel": bikemodel,
    "address": address,
    "date": date,
    "time": time,
    "issues": issues,
    "services": services,
    "mobileno": mobileno,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "status": status,
    "branch_id": branch_id,
  };
}
*/
// To parse this JSON data, do
//
//     final addPickUpRequestModel = addPickUpRequestModelFromJson(jsonString);

import 'dart:convert';

AddPickUpRequestModel addPickUpRequestModelFromJson(String str) =>
    AddPickUpRequestModel.fromJson(json.decode(str));

String addPickUpRequestModelToJson(AddPickUpRequestModel data) =>
    json.encode(data.toJson());

class AddPickUpRequestModel {
  AddPickUpRequestModel({
    this.user_id,
    this.name,
    this.bikenumber,
    this.bikebrand,
    this.bikemodel,
    this.address,
    this.date,
    this.time,
    this.issues,
    this.services,
    this.mobileno,
    this.images,
    this.status,
    this.branchId,
  });

  String? user_id;
  String? name;
  String? bikenumber;
  String? bikebrand;
  String? bikemodel;
  String? address;
  String? date;
  String? time;
  String? issues;
  String? services;
  String? mobileno;
  List<String>? images;
  String? status;
  String? branchId;

  factory AddPickUpRequestModel.fromJson(Map<String, dynamic> json) =>
      AddPickUpRequestModel(
        user_id: json["user_id"],
        name: json["name"],
        bikenumber: json["bikenumber"],
        bikebrand: json["bikebrand"],
        bikemodel: json["bikemodel"],
        address: json["address"],
        date: json["date"],
        time: json["time"],
        issues: json["issues"],
        services: json["services"],
        mobileno: json["mobileno"],
        images: List<String>.from(json["images"].map((x) => x)),
        status: json["status"],
        branchId: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "name": name,
        "bikenumber": bikenumber,
        "bikebrand": bikebrand,
        "bikemodel": bikemodel,
        "address": address,
        "date": date,
        "time": time,
        "issues": issues,
        "services": services,
        "mobileno": mobileno,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "status": status,
        "branch_id": branchId,
      };
}

AddPickUpResponseModel addPickUpResponseModelFromJson(String str) =>
    AddPickUpResponseModel.fromJson(json.decode(str));

String addPickUpResponseModelToJson(AddPickUpResponseModel data) =>
    json.encode(data.toJson());

class AddPickUpResponseModel {
  AddPickUpResponseModel({
    this.status,
    this.error,
    this.messages,
  });

  int? status;
  dynamic error;
  Messages? messages;

  factory AddPickUpResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPickUpResponseModel(
        status: json["status"],
        error: json["error"],
        messages: Messages.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages!.toJson(),
      };
}

class Messages {
  Messages({
    this.success,
  });

  String? success;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
