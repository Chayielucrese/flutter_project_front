import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Wallet/wallet_ctrl.dart';
import 'package:get/get.dart';

class UserWalletPage extends StatelessWidget {
  const UserWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<UserWalletController>(
        builder: (controller) => Scaffold(
      appBar: AppBar(
        title: Text('Wallet', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Image
             Container(

                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'Assets/Wallet-pana.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                
                ),
            SizedBox(height: 20),
            
            // Create Wallet Form
            Text(
              'Create Your Wallet',
              style: TextStyle(
                fontSize: 24,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            appTextField(
              labelText: "Create wallet password",
              icon: Icons.password,
              controller: controller.passwordController,
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              controller.submitForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Submit', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    ),);
  }
}

