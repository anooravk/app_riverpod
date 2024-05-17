import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loginviewmodel.g.dart';


@riverpod
class LoginValidater extends _$LoginValidater {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void build() {}

  String? validateEmail(email) {
    if (!GetUtils.isEmail(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(password) {
    if (password.length < 6) {
      return 'Password must be of atleast 6 characters';
    }
    return null;
  }

  void validateLogin(key) {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    }
    key.currentState!.save();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
