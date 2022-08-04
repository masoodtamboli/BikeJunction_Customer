import 'dart:convert';

AddFeedbackRequestModel addFeedbackRequestModelFromJson(String str) =>
    AddFeedbackRequestModel.fromJson(json.decode(str));

String addFeedbackRequestModelToJson(AddFeedbackRequestModel data) =>
    json.encode(data.toJson());

class AddFeedbackRequestModel {
  AddFeedbackRequestModel({
    this.name,
    this.vehicleNo,
    this.mobileNo,
    this.deliveryDate,
    this.stars,
    this.branchId,
    this.branchName,
    this.customerId,
  });

  String? name;
  String? vehicleNo;
  String? mobileNo;
  String? deliveryDate;
  String? stars;
  int? branchId;
  String? branchName;
  int? customerId;

  factory AddFeedbackRequestModel.fromJson(Map<String, dynamic> json) =>
      AddFeedbackRequestModel(
        name: json["name"],
        vehicleNo: json["bikenumber"],
        mobileNo: json["mobile"],
        deliveryDate: json["deliverydate"],
        stars: json["stars"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bikenumber": vehicleNo,
        "mobile": mobileNo,
        "deliverydate": deliveryDate,
        "stars": stars,
        "branch_id": branchId,
        "branch_name": branchName,
        "customer_id": customerId,
      };
}

AddFeedBackResponseModel addFeedBackResponseModelFromJson(String str) =>
    AddFeedBackResponseModel.fromJson(json.decode(str));

String addFeedBackResponseModelToJson(AddFeedBackResponseModel data) =>
    json.encode(data.toJson());

class AddFeedBackResponseModel {
  AddFeedBackResponseModel({
    this.status,
    this.error,
    this.messages,
  });

  int? status;
  String? error;
  String? messages;

  factory AddFeedBackResponseModel.fromJson(Map<String, dynamic> json) =>
      AddFeedBackResponseModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"]["success"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages,
      };
}
