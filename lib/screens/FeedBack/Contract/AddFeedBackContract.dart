import 'package:bike_junction_customer/screens/FeedBack/Model/AddFeedbackModel.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';

abstract class AddFeedBackContract {
  void onAddFeedBackSuccess(AddFeedBackResponseModel feedBackModel);
  void onAddFeedBackFailure(FetchException exception);
}
