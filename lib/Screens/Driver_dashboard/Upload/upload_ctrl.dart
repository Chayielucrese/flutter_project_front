import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverUploadController extends AppController {
  File? drivingLicence;
  File? cni;
  File? photo;
  File? vehiclePhoto;

  Future<http.Response> createUser(
      String name,
      String surname,
      String email,
      String password,
      String phone,
      String city,
      int role,
      String drivingLicense,
      String vehiclePhoto,
      String imageProfile,
      String CNI) async {
    print("Hello, $email");

    final response = await http.post(
      Uri.parse("${Config.apiUrl}/createUser"),
      body: {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "phone": phone,
        "city": city,
        "role": role.toString(),
        "drivingLicense": drivingLicense,
        "vehiclePhoto": vehiclePhoto,
        "profileImage": imageProfile,
        "CNI": CNI
      },
    );

    return response;
  }

  Future<String> getUserEmail() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['email'] ?? 'Unknown';
  }

  Future<String> getUserPhone() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['phone'] ?? 'Unknown';
  }

  Future<String> getUserPassword() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['password'] ?? 'Unknown';
  }

  Future<String> getUserName() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['name'] ?? 'Unknown';
  }

  Future<String> getUserRole() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['role'] ?? 'Unknown';
  }

  Future<String> _getUserSurname() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['surname'] ?? 'Unknown';
  }

  Future<String> getUserCity() async {
    Map<String, String> userParams = await getUserParams();
    return userParams['city'] ?? 'Unknown';
  }

  Future<void>pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedFile = File(pickedFile.path);

      switch (index) {
        case 0:
          drivingLicence = selectedFile;
          break;
        case 1:
          cni = selectedFile;
          break;
        case 2:
          photo = selectedFile;
          break;
        case 3:
          vehiclePhoto = selectedFile;
          break;
      }
    }

    update();
  }

  Future<String> getBase64(File file) async {
    String? base64;
    String fileExtension = file.path.split('.').last.toLowerCase();
    // Assume content type based on file extension
    String contentType =
        fileExtension.contains('jpg') || fileExtension.contains('jpeg')
            ? 'image/jpeg'
            : fileExtension.contains('png')
                ? 'image/png'
                : 'unknown';

    if (contentType != 'unknown') {
      final uInt8List = await file.readAsBytes();
      base64 = base64Encode(uInt8List);
      base64 = 'data:$contentType;base64,$base64';
    }
    print("contentType: $contentType");
    return base64 ?? "";
  }

  Future<Map<String, String>> getUserParams() async {
    final pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('userAttributes');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
    return {};
  }

  Future<void> setDriverToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

  Future<void> submitForm() async {
    if (drivingLicence != null &&
        cni != null &&
        vehiclePhoto != null &&
        photo != null) {
      String base64StringLicense = await getBase64(drivingLicence!);
      String base64StringCNI = await getBase64(cni!);
      String base64StringVehiclePhoto = await getBase64(vehiclePhoto!);
      String base64StringUserTof = await getBase64(photo!);
      String name = await getUserName();
      String surname = await getUserName();
      String email = await getUserEmail();
      String phone = await getUserPhone();
      String city = await getUserCity();
      String password = await getUserPassword();
      String role = await getUserRole();

      try {
        final response = await createUser(
            name,
            surname,
            email,
            password,
            phone,
            city,
            int.parse(role),
            base64StringLicense,
            base64StringCNI,
            base64StringVehiclePhoto,
            base64StringUserTof);
        if (response.statusCode == 200 || response.statusCode == 201) {
          print("User created successfully.");
          Get.toNamed(AppRoutes.activation);
        } else {
          final errorResponse = json.decode(response.body);
          print("Registration failed: ${errorResponse['msg']}");

          print(response.body);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", email);
          alertError(
            "${errorResponse['msg']}",
          );
        }
      } catch (e) {
        alertError("An Error accoured please try again letter");
      }
    } else {}
  }
}
