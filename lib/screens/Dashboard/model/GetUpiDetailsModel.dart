import 'dart:convert';

import 'dart:developer';

GetUpiDetailsResponseModel getUpiDetailsResponseModelFromJson(String str) =>
    GetUpiDetailsResponseModel.fromJson(json.decode(str));

String getUpiDetailsResponseModelToJson(GetUpiDetailsResponseModel data) =>
    json.encode(data.toJson());

class GetUpiDetailsResponseModel {
  GetUpiDetailsResponseModel({
    this.status,
    this.upiId,
    this.accountName,
  });

  String? status;
  String? upiId;
  String? accountName;

  factory GetUpiDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] == "1") {
      return GetUpiDetailsResponseModel(
        status: json["status"],
        upiId: json["upi"],
        accountName: json["account_name"],
      );
    } else {
      return GetUpiDetailsResponseModel(
        status: json["status"],
        upiId: "",
        accountName: "",
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (status == "1") {
      return {
        "status": status,
        "upi": upiId,
        "account_name": accountName,
      };
    } else {
      return {
        "status": status,
      };
    }
  }
}
