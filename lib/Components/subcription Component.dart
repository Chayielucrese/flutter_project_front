import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart'; // Make sure this is your custom TextField component

class SubscribeNowPage extends StatefulWidget {
  final String planName;
  final String planPrice;
  final String planDescription;

  SubscribeNowPage({
    super.key,
    required this.planName,
    required this.planPrice,
    required this.planDescription,
  });

  @override
  _SubscribeNowPageState createState() => _SubscribeNowPageState();
}

class _SubscribeNowPageState extends State<SubscribeNowPage> {
  String? _selectedPaymentMethod;
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _mobileMoneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscribe Now",
          style: TextStyle(
            color: Colors.pink,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.pink),
      ),
      resizeToAvoidBottomInset: true, // Ensure the scaffold adjusts to keyboard
      body: SingleChildScrollView( // Make the body scrollable
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan Details
            Text(
              "Plan Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Plan: ${widget.planName}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Price: ${widget.planPrice}",
              style: TextStyle(fontSize: 18, color: Colors.pink),
            ),
            Text(
              "Description: ${widget.planDescription}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Payment Method Selection
            Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset('assets/images/mtn_logo.png', width: 40, height: 40), // Ensure you have this image in your assets
                SizedBox(width: 10),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text("MTN Mobile Money"),
                    value: "MTN Mobile Money",
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/orange_logo.png', width: 40, height: 40), // Ensure you have this image in your assets
                SizedBox(width: 10),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text("Orange Money"),
                    value: "Orange Money",
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Payment Details
            if (_selectedPaymentMethod != null) ...[
              Text(
                "Payment Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (_selectedPaymentMethod == "MTN Mobile Money") ...[
                appTextField(
                  labelText: "Mobile Number",
                  icon: Icons.phone_android,
                  controller: _mobileMoneyController,
                ),
              ] else if (_selectedPaymentMethod == "Orange Money") ...[
                appTextField(
                  labelText: "Account Number",
                  icon: Icons.account_balance,
                  controller: _accountNumberController,
                ),
              ],
              SizedBox(height: 20),
            ],

            // Subscribe Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedPaymentMethod == null) {
                    // Show error or prompt to select a payment method
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a payment method.'),
                      ),
                    );
                  } else {
                    // Handle subscription process
                    _handleSubscription();
                  }
                },
                child: Text('Subscribe Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubscription() {
    // Implement your subscription logic here
    print("Subscribed with $_selectedPaymentMethod");
    print("Mobile Money Number: ${_mobileMoneyController.text}");
    print("Account Number: ${_accountNumberController.text}");
  }
}
