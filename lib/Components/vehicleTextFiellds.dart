import 'package:flutter/material.dart';


Widget buildTextField({

    required String labelText,
    bool obscureText = false,
    required IconData icon,
    required TextEditingController controller,
    bool isPlateNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.pink),
      ),
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      validator: (value) {
        value = value?.trim();
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (isPlateNumber) {
          return validatePlateNumber(value, "CM");
        }
        return null;
      },
    );
  }


class VehicleOption extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String?>? onChanged;

  VehicleOption({
    required this.label,
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.pink,
            ),
            SizedBox(width: 0),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

  String? validatePlateNumber(String plateNumber, String countryCode) {
    if (plateNumber.isEmpty) {
      return 'Plate number is required';
    }
    return null;

  }