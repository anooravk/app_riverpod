import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/usermodel.dart';
import '../../viewmodel/userviewmodel.dart';
part 'splashservices.g.dart';

// class SplashServices {
//   Future<UserModel> getUserData() => UserViewModel().getUser();
//
//   void checkAuthentication(BuildContext context) async {
//     getUserData().then((value) async {
//       if (value.token.toString() == 'null' || value.token.toString() == '') {
//         await Future.delayed(const Duration(seconds: 3));
//         context.go('/loginScreen');
//       } else {
//         await Future.delayed(const Duration(seconds: 3));
//         context.go('/homeScreen');
//       }
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
// }

@riverpod
class SplashScreenServices extends _$SplashScreenServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  @override
  void build() {

  }

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (value.token.toString() == 'null' || value.token.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        context.go('/loginScreen');
      } else {
        await Future.delayed(const Duration(seconds: 3));
        context.go('/homeScreen');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
