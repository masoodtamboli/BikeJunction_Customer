import 'dart:developer';

import 'package:bike_junction_customer/screens/Dashboard/contract/GetPickUpContract.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetPickupDataModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/presenter/GetPickUpPresenter.dart';
import 'package:bike_junction_customer/screens/ViewPickUp/ViewPickUp.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:bike_junction_customer/utils/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class CurrentPickUpsTab extends StatefulWidget {
  static final GlobalKey<_CurrentPickUpsTabState> globalKey = GlobalKey();

  CurrentPickUpsTab() : super(key: globalKey);

  @override
  _CurrentPickUpsTabState createState() => _CurrentPickUpsTabState();
}

class _CurrentPickUpsTabState extends State<CurrentPickUpsTab>
    implements GetPickUpContract {
  late GetPickUpPresenter getPickUpPresenter;
  late CheckInternet checkInternet;
  bool isLoading = false;
  late List<GetPickupData> getPickUpDataList;
  bool isDataFound = false;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: MyColors.app_theme_color),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("NOTE"),
      content: Text(
        "We also sell and buy second hand Bikes",
        style: TextStyle(color: MyColors.grey_text_color),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  initState() {
    checkInternet = CheckInternet();
    getPickUpDataList = [];
    super.initState();
    checkConnection();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => showAlertDialog(context));
  }

  _CurrentPickUpsTabState() {
    getPickUpPresenter = GetPickUpPresenter(this);
  }

  checkConnection() {
    getPickUpDataList.clear();
    checkInternet.check().then((value) {
      if (value) {
        getPickups();
      } else {}
    });
  }

  getPickups() {
    setState(() {
      isLoading = true;
    });
    getPickUpPresenter
        .getPickups('getCurrentPickups/${SharedPreference.getCustomerId()}');
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          )
        : RefreshIndicator(
            color: MyColors.app_theme_color,
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  checkConnection();
                });
              });
            },
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: MyColors.screen_background,
                  child: ListView.builder(
                      itemCount: getPickUpDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              currentPickUpCard(
                                getPickUpDataList[index],
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Visibility(
                  visible: !isDataFound,
                  child: Center(
                    child: Text("No Data Found!"),
                  ),
                ),
              ],
            ),
          );
  }

  //current pickup card
  Widget currentPickUpCard(
    GetPickupData getPickupData,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewPickUp(getPickupData: getPickupData)));
        },
        child: Card(
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 1.h, right: 1.h),
                child: Container(
                  color: getPickupData.pickupStatus == "In Active" ||
                          getPickupData.pickupStatus == "Rejected"
                      ? MyColors.red
                      : MyColors.creamGreen,
                  width: 2.h,
                  height: 5.h,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 2.h, bottom: 2.h, left: 1.h, right: 1.h),
                  child: Column(
                    children: [
                      //vehicle no, model, order no
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              getPickupData.pickupBikenumber!,
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              getPickupData.pickupBikebrand!,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "# ${getPickupData.pickupId}",
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Divider(
                        height: 1.h,
                        thickness: 0.2.h,
                        color: MyColors.grey_text_color,
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Pickup Time: ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: MyColors.grey_text_color,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              getPickupData.pickupDate!,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Pickup Address: ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: MyColors.grey_text_color,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              getPickupData.pickupAddress!,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void getPickUpFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    log("$exception");
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void getPickUpSuccess(GetPickupDataModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 1) {
      setState(() {
        if (responseModel.data != null) {
          getPickUpDataList.addAll(responseModel.data!);
          isDataFound = true;
        } else {
          isDataFound = false;
        }
      });
    }
  }
}
