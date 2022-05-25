import 'package:bike_junction_customer/screens/LogIn/model/login_model.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class LoginContract{
  void loginSuccess(LoginResponseModel responseModel);
  void loginFailure(FetchException exception);
}