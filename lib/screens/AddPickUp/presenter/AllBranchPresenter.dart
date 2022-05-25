

import 'package:bike_junction_customer/dependencyInjection/injector.dart';
import 'package:bike_junction_customer/screens/AddPickUp/contract/AllBranchContract.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/webServices/repository/repository.dart';

class AllBranchPresenter{
  late Repository _repository;
  late AllBranchContract _view;

  AllBranchPresenter(this._view){
    _repository = Injector().repos;
  }

  void getAllBranches(url){
    _repository.getAllBranches(url)
        .then((value) => _view.getAllBranchesSuccess(value))
        .onError((error, stackTrace) => _view.getAllBranchesFailure(FetchException(error.toString())));
  }
}