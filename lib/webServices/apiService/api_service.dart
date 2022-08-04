import 'dart:convert';
import 'dart:developer';

import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/AllBranchModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetAllBrandsModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetModelName.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetPickupDataModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetUpiDetailsModel.dart';
import 'package:bike_junction_customer/screens/FeedBack/Model/AddFeedbackModel.dart';
import 'package:bike_junction_customer/screens/LogIn/model/login_model.dart';
import 'package:bike_junction_customer/screens/LogIn/model/verify_otp_model.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/model/registration_model.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';
import 'package:http/http.dart' as http;

class ApiService implements Repository {
  // Base url
  String baseUrl = "https://bikejunction.co/1z8op_api/api/index.php/";

  //String baseUrlAddPickUp = "https://bikejunction.co/1z8op_api/api/";

  // Body header
  Map<String, String> header = {"Content-Type": "application/json"};

  String exceptionMessage = "Something went wrong, Please try again later";

  @override
  Future<LoginResponseModel> login(loginRequestModel, url) {
    var newUrl = Uri.parse(baseUrl + url);
    return http
        .post(newUrl,
            headers: header, body: loginRequestModelToJson(loginRequestModel))
        .then((http.Response response) {
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      return loginResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<VerifyOtpResponseModel> verify(verifyOtpRequestModel, url) {
    var newUrl = Uri.parse(baseUrl + url);
    print(verifyOtpRequestModelToJson(verifyOtpRequestModel));
    return http
        .post(newUrl,
            headers: header,
            body: verifyOtpRequestModelToJson(verifyOtpRequestModel))
        .then((http.Response response) {
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return verifyOtpResponseModelFromJson(response.body.toString());
    });
  }

//all branches
  @override
  Future<AllBranchResponseModel> getAllBranches(url) {
    var newUrl = Uri.parse(baseUrl + url);
    print(newUrl);
    return http.post(newUrl).then((http.Response response) {
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      //  print(response.body.toString());
      return allBranchResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddPickUpResponseModel> addPickUp(addPickUpRequestModel, url) {
    var newUrl = Uri.parse(baseUrl + url);
    print(newUrl);
    print(addPickUpRequestModelToJson(addPickUpRequestModel));
    return http
        .post(newUrl,
            headers: header,
            body: addPickUpRequestModelToJson(addPickUpRequestModel))
        .then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return addPickUpResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<RegistrationModel> signup(registrationModel, url) {
    var newUrl = Uri.parse(baseUrl + url);
    print(newUrl);
    print(registrationRequestModelToJson(registrationModel));
    return http
        .post(newUrl,
            headers: header,
            body: registrationRequestModelToJson(registrationModel))
        .then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return registrationModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddFeedBackResponseModel> addFeedback(addFeedbackRequestModel, url) {
    var newUrl = Uri.parse(baseUrl + url);
    print(newUrl);
    print(addFeedbackRequestModelToJson(addFeedbackRequestModel));
    return http
        .post(newUrl,
            headers: header,
            body: addFeedbackRequestModelToJson(addFeedbackRequestModel))
        .then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return addFeedBackResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetPickupDataModel> getAllPickUp(url) {
    var newUrl = Uri.parse(baseUrl + url);

    return http.post(newUrl).then((http.Response response) {
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return getPickupDataModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetAllBrandsModel> getBrand(url) {
    var newUrl = Uri.parse(baseUrl + url);
    return http.post(newUrl).then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return getAllBrandsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetModelName> getBrandModel(url) {
    var newUrl = Uri.parse(baseUrl + url);
    return http.post(newUrl).then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return getModelNameFromJson(response.body.toString());
    });
  }

  @override
  Future<GetUpiDetailsResponseModel> getUpiDetails(url) {
    var newUrl = Uri.parse(baseUrl + url);
    return http.post(newUrl).then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode > 300) {
        throw Exception(exceptionMessage);
      }
      print(response.body.toString());
      return getUpiDetailsResponseModelFromJson(response.body.toString());
    });
  }
}
