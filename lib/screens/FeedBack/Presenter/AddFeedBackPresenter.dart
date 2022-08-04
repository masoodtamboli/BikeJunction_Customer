import 'dart:developer';

import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/FeedBack/Contract/AddFeedBackContract.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class AddFeedBackPresenter {
  late Repository _repository;
  late AddFeedBackContract _view;

  AddFeedBackPresenter(this._view) {
    _repository = Injector().repos;
  }
  void addFeedback(addFeedbackRequestModel, url) {
    _repository
        .addFeedback(addFeedbackRequestModel, url)
        .then((value) => _view.onAddFeedBackSuccess(value))
        .onError((error, stackTrace) {
      _view.onAddFeedBackFailure(FetchException(error.toString()));
    });
  }
}
