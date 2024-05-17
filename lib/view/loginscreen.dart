import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/utils/util.dart';
import 'package:mvvm/viewmodel/authviewmodel.dart';
import '../viewmodel/loginviewmodel.dart';
import '../viewmodel/userviewmodel.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  var isPasswordVisible = true.obs;
  final loginEmailKey = GlobalKey();
  final loginPasswordKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormController = ref.watch(loginValidaterProvider.notifier);
    final isLoading = ref.watch(isLoadingProvider);
    final authViewModel = ref.watch(authenticationProvider);
    final height = MediaQuery.of(context).size.height;
    if (kDebugMode) {
      loginFormController.emailController.text = 'eve.holt@reqres.in';
      loginFormController.passwordController.text = 'cityslicka';
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: loginEmailKey,
            child: TextFormField(
              focusNode: emailNode,
              keyboardType: TextInputType.emailAddress,
              controller: loginFormController.emailController,
              decoration: const InputDecoration(
                hintText: 'email',
                labelText: 'email',
                prefixIcon: Icon(Icons.alternate_email),
              ),
              onFieldSubmitted: (value) {
                Utils.changeFocusNode(
                    context: context,
                    currentFocus: emailNode,
                    nextFocus: passwordNode);
              },
              onSaved: (value) {
                loginFormController.emailController.text = value!;
              },
              validator: (value) {
                return loginFormController.validateEmail(value);
              },
            ),
          ),
          Obx(
            () {
              return Form(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: loginPasswordKey,
                  focusNode: passwordNode,
                  keyboardType: TextInputType.text,
                  controller: loginFormController.passwordController,
                  obscureText: isPasswordVisible.value,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'password',
                    prefixIcon: const Icon(Icons.lock_open_rounded),
                    suffixIcon: InkWell(
                        onTap: () {
                          isPasswordVisible.toggle();
                        },
                        child: isPasswordVisible.value
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined)),
                  ),
                  validator: (value) {
                    return loginFormController.validatePassword(value!);
                  },
                  onSaved: (value) {
                    loginFormController.passwordController.text = value!;
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.085,
          ),
          ElevatedButton(
            onPressed: () async {
              loginFormController.validateLogin(loginEmailKey);
              loginFormController.validateLogin(loginPasswordKey);
              dynamic data = {
                'email': loginFormController.emailController.text,
                'password': loginFormController.passwordController.text,
              };
              authViewModel.loginApi(data, context);

              if (kDebugMode) {
                print('api hit');
              }
            },
            child: isLoading
                ? SizedBox(
              height: 20,
                  width: 20,
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    ),
                )
                : Text('Login'),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          InkWell(
            onTap: () {
              context.go('/signUpScreen');
            },
            child: const Text("Don't have an account already? Sign up"),
          ),
        ],
      ),
    );
  }
}
