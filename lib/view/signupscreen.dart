import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/viewmodel/singupviewmodel.dart';
import 'package:mvvm/utils/util.dart';
import 'package:mvvm/viewmodel/authviewmodel.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  var isPasswordVisible = true.obs;
  final loginEmailKey = GlobalKey();
  final loginPasswordKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpFormController = ref.watch(signupValidaterProvider.notifier);
    final authViewModel = ref.watch(authenticationProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final height = MediaQuery.of(context).size.height;
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
              controller: signUpFormController.emailController,
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
                signUpFormController.emailController.text = value!;
              },
              validator: (value) {
                return signUpFormController.validateEmail(value);
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
                  controller: signUpFormController.passwordController,
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
                    return signUpFormController.validatePassword(value!);
                  },
                  onSaved: (value) {
                    signUpFormController.passwordController.text = value!;
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
                signUpFormController.validateLogin(loginEmailKey);
                signUpFormController.validateLogin(loginPasswordKey);
                dynamic data = {
                  'email': signUpFormController.emailController.text,
                  'password': signUpFormController.passwordController.text,
                };
                authViewModel.signUpApi(data, context);
                if (kDebugMode) {
                  print('api hit');
                }
              },
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : Text('SignUp')),
          SizedBox(
            height: height * 0.025,
          ),
          InkWell(
            onTap: () {
              context.go('/loginScreen');
            },
            child: const Text("Already have an account? Login"),
          ),
        ],
      ),
    );
  }
}
