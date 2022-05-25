import 'dart:convert';

GetAllBrandsModel getAllBrandsModelFromJson(String str) =>
    GetAllBrandsModel.fromJson(json.decode(str));

String getAllBrandsModelToJson(GetAllBrandsModel data) =>
    json.encode(data.toJson());

class GetAllBrandsModel {
  GetAllBrandsModel({
    this.status,
    this.data,
  });

  int? status;
  List<AllBrandData>? data;

  factory GetAllBrandsModel.fromJson(Map<String, dynamic> json) => GetAllBrandsModel(
    status: json["status"],
    data: List<AllBrandData>.from(json["data"].map((x) => AllBrandData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AllBrandData {
  AllBrandData({
    String? id,
    String? brandName,
  }) {
    _id = id;
    _brandName = brandName;
  }

  AllBrandData.fromJson(dynamic json) {
    _id = json['id'];
    _brandName = json['brand_name'];
  }

  String? _id;
  String? _brandName;

  String? get id => _id;

  String? get brandName => _brandName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['brand_name'] = _brandName;
    return map;
  }
}
