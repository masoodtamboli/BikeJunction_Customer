import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/contract/registration_contract.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class RegistrationPresenter {
  late Repository _repository;
  late RegistrationContract _view;

  RegistrationPresenter(this._view) {
    _repository = Injector().repos;
  }

  void registration(registrationModel, url) {
    _repository
        .signup(registrationModel, url)
        .then((value) => _view.registrationSuccess(value))
        .onError((error, stackTrace) =>
            _view.registrationFailure(FetchException(error.toString())));
  }
}
