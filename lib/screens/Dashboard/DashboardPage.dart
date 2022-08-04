import 'dart:developer';

import 'package:bike_junction_customer/screens/AddPickUp/AddPickUpPage.dart';
import 'package:bike_junction_customer/screens/Dashboard/tabs/CurrentPickUps.dart';
import 'package:bike_junction_customer/screens/Dashboard/tabs/MakePayment.dart';
import 'package:bike_junction_customer/screens/Dashboard/tabs/MyPickUpsTab.dart';
import 'package:bike_junction_customer/screens/FeedBack/Contract/AddFeedBackContract.dart';
import 'package:bike_junction_customer/screens/FeedBack/Model/AddFeedbackModel.dart';
import 'package:bike_junction_customer/screens/FeedBack/Presenter/AddFeedBackPresenter.dart';
import 'package:bike_junction_customer/screens/LogIn/LogInScreen.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    implements AddFeedBackContract {
  late AddFeedBackPresenter addFeedBackPresenter;
  late AddFeedbackRequestModel addFeedbackRequestModel;
  late CheckInternet checkInternet;

  double overallRating = -1,
      serviceQuality = -1,
      serviceTimeliness = -1,
      serviceCost = -1,
      serviceTracking = -1;

  _DashboardPageState() {
    addFeedBackPresenter = AddFeedBackPresenter(this);
  }

  showAlertDialog(BuildContext context, bool isConfirm) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: MyColors.app_theme_color),
      ),
      onPressed: () {
        showAlertDialog(context, true);
      },
    );

    Widget cancelButton = TextButton(
      child: Text(
        "cancel",
        style: TextStyle(color: MyColors.app_theme_color),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget confirmAlertOkButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: MyColors.app_theme_color),
      ),
      onPressed: () {
        if (overallRating == -1) {
          ShowMessage().showToast("Please Add Rating");
        } else {
          checkConnection();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
    );

    Widget confirmAlertCancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: MyColors.app_theme_color),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Feedback"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Overall Rating",
            style: TextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 1.h),
          RatingBar.builder(
            initialRating: overallRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 20.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                overallRating = rating;
              });
            },
          ),
          SizedBox(height: 2.h),
          Text(
            "Service Quality",
            style: TextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 1.h),
          RatingBar.builder(
            initialRating: serviceQuality,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 20.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                serviceQuality = rating;
              });
            },
          ),
          SizedBox(height: 2.h),
          Text(
            "Service Timeliness",
            style: TextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 1.h),
          RatingBar.builder(
            initialRating: serviceTimeliness,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 20.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                serviceTimeliness = rating;
              });
            },
          ),
          SizedBox(height: 2.h),
          Text(
            "Service Cost",
            style: TextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 1.h),
          RatingBar.builder(
            initialRating: serviceCost,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 20.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                serviceCost = rating;
              });
            },
          ),
          SizedBox(height: 2.h),
          Text(
            "Service Tracking",
            style: TextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 1.h),
          RatingBar.builder(
            initialRating: serviceTracking,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 20.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                serviceTracking = rating;
              });
            },
          ),
        ],
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    AlertDialog confirmAlert = AlertDialog(
      title: Text("Alert"),
      content: Text("Submit Response?"),
      actions: [
        confirmAlertCancelButton,
        confirmAlertOkButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (isConfirm)
          return confirmAlert;
        else
          return alert;
      },
    );
  }

  addFeedBack() {
    addFeedbackRequestModel = AddFeedbackRequestModel();

    addFeedbackRequestModel.name = SharedPreference.getCustomerName();
    addFeedbackRequestModel.vehicleNo = "";
    addFeedbackRequestModel.mobileNo = SharedPreference.getCustomerMobile();
    addFeedbackRequestModel.deliveryDate = "";
    addFeedbackRequestModel.stars = overallRating.toString();
    addFeedbackRequestModel.branchId = SharedPreference.getBranchId();
    addFeedbackRequestModel.branchName = "";
    addFeedbackRequestModel.customerId = SharedPreference.getCustomerId();

    addFeedBackPresenter.addFeedback(addFeedbackRequestModel, "putfeedback");
  }

  checkConnection() {
    checkInternet.check().then((value) {
      if (value) {
        addFeedBack();
      } else {
        ShowMessage().showToast("No Internet Connection");
      }
    });
  }

  @override
  void initState() {
    checkInternet = CheckInternet();
    SharedPreference.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.app_theme_color,
          title: Row(
            children: [
              Text(
                "Bike",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Junction",
                style: TextStyle(color: MyColors.white),
              ),
            ],
          ),
          leading: Icon(Icons.person),
          actions: [
            IconButton(
              onPressed: () {
                showAlertDialog(context, false);
              },
              icon: Icon(Icons.feedback),
            ),
            IconButton(
              onPressed: () {
                SharedPreference.setIsLogin(false);
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LogInScreen()),
                      (route) => false);
                });
              },
              icon: Icon(Icons.logout_rounded),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                color: MyColors.screen_background,
                child: Column(
                  children: [
                    Material(
                      color: MyColors.app_theme_color,
                      child: TabBar(
                          physics: ScrollPhysics(),
                          labelColor: MyColors.creamYellow,
                          isScrollable: false,
                          unselectedLabelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 3.0, color: MyColors.creamYellow),
                              insets: EdgeInsets.symmetric(horizontal: 0.0)),
                          indicatorWeight: 2.0,
                          labelPadding:
                              EdgeInsets.only(left: 30.0, right: 30.0),
                          tabs: [
                            Tab(
                              child: Text(
                                "CURRENT PICKUPS",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "MY PICKUPS",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "PAYMENTS",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ]),
                    ),
                    Expanded(child: mainBody())
                  ],
                ),
              ),
            );
          }),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            _navigateAndDisplaySelection(context);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: MyColors.creamYellow,
            child: Icon(
              Icons.add,
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddPickUpPage()))
        .then((value) => setState(() {
              print("--$value");
              CurrentPickUpsTab.globalKey.currentState!.checkConnection();
            }));
  }

  Widget mainBody() {
    return TabBarView(
      physics: AlwaysScrollableScrollPhysics(),
      children: [CurrentPickUpsTab(), MyPickUpsTab(), MakePayment()],
    );
  }

  @override
  void onAddFeedBackFailure(FetchException exception) {
    ShowMessage().showToast("Something went wrong!");
  }

  @override
  void onAddFeedBackSuccess(AddFeedBackResponseModel feedBackModel) {
    if (feedBackModel.status == 1) {
      ShowMessage().showToast("Thank you for your feedback");
    } else {
      ShowMessage().showToast("Failed to add Feedback");
    }
  }
}
