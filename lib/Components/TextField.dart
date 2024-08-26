import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/SignUp/signup_controller.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart' as validator;

final SignupController signupController = Get.put(SignupController());

Widget appTextField({
  required String labelText,
  bool obscureText = false,
  required IconData icon,
  required TextEditingController controller,
  bool isEmail = false,
  bool isPhone = false,
  bool isPassword = false,
  bool isPlateNumber = false,
  int maxLines = 1, // Added maxLines parameter
  Future<Null> Function()? onTap,
  TextInputType? keyboardType,  // Added keyboardType parameter
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    maxLines: maxLines,
    keyboardType: keyboardType ?? TextInputType.text, // Use keyboardType if provided, else default to TextInputType.text
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      prefixIcon: Icon(icon, color: Colors.pink),
      labelStyle: TextStyle(color: Colors.black),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54),
      ),
    ),
    style: TextStyle(color: Colors.black),
    textAlignVertical: TextAlignVertical.center,
    validator: (value) {
      value = value?.trim();
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      if (isEmail && !validator.isEmail(value)) {
        return 'Please enter a valid email address';
      }
      if (isPhone) {
        return signupController.validatePhone(value);
      }
      if (isPassword) {
        return signupController.validatePassword(value);
      }
      if (isPlateNumber) {
        return validatePlateNumber(value, 'CM');
      }
      return null;
    },
    onTap: onTap,
  );
}

String? validatePlateNumber(String plateNumber, String countryCode) {
  if (plateNumber.isEmpty) {
    return 'Plate number is required';
  }

  Map<String, RegExp> patterns = {
    'CM': RegExp(r'^[A-Z]{2}-\d{3}-[A-Z]{2}$'),
  };

  final pattern = patterns[countryCode];

  if (pattern == null) {
    return 'Unsupported country code';
  }

  if (!pattern.hasMatch(plateNumber)) {
    return 'Invalid plate number format for $countryCode';
  }

  return null;
}
