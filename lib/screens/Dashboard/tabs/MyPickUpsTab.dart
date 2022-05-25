import 'package:bike_junction_customer/screens/Dashboard/contract/GetPickUpContract.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetPickupDataModel.dart';
import 'package:bike_junction_customer/screens/Dashboard/presenter/GetPickUpPresenter.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyPickUpsTab extends StatefulWidget {
  const MyPickUpsTab({Key? key}) : super(key: key);

  @override
  _MyPickUpsTabState createState() => _MyPickUpsTabState();
}

class _MyPickUpsTabState extends State<MyPickUpsTab>
    implements GetPickUpContract {
  late GetPickUpPresenter getPickUpPresenter;
  late CheckInternet checkInternet;
  bool isLoading = false;
  late List<GetPickupData> getPickUpDataList;

  @override
  initState() {
    checkInternet = CheckInternet();
    getPickUpDataList = [];
    super.initState();
    checkConnection();
  }

  checkConnection() {
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
        .getPickups('getMyPickups/${SharedPreference.getCustomerId()}');
  }

  _MyPickUpsTabState() {
    getPickUpPresenter = GetPickUpPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: MyColors.screen_background,
      child: ListView.builder(
          itemCount: getPickUpDataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: [
                  myPickUpCard(
                    getPickUpDataList[index],
                  )
                ],
              ),
            );
          })

      /*SingleChildScrollView(
        child: Column(
          children: [
            myPickUpCard(
              "MH12PD9735",
              "Scooty Pep+",
              "135",
              "Sat Oct 9 01:10 PM",
              "Karwenagar,Pune",
            )
          ],
        ),
      )*/
      ,
    );
  }

  Widget myPickUpCard(
    GetPickupData getPickupData,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.h),
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.h, right: 1.h),
              child: Container(
                color: getPickupData.pickupStatus == "Done"
                    ? MyColors.creamGreen
                    : MyColors.red,
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
                            getPickupData.pickupBikemodel!,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.normal),
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
    );
  }

  @override
  void getPickUpFailure(FetchException exception) {
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void getPickUpSuccess(GetPickupDataModel responseModel) {
    if (responseModel.status == 1) {
      setState(() {
        getPickUpDataList.addAll(responseModel.data!);
      });
    }
  }
}
