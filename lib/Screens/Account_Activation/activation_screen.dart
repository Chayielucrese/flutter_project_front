import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Account_Activation/activation_ctrl.dart';
import 'package:get/get.dart';

class ActivationPage extends StatelessWidget {
  const ActivationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivationController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54.withOpacity(0.8),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Activate Your Account',
            style: TextStyle(color: Colors.pink),
          ),
        ),
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'Assets/map.png', // Update with your image path
                fit: BoxFit.cover,
              ),
            ),
            // Semi-transparent overlay
            Positioned.fill(
              child: Container(
                color: Colors.black54
                    .withOpacity(0.8), // Semi-transparent black overlay
              ),
            ),
            // Content on top of the overlay
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter the code sent to your email',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    SizedBox(height: 20.0),
                    // Row with 5 code boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0), // Space between boxes
                            child: _buildCodeBox(index, controller, context));
                      }),
                    ),
                    SizedBox(height: 20.0),

                    ElevatedButton(
                      onPressed: () {
                        controller.validateCode(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 60.0, vertical: 10.0),
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Validate',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox(
      int index, ActivationController controller, BuildContext context) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: TextField(
        controller: controller.codeCollector[index],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          // White background for each box
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 4) {
            FocusScope.of(context).nextFocus(); // Move to the next field
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context)
                .previousFocus(); // Move to the previous field
          }
        },
      ),
    );
  }
}
