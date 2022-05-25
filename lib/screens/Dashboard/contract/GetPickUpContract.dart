import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetPickupDataModel.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class GetPickUpContract {
  void getPickUpSuccess(GetPickupDataModel responseModel);

  void getPickUpFailure(FetchException exception);
}
