import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetAllBrandsModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetModelName.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class AddPickUpContract {
  void addPickUpSuccess(AddPickUpResponseModel responseModel);

  void addPickUpFailure(FetchException exception);

  void getBrandSuccess(GetAllBrandsModel responseModel);

  void getBrandFailure(FetchException exception);

  void getBrandModelSuccess(GetModelName responseModel);

  void getBrandModelFailure(FetchException exception);
}
