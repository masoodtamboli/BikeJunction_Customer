import 'dart:convert';

GetModelName getModelNameFromJson(String str) =>
    GetModelName.fromJson(json.decode(str));

String getModelNameToJson(GetModelName data) => json.encode(data.toJson());

class GetModelName {
  GetModelName({
    int? status,
    dynamic error,
    List<ModelData>? data,
  }) {
    _status = status;
    _error = error;
    _data = data;
  }

  GetModelName.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ModelData.fromJson(v));
      });
    }
  }

  int? _status;
  dynamic _error;
  List<ModelData>? _data;

  int? get status => _status;

  dynamic get error => _error;

  List<ModelData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ModelData {
  ModelData({
    String? id,
    String? brandId,
    String? vehicleModel,
  }) {
    _id = id;
    _brandId = brandId;
    _vehicleModel = vehicleModel;
  }

  ModelData.fromJson(dynamic json) {
    _id = json['id'];
    _brandId = json['brand_id'];
    _vehicleModel = json['vehicle_model'];
  }

  String? _id;
  String? _brandId;
  String? _vehicleModel;

  String? get id => _id;

  String? get brandId => _brandId;

  String? get vehicleModel => _vehicleModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['brand_id'] = _brandId;
    map['vehicle_model'] = _vehicleModel;
    return map;
  }
}
