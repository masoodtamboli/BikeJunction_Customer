import 'dart:developer';

import 'package:bike_junction_customer/screens/LogIn/LogInScreen.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/contract/registration_contract.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/model/registration_model.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/presenter/RegistrationPresenter.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyAssets.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    implements RegistrationContract {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerContactController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerPinCodeController = TextEditingController();
  late RegistrationPresenter registrationPresenter;
  late RegistrationRequestModel registrationRequestModel;
  bool isLoading = false;
  bool isValidMobile = false;
  late String validMobileMessage;
  late CheckInternet checkInternet;

  //Error texts
  String? nameError;
  String? numberError;
  String? addressError;
  String? pinError;
  String? emailError;

  @override
  initState() {
    checkInternet = CheckInternet();

    super.initState();
  }

  _RegistrationPageState() {
    registrationPresenter = RegistrationPresenter(this);
  }

  signup(String name, String mobile, String address, String pincode,
      String email) {
    setState(() {
      isLoading = true;
    });
    String newMobile = "91" + mobile;
    registrationRequestModel = RegistrationRequestModel();
    registrationRequestModel.name = name;
    registrationRequestModel.mobile = newMobile;
    registrationRequestModel.address = address;
    registrationRequestModel.pincode = pincode;
    registrationRequestModel.customerEmail = email;
    registrationRequestModel.branchId = "1";

    registrationPresenter.registration(registrationRequestModel, 'putcustomer');
  }

  checkConnection() {
    checkInternet.check().then((value) {
      if (value) {
        signup(
          customerNameController.text.trim().toString(),
          customerContactController.text.trim().toString(),
          customerAddressController.text.trim().toString(),
          customerPinCodeController.text.trim().toString(),
          customerEmailController.text.trim().toString(),
        );
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : SingleChildScrollView(
              child: Container(
                width: 100.w,
                height: 100.h,
                color: MyColors.screen_background,
                child: mainBody(),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            checkConnection();
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: MyColors.app_theme_color,
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 16, color: MyColors.white),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget mainBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          //Title
          Column(
            children: [
              Image.asset(MyAssets.app_logo_circle),
              Text(
                "Customer Registeration",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: MyColors.app_theme_color,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "Register to continue",
            style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.app_theme_color,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 1.h),
          registerFormWidget(),
        ],
      ),
    );
  }

  Widget registerFormWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 80,
            child: TextField(
              controller: customerNameController,
              decoration: new InputDecoration(
                errorText: nameError,
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: MyColors.app_theme_color)),
                hintText: 'Name',
                labelText: 'Name',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 80,
            child: TextField(
              controller: customerContactController,
              decoration: new InputDecoration(
                errorText: numberError,
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: MyColors.app_theme_color)),
                hintText: 'Contact Number',
                labelText: 'Contact Number',
                prefixIcon: const Icon(
                  Icons.call,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 80,
            child: TextField(
              controller: customerAddressController,
              decoration: new InputDecoration(
                errorText: addressError,
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: MyColors.app_theme_color)),
                hintText: 'Address',
                labelText: 'Address',
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 80,
            child: TextField(
              controller: customerEmailController,
              decoration: new InputDecoration(
                errorText: emailError,
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: MyColors.app_theme_color)),
                hintText: 'Email Id',
                labelText: 'Email Id',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 70,
            child: TextField(
              controller: customerPinCodeController,
              decoration: new InputDecoration(
                errorText: pinError,
                border: new OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: MyColors.app_theme_color)),
                hintText: 'Pin Code',
                labelText: 'Pin Code',
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void registrationFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void registrationSuccess(RegistrationModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 200) {
      ShowMessage().showToast(responseModel.message!);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogInScreen()));
    } else if (responseModel.status == 409) {
      if (responseModel.objectError!.customerName != null) {
        setState(() {
          nameError = responseModel.objectError!.customerName!;
        });
      }
      if (responseModel.objectError!.customerMobile != null) {
        setState(() {
          numberError = responseModel.objectError!.customerMobile!;
        });
      }
      if (responseModel.objectError!.customerPincode != null) {
        setState(() {
          pinError = responseModel.objectError!.customerPincode!;
        });
      }
      if (responseModel.objectError!.customerAddress != null) {
        setState(() {
          addressError = responseModel.objectError!.customerAddress!;
        });
      }
      if (responseModel.objectError!.customerEmail != null) {
        setState(() {
          emailError = responseModel.objectError!.customerEmail!;
        });
      }
    } else {
      ShowMessage().showToast(responseModel.error!);
    }
  }
}
