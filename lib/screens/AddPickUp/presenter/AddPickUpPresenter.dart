import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/AddPickUp/contract/AddPickUpContract.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';

import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class AddPickUpPresenter {
  late Repository _repository;
  late AddPickUpContract _view;

  AddPickUpPresenter(this._view) {
    _repository = Injector().repos;
  }

  void addPickUp(addPickUpRequestModel, url) {
    _repository
        .addPickUp(addPickUpRequestModel, url)
        .then((value) => _view.addPickUpSuccess(value))
        .onError((error, stackTrace) =>
            _view.addPickUpFailure(FetchException(error.toString())));
  }

  void getBrand(url) {
    _repository
        .getBrand(url)
        .then((value) => _view.getBrandSuccess(value))
        .onError((error, stackTrace) =>
            _view.getBrandFailure(FetchException(error.toString())));
  }

  void getBrandModel(url) {
    _repository
        .getBrandModel(url)
        .then((value) => _view.getBrandModelSuccess(value))
        .onError((error, stackTrace) =>
            _view.getBrandModelFailure(FetchException(error.toString())));
  }
}
