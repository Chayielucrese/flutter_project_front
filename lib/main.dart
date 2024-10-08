import 'package:flutter/material.dart';
import 'package:flutter_application_1/Routes/app_page.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        // initialBinding: BoissonBinding(),
        initialRoute: AppRoutes.welcome,
        getPages: AppPages.pages);
  }
}
