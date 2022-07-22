import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/Dashboard/contract/GetUpiDetailsContract.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class GetUpiDetailsPresenter {
  late Repository _repository;
  late GetUpiDetailsContract _view;
  GetUpiDetailsPresenter(this._view) {
    _repository = Injector().repos;
  }

  void getUpiDetails(url) {
    _repository
        .getUpiDetails(url)
        .then((value) => _view.getUpiDetailsSuccess(value))
        .onError((error, stackTrace) =>
            _view.getUpiDetailsError(FetchException(error.toString())));
  }
}
