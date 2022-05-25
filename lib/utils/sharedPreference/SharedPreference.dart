import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String isLogin = "isLogin";
 // static String isFirstTime = "isFirstTime";
  static String customerId = "customerId";
 // static String companyId = "companyId";
  static String customerName = "customerName";
  static String customerAddress = "customerAddress";
  static String branchId = "branchId";
  static String customerNumber = "customerNumber";


  static Future<SharedPreferences> get _instance async =>
      _prefsInstance = await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<bool> setIsLogin(bool value) async {
    var prefs = await _instance;
    return prefs.setBool(isLogin, value);
  }

  static getIsLogin() {
    return _prefsInstance.getBool(isLogin) ?? false;
  }

  static Future<bool> setCustomerName(String name) async {
    var prefs = await _instance;
    return prefs.setString(customerName, name);
  }

  static getCustomerName() {
    return _prefsInstance.getString(customerName) ?? '';
  }

  static Future<bool> setCustomerId(int id) async {
    var prefs = await _instance;
    return prefs.setInt(customerId, id);
  }

  static getCustomerId() {
    return _prefsInstance.getInt(customerId) ?? 0;
  }

  static Future<bool> setBranchId(int id) async {
    var prefs = await _instance;
    return prefs.setInt(branchId, id);
  }

  static getBranchId() {
    return _prefsInstance.getInt(branchId) ?? 0;
  }


  static Future<bool> setCustomerAddress(String address) async {
    var prefs = await _instance;
    return prefs.setString(customerAddress, address);
  }

  static getCustomerAddress() {
    return _prefsInstance.getString(customerAddress) ?? "";
  }

  static Future<bool> setCustomerMobile(String mobile) async {
    var prefs = await _instance;
    return prefs.setString(customerNumber, mobile);
  }

  static getCustomerMobile() {
    return _prefsInstance.getString(customerNumber) ?? "";
  }






}
