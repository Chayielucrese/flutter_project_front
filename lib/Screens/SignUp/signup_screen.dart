

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';

import 'package:flutter_application_1/Screens/SignUp/signup_controller.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'Assets/taxi.jpg', // Update with your image path
                fit: BoxFit.cover,
              ),
            ),
            // Content on top of the background
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  color: Colors.black26
                      .withOpacity(0.8), // Semi-transparent background
                  child: Column(
                    children: [
                      // The AppBar and title can be customized as per your needs
                    ],
                  ),
                ),
                // Form section
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Colors.white
                          .withOpacity(0.9), // Semi-transparent white background
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                      key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<String>(
                              value: controller.selectedRole,
                              iconEnabledColor: Colors.pink,
                              decoration: InputDecoration(
                                labelText: 'Sign Up As',
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'driver',
                                  child: Text('Driver'),
                                ),
                                DropdownMenuItem(
                                  value: 'agency',
                                  child: Text('Agency'),
                                ),
                                DropdownMenuItem(
                                  value: 'client',
                                  child: Text(
                                    'Client',
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                controller.updateSelectedRole(newValue!);
                              },
                            ),
                            SizedBox(height: 20.0),
                            _buildForm(controller),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0), // Adjust the top padding value as needed
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                                  children: [
                                    Text(
                                      "eTravel",
                                      style: TextStyle(color: Colors.pink, fontSize: 30, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                    ),
                                    SizedBox(width: 8.0), // Optional spacing between texts
                                    Text(
                                      "Sign Up",
                                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), // Adjust style as needed
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(SignupController controller) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.selectedRole != "agency") ...[
          Row(
            children: [
              Expanded(
                child: appTextField(
                  controller: controller.name,
                  labelText: 'Name',
                  icon: Icons.person,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                  child: appTextField(
                      controller: controller.surname,
                      labelText: 'Surname',
                      icon: Icons.person_outline)),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: appTextField(
                  controller: controller.email,
                  labelText: 'Email',
                  icon: Icons.email,
                  isEmail: true,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                  child: appTextField(
                      controller: controller.password,
                      labelText: 'Password',
                      obscureText: true,
                      isPassword: true,
                      icon: Icons.lock)),
            ],
          ),
          SizedBox(height: 10.0),
        ],
        Row(
          children: [
            Expanded(
              child: appTextField(
                  controller: controller.phone,
                  labelText: ' +237 Phone',
                  icon: Icons.phone,
                  isPhone: true
                  ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return cameroonCities.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: InputDecoration(
                      labelText: 'City',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(
                            8.0), // Slightly rounded corners
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      controller.city.text = value;
                    },
                  );
                },
                onSelected: (String selection) {
                  controller.city.text = selection;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        if (controller.selectedRole == "agency") ...[
          Row(
            children: [
              Expanded(
                child: appTextField(
                  controller: controller.companyName,
                  labelText: 'Company Name',
                  icon: Icons.business,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: appTextField(
                  controller: controller.companyOwner,
                  labelText: 'Owner Name',
                  icon: Icons.person,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: appTextField(
                  controller: controller.companyEmailAddress,
                  labelText: 'Company Email',
                  icon: Icons.email,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: appTextField(
                  controller: controller.companyRegistrationNumber,
                  labelText: 'Registration Number',
                  icon: Icons.assignment,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: appTextField(
                  controller: controller.companyBusStation,
                  labelText: 'Bus Station',
                  icon: Icons.location_on,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // if (controller.formKey.currentState!.validate()) {
              //   int role = controller.roles[controller.selectedRole] ?? 0;

              //   Navigator.pushNamed(context, '/agencyUpload');
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text(
              //         'Correct the errors in the form before proceeding.',
              //         style: TextStyle(fontSize: 18),
              //       ),
              //       backgroundColor: Colors.pink,
              //     ),
              //   );
              // }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // No rounded corners
              ),
              backgroundColor: Colors.white54,
              side: BorderSide(color: Colors.pink), // Border color
            ),
            child: Text(
              'Upload Document',
              style: TextStyle(fontSize: 17.0, color: Colors.black),
            ),
          ),
          SizedBox(height: 20.0),
        ],
        if (controller.selectedRole == "driver") ...[
          Center(
            child: ElevatedButton(
              onPressed: () {
                controller.uploadCheck();
              
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // No rounded corners
                ),
                backgroundColor: Colors.white54,
                side: BorderSide(color: Colors.pink), // Border color
              ),
              child: Text(
                'Upload Document',
                style: TextStyle(fontSize: 17.0, color: Colors.black),
              ),
            ),
          ),
        ],
        if (controller.selectedRole == "client") ...[
          Center(
            child: ElevatedButton(
              onPressed: () {
               controller.submitForm();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // No rounded corners
                ),
                backgroundColor: Colors.pink,
                side: BorderSide(color: Colors.pink), // Border color
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ],
    );
  }
  
}


List<String> cameroonCities = [
  'Yaoundé',
  'Douala',
  'Bamenda',
  'Bafoussam',
  'Garoua',
  'Maroua',
  'Ngaoundéré',
  'Bertoua',
  'Ebolowa',
  'Kribi',
  'Limbe',
  'Kumba',
];
