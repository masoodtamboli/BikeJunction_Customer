import 'package:bike_junction_customer/screens/Dashboard/model/GetUpiDetailsModel.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class GetUpiDetailsContract {
  void getUpiDetailsSuccess(GetUpiDetailsResponseModel upiDetailsResponse);
  void getUpiDetailsError(FetchException exception);
}
