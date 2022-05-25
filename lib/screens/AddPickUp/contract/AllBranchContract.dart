

import 'package:bike_junction_customer/screens/AddPickUp/model/AllBranchModel.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class AllBranchContract{
  void getAllBranchesSuccess(AllBranchResponseModel responseModel);
  void getAllBranchesFailure(FetchException exception);
}