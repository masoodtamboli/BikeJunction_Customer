import 'dart:developer';

import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/LogIn/contractor/login_contract.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class LoginPresenter {
  late Repository _repository;
  late LoginContract _view;

  LoginPresenter(this._view) {
    _repository = Injector().repos;
  }

  void login(loginRequestModel, url) {
    _repository
        .login(loginRequestModel, url)
        .then((value) => _view.loginSuccess(value))
        .onError((error, stackTrace) {
      _view.loginFailure(FetchException(error.toString()));
    });
  }
}
