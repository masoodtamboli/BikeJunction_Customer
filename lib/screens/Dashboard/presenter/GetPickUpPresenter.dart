import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/AddPickUp/contract/AddPickUpContract.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/contract/GetPickUpContract.dart';

import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class GetPickUpPresenter {
  late Repository _repository;
  late GetPickUpContract _view;

  GetPickUpPresenter(this._view) {
    _repository = Injector().repos;
  }

  void getPickups(url) {
    _repository
        .getAllPickUp(url)
        .then((value) => _view.getPickUpSuccess(value))
        .onError((error, stackTrace) =>
            _view.getPickUpFailure(FetchException(error.toString())));
  }

  void getMyPickups(url) {
    _repository
        .getAllPickUp(url)
        .then((value) => _view.getPickUpSuccess(value))
        .onError((error, stackTrace) =>
            _view.getPickUpFailure(FetchException(error.toString())));
  }
}
