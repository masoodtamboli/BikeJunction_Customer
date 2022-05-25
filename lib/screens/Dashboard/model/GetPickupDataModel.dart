import 'dart:convert';

GetPickupDataModel getPickupDataModelFromJson(String str) =>
    GetPickupDataModel.fromJson(json.decode(str));

String getPickupDataModelToJson(GetPickupDataModel data) =>
    json.encode(data.toJson());

class GetPickupDataModel {
  GetPickupDataModel({
    int? status,
    dynamic error,
    List<GetPickupData>? data,
  }) {
    _status = status;
    _error = error;
    _data = data;
  }

  GetPickupDataModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetPickupData.fromJson(v));
      });
    }
  }

  int? _status;
  dynamic _error;
  List<GetPickupData>? _data;

  int? get status => _status;

  dynamic get error => _error;

  List<GetPickupData>? get data => _data;

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

class GetPickupData {
  GetPickupData({
    String? pickupId,
    String? pickupName,
    String? pickupBikenumber,
    String? pickupBikebrand,
    String? pickupBikemodel,
    String? pickupAddress,
    String? pickupDate,
    String? pickupTime,
    String? pickupIssues,
    String? pickupServices,
    String? pickupMobileno,
    String? pickupImages,
    String? pickupStatus,
    String? branchId,
    String? branchName,
    String? pickupCreatedAt,
    String? pickupUpdatedAt,
    dynamic jobId,
    String? customerId,
  }) {
    _pickupId = pickupId;
    _pickupName = pickupName;
    _pickupBikenumber = pickupBikenumber;
    _pickupBikebrand = pickupBikebrand;
    _pickupBikemodel = pickupBikemodel;
    _pickupAddress = pickupAddress;
    _pickupDate = pickupDate;
    _pickupTime = pickupTime;
    _pickupIssues = pickupIssues;
    _pickupServices = pickupServices;
    _pickupMobileno = pickupMobileno;
    _pickupImages = pickupImages;
    _pickupStatus = pickupStatus;
    _branchId = branchId;
    _branchName = branchName;
    _pickupCreatedAt = pickupCreatedAt;
    _pickupUpdatedAt = pickupUpdatedAt;
    _jobId = jobId;
    _customerId = customerId;
    _currentState = 0;
  }

  GetPickupData.fromJson(dynamic json) {
    _pickupId = json['pickup_id'];
    _pickupName = json['pickup_name'];
    _pickupBikenumber = json['pickup_bikenumber'];
    _pickupBikebrand = json['pickup_bikebrand'];
    _pickupBikemodel = json['pickup_bikemodel'];
    _pickupAddress = json['pickup_address'];
    _pickupDate = json['pickup_date'];
    _pickupTime = json['pickup_time'];
    _pickupIssues = json['pickup_issues'];
    _pickupServices = json['pickup_services'];
    _pickupMobileno = json['pickup_mobileno'];
    _pickupImages = json['pickup_images'];
    _pickupStatus = json['pickup_status'];
    _branchId = json['branch_id'];
    _branchName = json['branch_name'];
    _pickupCreatedAt = json['pickup_created_at'];
    _pickupUpdatedAt = json['pickup_updated_at'];
    _jobId = json['job_id'];
    _customerId = json['customer_id'];
  }

  String? _pickupId;
  String? _pickupName;
  String? _pickupBikenumber;
  String? _pickupBikebrand;
  String? _pickupBikemodel;
  String? _pickupAddress;
  String? _pickupDate;
  String? _pickupTime;
  String? _pickupIssues;
  String? _pickupServices;
  String? _pickupMobileno;
  String? _pickupImages;
  String? _pickupStatus;
  String? _branchId;
  String? _branchName;
  String? _pickupCreatedAt;
  String? _pickupUpdatedAt;
  dynamic _jobId;
  String? _customerId;
  int? _currentState;

  String? get pickupId => _pickupId;

  String? get pickupName => _pickupName;

  String? get pickupBikenumber => _pickupBikenumber;

  String? get pickupBikebrand => _pickupBikebrand;

  String? get pickupBikemodel => _pickupBikemodel;

  String? get pickupAddress => _pickupAddress;

  String? get pickupDate => _pickupDate;

  String? get pickupTime => _pickupTime;

  String? get pickupIssues => _pickupIssues;

  String? get pickupServices => _pickupServices;

  String? get pickupMobileno => _pickupMobileno;

  String? get pickupImages => _pickupImages;

  String? get pickupStatus => _pickupStatus;

  String? get branchId => _branchId;

  String? get branchName => _branchName;

  String? get pickupCreatedAt => _pickupCreatedAt;

  String? get pickupUpdatedAt => _pickupUpdatedAt;

  dynamic get jobId => _jobId;

  String? get customerId => _customerId;

  int? get currentState => _currentState;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pickup_id'] = _pickupId;
    map['pickup_name'] = _pickupName;
    map['pickup_bikenumber'] = _pickupBikenumber;
    map['pickup_bikebrand'] = _pickupBikebrand;
    map['pickup_bikemodel'] = _pickupBikemodel;
    map['pickup_address'] = _pickupAddress;
    map['pickup_date'] = _pickupDate;
    map['pickup_time'] = _pickupTime;
    map['pickup_issues'] = _pickupIssues;
    map['pickup_services'] = _pickupServices;
    map['pickup_mobileno'] = _pickupMobileno;
    map['pickup_images'] = _pickupImages;
    map['pickup_status'] = _pickupStatus;
    map['branch_id'] = _branchId;
    map['branch_name'] = _branchName;
    map['pickup_created_at'] = _pickupCreatedAt;
    map['pickup_updated_at'] = _pickupUpdatedAt;
    map['job_id'] = _jobId;
    map['customer_id'] = _customerId;
    return map;
  }
}
