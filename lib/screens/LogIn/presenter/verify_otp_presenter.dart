import 'dart:developer';

import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/LogIn/contractor/login_contract.dart';
import 'package:bike_junction_customer/screens/LogIn/contractor/verify_otp_contract.dart';
import 'package:bike_junction_customer/screens/LogIn/model/verify_otp_model.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class VerifyOtpPresenter {
  late Repository _repository;
  late VerifyOtpContract _view;

  VerifyOtpPresenter(this._view) {
    _repository = Injector().repos;
  }

  void verify(verifyOtpRequestModel, url) {
    _repository
        .verify(verifyOtpRequestModel, url)
        .then((value) => _view.verifyOtpSuccess(value))
        .onError((error, stackTrace) {
      log("$error  \n $stackTrace");
      _view.verifyOtpFailure(FetchException(error.toString()));
    });
  }
}
