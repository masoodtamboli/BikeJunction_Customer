import 'package:fluttertoast/fluttertoast.dart';

import 'MyColors.dart';

class ShowMessage {
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: MyColors.black,
        textColor: MyColors.white,
        fontSize: 16.0);
  }
}
