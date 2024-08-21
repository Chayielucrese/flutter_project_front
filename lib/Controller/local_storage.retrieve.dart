import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';





// ignore: camel_case_types
class LocalData extends GetxController {

//  loading Params
 String? name;
 Future<void> loadName() async {
    name = await getUserName();
  }

  Future<Map<String, String>> _getUserParams() async {
    final pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('userAttributes');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
    return {};
  }

  Future<String> getUserEmail() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['email'] ?? 'Unknown';
  }
   Future<String> getUSerCity() async {
    Map<String, String> userParams = await _getUserParams();
    return await userParams['city'] ?? 'Unknown';
  }
    Future<String> getUserPhone() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['phone'] ?? 'Unknown';
  }

  Future<String> getUserRole() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['role'] ?? 'Unknown';
  }
  
  Future<String> getUserName() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['name'] ?? 'Unknown';
  }

  Future<String> getUserSurname() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['surname'] ?? 'Unknown';
  }
}


