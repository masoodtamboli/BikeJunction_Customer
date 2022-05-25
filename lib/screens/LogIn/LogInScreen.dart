import 'dart:async';

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
  bool isTimeEnd = false;
  String validMobileMessage = MyStrings.validate_mobile_empty;
  bool isValidMobile = false;
  bool isLoading = false;
  late CheckInternet checkInternet;

  late List<Data> loginList;
  late List<CustomerData> customerDataList;
  late String otpToken;

  late LoginPresenter loginPresenter;
  late VerifyOtpPresenter verifyOtpPresenter;
  late LoginRequestModel loginRequestModel;
  late VerifyOtpRequestModel verifyOtpRequestModel;

  _LogInScreenState() {
    loginPresenter = LoginPresenter(this);
    verifyOtpPresenter = VerifyOtpPresenter(this);
  }

  login(String mobile) {
    setState(() {
      isLoading = true;
    });
    loginRequestModel = LoginRequestModel();
    loginRequestModel.customerMobile = mobile;
    print(mobile);
    loginPresenter.login(loginRequestModel, 'checkcustomermobile');
  }

  verifyOtp(String mobileNo, String otp, String token) {
    setState(() {
      isLoading = true;
    });
    verifyOtpRequestModel = VerifyOtpRequestModel();
    verifyOtpRequestModel.customerMobile = mobileNo;
    verifyOtpRequestModel.otpSms = otp;
    verifyOtpRequestModel.otpToken = token;
    verifyOtpPresenter.verify(verifyOtpRequestModel, 'checkcustomerotp');
  }

  checkConnection() {
    checkInternet.check().then((value) {
      if (value) {
        validate();
      } else {
        // DialogHelper.noInternet(
        //     context,
        //     MyAssets.noInternetIcon,
        //     MyStrings.btn_retry,
        //     MyStrings.btn_cancel,
        //     onClickRetry,
        //     onClickCancel);
      }
    });
  }

  validate() {
    mobileNumberController.text.isEmpty
        ? isValidMobile = true
        : isValidMobile = false;

    if (mobileNumberController.text.isEmpty) {
      isValidMobile = true;
      setState(() {
        validMobileMessage = MyStrings.validate_mobile_empty;
      });
    }
    if (mobileNumberController.text.length != 10) {
      isValidMobile = true;
      setState(() {
        validMobileMessage = MyStrings.validate_mobile;
      });
    }
    print(mobileNumberController.text.toString());
    login(mobileNumberController.text.toString());
  }

  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;
  var onTapRecognizer;

  @override
  void initState() {
    super.initState();
    SharedPreference.init();
    checkInternet = CheckInternet();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController.close();

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
            Container(
              color: MyColors.app_theme_color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(MyAssets.app_logo),
                    // Text(
                    //   "Customer App",
                    //   style: TextStyle(fontSize: 18.sp,
                    //       color: MyColors.app_theme_color,
                    //       fontStyle: FontStyle.normal,
                    //   fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
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
                Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        height: 8.h,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h, right: 1.h),
                          child: Text(
                            MyStrings.country_code,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 8.h,
                        child: TextField(
                          controller: mobileNumberController,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: MyColors.grey_text_color),
                            hintText: MyStrings.enter_mobile_no_hint,
                            errorText:
                                isValidMobile ? validMobileMessage : null,
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    checkConnection();
                    //displayOTPBottomSheet(context, "9011547660");
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
  void displayOTPBottomSheet(BuildContext context, String text) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        builder: (ctx) {
          return otpBottomSheet(text);
        });
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(5.0),
  );

  // Bottom Sheet Model
  Widget otpBottomSheet(String mobile) {
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
                  // Lottie.asset(MyAssets.otp_bottomsheet_lottie,
                  //     height: 100.0, width: 100.0),
                  Text("Verify OTP",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Enter otp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: Text("+91" + mobile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        )),
                  ),
                  // OTP Entry Text Field
                  Padding(
                      padding: EdgeInsets.only(right: 5.0, left: 5.0),
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            selectedColor: MyColors.app_theme_color,
                            selectedFillColor: Colors.white,
                            inactiveFillColor: MyColors.white,
                            inactiveColor: MyColors.black,
                            activeFillColor: Colors.white,
                            activeColor: MyColors.black),
                        animationDuration: Duration(milliseconds: 300),
                        // backgroundColor:,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onCompleted: (otp) {
                          print("Completed");
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegistrationPage()));
                          verifyOtp(mobile, otp, otpToken);
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            // currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return false;
                        },
                        appContext: context,
                      )),

                  SizedBox(
                    height: 10.0,
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
                          Text(
                            "Resend OTP : ",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
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
    print(exception);
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void loginSuccess(LoginResponseModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 1) {
      setState(() {
        otpToken = responseModel.data!.otpToken!;
      });
      //loginList.add(responseModel.data!);
      displayOTPBottomSheet(
          context, responseModel.data!.customerMobile!.toString());
      ShowMessage().showToast("Success");
    } else if (responseModel.status == 0) {
      ShowMessage().showToast("Unknown mobile number");
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
    if (responseModel.status == 1) {
      Navigator.of(context).pop();
      setState(() {
        SharedPreference.setIsLogin(true);
        SharedPreference.setCustomerId(
            int.parse(responseModel.data!.customerId!));
        SharedPreference.setBranchId(int.parse(responseModel.data!.branchId!));
        SharedPreference.setCustomerMobile(responseModel.data!.customerMobile!);
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
