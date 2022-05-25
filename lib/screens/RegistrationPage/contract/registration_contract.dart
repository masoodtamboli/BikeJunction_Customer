import 'package:bike_junction_customer/screens/RegistrationPage/model/registration_model.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class RegistrationContract {
  void registrationSuccess(RegistrationModel responseModel);

  void registrationFailure(FetchException exception);
}
