

import 'package:bike_junction_customer/webServices/apiService/api_service.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repository get repos {
    return new ApiService();
  }
}