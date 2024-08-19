import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppController extends GetxController {


void alertError(String message) {
    Get.snackbar("Error", message,
        colorText: Colors.white, backgroundColor: Colors.red);
  }

  void alertSuccess(String message) {
    Get.snackbar("Success", message,
        colorText: Colors.white, backgroundColor: Colors.pink);
  }
}
  // drawer: Drawer(
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: <Widget>[
  //           DrawerHeader(
  //             decoration: BoxDecoration(
  //               color: Colors.pink,
  //             ),
  //             child: Text(
  //               'Menu',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 24,
  //               ),
  //             ),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.person, color: Colors.pink),
  //             title: Text('Profile', style: TextStyle(color: Colors.black)),
  //             onTap: () {
  //               Navigator.pop(context);
  //               // Navigate to Profile page
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.account_balance_wallet, color: Colors.pink),
  //             title: Text('Wallet', style: TextStyle(color: Colors.black)),
  //             onTap: () {
  //               Navigator.pop(context);
  //               // Navigate to Wallet page
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.logout, color: Colors.pink),
  //             title: Text('Logout', style: TextStyle(color: Colors.black)),
  //             onTap: () {
  //               Navigator.pushNamed(context, '/');
  //               // Perform logout action
  //             },
  //           ),
  //         ],
  //       ),
  //     ),