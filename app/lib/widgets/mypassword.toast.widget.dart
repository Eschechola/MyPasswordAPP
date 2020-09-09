import 'package:flutter/cupertino.dart';
import 'package:mypassword/styles/app.colors.dart';
import 'package:toast/toast.dart';

class MyPasswordToast {
  static void showToast(String message, BuildContext context) {
    message.replaceAll("Exception", "");
    message.replaceAll("Exception:", "");
    message.replaceAll("exception", "");
    message.replaceAll("exception:", "");

    Toast.show(
      message,
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.TOP,
      backgroundColor: AppColors.thirdColor,
      textColor: AppColors.secondaryColor,
      backgroundRadius: 4
    );
  }
}
