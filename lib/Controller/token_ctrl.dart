 import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TokenController extends GetxController {
String? token;
 
 Future<void> loadToken() async {
    token = await _getToken();
    print("Loaded token: $token");
  }

  Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved token: $token"); // Check what is being retrieved
    return token;
  }

}