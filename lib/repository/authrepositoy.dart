import 'package:mvvm/data/network/baseapiservices.dart';
import 'package:mvvm/data/network/networkapiservices.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../resources/components/appurls.dart';
part 'authrepositoy.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  BaseApiService apiService = NetworkApiService();

  @override
  AuthRepository build() {
   return AuthRepository();
  }

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrls.authLoginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrls.authSignUpEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
