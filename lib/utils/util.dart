import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/resources/components/appcolors.dart';

class Utils {

  static void snackBarMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void toastMessage(String message) {
    Fluttertoast.showToast(msg: message, textColor: AppColors.whiteColor);
  }

  static void changeFocusNode(
      {required BuildContext context,
      required FocusNode currentFocus,
      required FocusNode nextFocus}) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
