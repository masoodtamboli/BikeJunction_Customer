import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/AddPickUp/contract/GetAllPostalContract.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class GetAllPostalCodePresenter {
  late Repository _repository;
  late GetAllPostalCodeContract _view;

  GetAllPostalCodePresenter(this._view) {
    _repository = Injector().repos;
  }

  void getAllPostalCodes(url) {
    _repository
        .getAllPostalCodes(url)
        .then((value) => _view.getAllPostalCodeContractSuccess(value))
        .onError((error, stackTrace) => _view
            .getAllPostalCodeContractFailure(FetchException(error.toString())));
  }
}
