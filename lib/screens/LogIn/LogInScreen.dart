import 'dart:async';
import 'dart:developer';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:bike_junction_customer/screens/Dashboard/DashboardPage.dart';
import 'package:bike_junction_customer/screens/LogIn/contractor/login_contract.dart';
import 'package:bike_junction_customer/screens/LogIn/contractor/verify_otp_contract.dart';
import 'package:bike_junction_customer/screens/LogIn/model/login_model.dart';
import 'package:bike_junction_customer/screens/LogIn/model/verify_otp_model.dart';
import 'package:bike_junction_customer/screens/LogIn/presenter/login_presenter.dart';
import 'package:bike_junction_customer/screens/LogIn/presenter/verify_otp_presenter.dart';
import 'package:bike_junction_customer/screens/RegistrationPage/RegistrationPage.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyAssets.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/MyStrings.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    implements LoginContract, VerifyOtpContract {
  //controllers
  TextEditingController mobileNumberController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  bool isTimeEnd = false;
  String validMobileMessage = MyStrings.validate_mobile_empty;
  bool isValidMobile = false;
  bool isLoading = false;
  String? _errorText;
  late CheckInternet checkInternet;

  late List<Data> loginList;
  late List<CustomerData> customerDataList;
  late String customerId;

  late LoginPresenter loginPresenter;
  late VerifyOtpPresenter verifyOtpPresenter;
  late LoginRequestModel loginRequestModel;
  late VerifyOtpRequestModel verifyOtpRequestModel;

  _LogInScreenState() {
    loginPresenter = LoginPresenter(this);
    verifyOtpPresenter = VerifyOtpPresenter(this);
  }

  //Auto read OTP

  Future<void> initSMSListener() async {
    String? commingSms;
    try {
      commingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      commingSms = "FAILED";
    }

    if (!mounted) return;

    setState(() {
      otpController.set(commingSms!
          .replaceAll(new RegExp(r'[^0-9]'), '')
          .substring(0, 6)
          .split(""));
      // commingSms!.replaceAll(new RegExp(r'[^0-9]'), '').substring(0, 6);
    });
  }

  login(String mobile) {
    setState(() {
      isLoading = true;
    });

    loginRequestModel = LoginRequestModel();
    loginRequestModel.customerMobile = mobile;
    loginPresenter.login(loginRequestModel, 'checkcustomermobile');
  }

  verifyOtp(String otp) {
    setState(() {
      isLoading = true;
    });
    verifyOtpRequestModel = VerifyOtpRequestModel();
    verifyOtpRequestModel.otpSms = otp;
    verifyOtpRequestModel.customerId = customerId;
    verifyOtpPresenter.verify(verifyOtpRequestModel, 'checkcustomerotp');
  }

  checkConnection() {
    checkInternet.check().then((value) {
      if (value) {
        validate();
      } else {
        ShowMessage().showToast("No Internet Connection!");
      }
    });
  }

  validate() {
    login(mobileNumberController.text.toString());
  }

  @override
  void initState() {
    super.initState();
    SharedPreference.init();
    checkInternet = CheckInternet();
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator.adaptive())
            : SafeArea(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      color: MyColors.screen_background,
                      child: mainBody("v4.8.1", constraints.maxHeight),
                    ),
                  );
                }),
              ),
      ),
    );
  }

  Widget mainBody(String appVersion, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 5.h),
            //Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(MyAssets.app_logo_circle),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            //Login field & button
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login with mobile...!",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: MyColors.red,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 1.h),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: 85.w,
                  child: TextFormField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _errorText,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "+91 ",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                      contentPadding: EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.app_theme_color),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.app_theme_color),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Mobile number",
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Not registered, Sign up here! ",
                        style: TextStyle(
                          color: MyColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: MyColors.app_theme_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTimeEnd = false;
                    });
                    initSMSListener();
                    checkConnection();
                  },
                  child: Container(
                    height: 8.h,
                    child: Card(
                      color: MyColors.app_theme_color,
                      child: Center(
                        child: Text(
                          MyStrings.btn_login_code,
                          style: TextStyle(color: MyColors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  // Display Bottom sheet function
  void displayOTPBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        builder: (ctx) {
          return otpBottomSheet();
        });
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(5.0),
  );

  Widget otpBottomSheet() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              height: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Verify OTP",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.0,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Code is sent to: ",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: "+91 ${mobileNumberController.text}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0, left: 5.0),
                    child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: TextStyle(fontSize: 17),
                      onCompleted: (pin) {
                        verifyOtp(pin);
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Didn't recieve code? ",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "Request again in ",
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // Timer
                  TweenAnimationBuilder<Duration>(
                      duration: Duration(minutes: 2),
                      tween: Tween(
                          begin: Duration(minutes: 2), end: Duration.zero),
                      onEnd: () {
                        setState(() {
                          isTimeEnd = true;
                        });
                      },
                      builder: (BuildContext context, Duration value,
                          Widget? child) {
                        final minutes = value.inMinutes;
                        final seconds = value.inSeconds % 60;
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('$minutes:$seconds',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)));
                      }),

                  // Resend OTP
                  Visibility(
                    visible: isTimeEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              resendOtp(mobileNumberController.text
                                  .trim()
                                  .toString());
                            },
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                              ),
                            ),
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
      },
    );
  }

  resendOtp(String mobileNo) {
    login(mobileNo);
  }

  @override
  void loginFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void loginSuccess(LoginResponseModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 200) {
      ShowMessage().showToast(responseModel.message!);
      setState(() {
        customerId = responseModel.data!.customerId!;
      });
      displayOTPBottomSheet(context);
    } else if (responseModel.status == 403) {
      ShowMessage().showToast(responseModel.error!);
    } else if (responseModel.status == 409) {
      setState(() {
        _errorText = responseModel.objectError!.mobileNo;
      });
    } else {
      ShowMessage().showToast(responseModel.error!);
    }
  }

  @override
  void verifyOtpFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void verifyOtpSuccess(VerifyOtpResponseModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 200) {
      Navigator.of(context).pop();
      setState(() {
        SharedPreference.setIsLogin(true);
        SharedPreference.setCustomerId(
            int.parse(responseModel.data!.customerId!));
        SharedPreference.setBranchId(int.parse(responseModel.data!.branchId!));
        SharedPreference.setCustomerMobile(
            responseModel.data!.customerMobile!.substring(2, 12));
        SharedPreference.setCustomerAddress(
            responseModel.data!.customerAddress!);
        SharedPreference.setCustomerName(responseModel.data!.customerName!);
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardPage()));
      ShowMessage().showToast("Login Successful");
    } else {
      ShowMessage().showToast("Incorrect OTP");
    }
  }
}
