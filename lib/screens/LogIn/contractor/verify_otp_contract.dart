import 'package:bike_junction_customer/screens/LogIn/model/login_model.dart';
import 'package:bike_junction_customer/screens/LogIn/model/verify_otp_model.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class VerifyOtpContract{
  void verifyOtpSuccess(VerifyOtpResponseModel responseModel);
  void verifyOtpFailure(FetchException exception);
}