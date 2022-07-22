import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/AllBranchModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetAllBrandsModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetModelName.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetPickupDataModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetUpiDetailsModel.dart';
import 'package:bike_junction_customer/screens/LogIn/model/login_model.dart';
import 'package:bike_junction_customer/screens/LogIn/model/verify_otp_model.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/model/registration_model.dart';

abstract class Repository {
  //signup
  Future<LoginResponseModel> login(loginRequestModel, url);

  //login
  Future<RegistrationModel> signup(registrationModel, url);

  //verify otp
  Future<VerifyOtpResponseModel> verify(verifyOtpRequestModel, url);

  //all branch
  Future<AllBranchResponseModel> getAllBranches(url);

  //add pickup
  Future<AddPickUpResponseModel> addPickUp(addPickUpRequestModel, url);

  //get all pickups
  Future<GetPickupDataModel> getAllPickUp(url);

  //get brand
  Future<GetAllBrandsModel> getBrand(url);

  //get brand model
  Future<GetModelName> getBrandModel(url);

  // Get Details of UPI
  Future<GetUpiDetailsResponseModel> getUpiDetails(url);
}
