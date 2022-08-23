import 'package:bike_junction_customer/screens/AddPickUp/model/GetAllPostalCodesModel.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class GetAllPostalCodeContract {
  void getAllPostalCodeContractSuccess(
      GetAllPostalCodesResponseModel responseModel);
  void getAllPostalCodeContractFailure(FetchException exception);
}
