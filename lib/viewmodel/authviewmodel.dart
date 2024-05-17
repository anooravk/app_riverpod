import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/repository/authrepositoy.dart';
import 'package:mvvm/viewmodel/userviewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/usermodel.dart';
import '../utils/util.dart';

part 'authviewmodel.g.dart';


final isLoadingProvider = StateProvider<bool>((ref) => false);

@riverpod
class Authentication extends _$Authentication {
  late final AuthRepository authView;

  @override
  Authentication build() {
    authView = ref.watch(authRepositoryProvider);

    return this;
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    ref.read(isLoadingProvider.notifier).state = true;
    authView.loginApi(data).then((value) {
      UserViewModel().saveUser(UserModel(token: value['token']));
      if (kDebugMode) print(value.toString());
      Utils.snackBarMessage(context,value.toString());
      context.go('/homeScreen');
      ref.read(isLoadingProvider.notifier).state = false;
    }).onError((error, stackTrace) {
      ref.read(isLoadingProvider.notifier).state = false;

      if (kDebugMode) print(error.toString());
      Utils.snackBarMessage(context,error.toString());
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    ref.read(isLoadingProvider.notifier).state = true;

    authView.signUpApi(data).then((value) {
      if (kDebugMode) print(value.toString());
      Utils.snackBarMessage(context,value.toString());
      context.go('/homeScreen');
      ref.read(isLoadingProvider.notifier).state = false;
    }).onError((error, stackTrace) {
      ref.read(isLoadingProvider.notifier).state = false;

      if (kDebugMode) print(error.toString());
      Utils.snackBarMessage(context,error.toString());
    });
  }
}
