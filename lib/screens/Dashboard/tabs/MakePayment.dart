import 'dart:developer';

import 'package:bike_junction_customer/screens/Dashboard/contract/GetUpiDetailsContract.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetUpiDetailsModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/presenter/GetUpiDetailsPresenter.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:upi_india/upi_india.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({Key? key}) : super(key: key);

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment>
    implements GetUpiDetailsContract {
  // UPI Objects and Variables
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextEditingController _amountController = TextEditingController();

  late CheckInternet checkInternet;
  late GetUpiDetailsPresenter getUpiDetailsPresenter;

  String upiId = '';
  String accountHolderName = '';

  _MakePaymentState() {
    getUpiDetailsPresenter = GetUpiDetailsPresenter(this);
  }

  @override
  void initState() {
    checkInternet = CheckInternet();
    checkConnection();
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  checkConnection() {
    checkInternet.check().then((value) {
      if (value) {
        getUpiDetails();
      } else {
        ShowMessage().showToast("Please Check your Internet connection");
      }
    });
  }

  void getUpiDetails() {
    getUpiDetailsPresenter = GetUpiDetailsPresenter(this);
    getUpiDetailsPresenter.getUpiDetails('getUpiId');
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    String note = 'Payment from ' +
        SharedPreference.getCustomerName() +
        ' with Customer Id ' +
        SharedPreference.getCustomerId().toString() +
        ' , Mobile Number ' +
        SharedPreference.getCustomerMobile().toString();

    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: upiId,
      receiverName: accountHolderName,
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: note,
      amount: double.parse(_amountController.text),
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        ShowMessage().showToast("Payment Successful");
        break;
      case UpiPaymentStatus.SUBMITTED:
        ShowMessage().showToast("Transaction Submitted");
        break;
      case UpiPaymentStatus.FAILURE:
        ShowMessage().showToast("Payment Failed");
        break;
      default:
        ShowMessage().showToast("Something went wrong!");
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
              child: Text(
            body,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 10.h, 0, 5.h),
              child: Container(
                child: Text(
                  "Make Payment",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          width: 85.w,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  Icons.money,
                  color: MyColors.app_theme_color,
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              contentPadding: EdgeInsets.only(left: 20),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.app_theme_color),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.app_theme_color),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Amount",
            ),
          ),
        ),
        displayUpiApps(),
        SizedBox(height: 20),
        FutureBuilder(
            future: _transaction,
            builder:
                (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      _upiErrorHandler(snapshot.error.runtimeType),
                      style: TextStyle(
                          color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  );
                }
              }
              if (snapshot.hasData) {
                UpiResponse _upiResponse = snapshot.data!;
                _checkTxnStatus(_upiResponse.status ?? "N/A");
              }
              return Container();
            }),
        Spacer(),
        Text("We also sell and buy second hand Bikes",
            style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic)),
        Spacer(),
      ],
    );
  }

  @override
  void getUpiDetailsError(FetchException exception) {
    ShowMessage().showToast("Failed to get UPI details");
  }

  @override
  void getUpiDetailsSuccess(GetUpiDetailsResponseModel upiDetailsResponse) {
    if (upiDetailsResponse.status == "1") {
      setState(() {
        upiId = upiDetailsResponse.upiId!;
        accountHolderName = upiDetailsResponse.accountName!;
        log("UPI Details: $upiId, $accountHolderName");
      });
    }
  }
}
