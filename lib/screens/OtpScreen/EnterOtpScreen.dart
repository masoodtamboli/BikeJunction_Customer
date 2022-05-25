
import 'package:bike_junction_customer/utils/MyAssets.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/MyStrings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EnterOtpScreen extends StatefulWidget {
  String mobileNumber;
  EnterOtpScreen(this.mobileNumber);

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {


  TextEditingController otpController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  color: MyColors.screen_background,
                  child: mainBody("v4.8.1", widget.mobileNumber,constraints.maxHeight),
                ),
              );
            }),
      ),
    );
  }

  Widget mainBody(String appVersion, String mobileNumber, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10.h),
            //Title
            Column(
              children: [
                Image.asset(MyAssets.app_logo),
                Text(
                  "Customer App",
                  style: TextStyle(fontSize: 18.sp,
                      color: MyColors.app_theme_color,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            //Login field & button
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mobileNumber,
                  style: TextStyle(fontSize: 14.sp,
                      color: MyColors.black,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 8.h,
                        child: TextField(
                          controller: otpController,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: MyColors.grey_text_color
                            ),
                            hintText: MyStrings.enter_code_message,
                           // errorText: isValidMobile ? validMobileMessage : null,
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));
                  },
                  child: Container(
                    height: 8.h,
                    child: Card(
                      color: MyColors.app_theme_color,
                      child: Center(
                        child: Text(
                          MyStrings.login_button_text,
                          style: TextStyle(
                              color: MyColors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      MyStrings.back_text,
                      style: TextStyle(fontSize: 14.sp,
                          color: MyColors.black,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "${MyStrings.resend_code_text} 7s.",
                      style: TextStyle(fontSize: 14.sp,
                          color: MyColors.black,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
