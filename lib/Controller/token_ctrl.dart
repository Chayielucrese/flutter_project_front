import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenController extends GetxController {
  String? token;

  Future<void> loadToken() async {
    token = await _getToken();
    print("Loaded token: $token");
  }

  Future<String?> retriveToken() async {
    return await _getToken();
  }


// Future<String?> decodedToken() async {
//   if (token != null) {  // Check if token is not null
//     Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
//     print("my decodedToken: $decodedToken");

//   } else {
//     print("Token is null, cannot decode.");

//   }
// }

  Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved token: $token"); // Check what is being retrieved
    return token;
  }

// Future<void> dataFromTokenDecode(String name, String surname, String role, String email, String password, String city, String phone) async {

//     final pref = await SharedPreferences.getInstance();
//     final attributes = {
//       'name': name,
//       'surname': surname,
//       'email': email,
//       'password': password,
//       'city': city,
//       'phone': phone,
//       'role': role
//     };
//     final jsonString = jsonEncode(attributes);
//     await pref.setString('userAttributes', jsonString);
//   }

//empty local storage to logout
  Future<void> removeTokenFromLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    bool results = await pref.remove("token");
    print("token removed: $results");
  }
}
