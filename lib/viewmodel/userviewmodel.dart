
import 'package:mvvm/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserViewModel {
  Future<bool> saveUser (UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", user.token );
    return true;
  }

  Future<UserModel> getUser () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("token");
    return UserModel(token: token.toString());
  }

  Future<bool> removeUser () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
    return true;
  }
}
