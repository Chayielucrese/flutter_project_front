import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_ctrl.dart';
import 'package:get/get.dart';

class DriverUploadPage extends StatelessWidget {
  const DriverUploadPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverUploadController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            'Documents',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/upload.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          String label;
                          IconData icon;
                          File? imageFile;

                          switch (index) {
                            case 0:
                              label = 'Driving Licence';
                              icon = Icons.card_membership;
                              imageFile = controller.drivingLicence;
                              break;
                            case 1:
                              label = 'CNI';
                              icon = Icons.credit_card;
                              imageFile = controller.cni;
                              break;
                            case 2:
                              label = 'Photo';
                              icon = Icons.photo_camera;
                              imageFile = controller.photo;
                              break;
                            case 3:
                              label = 'Vehicle Photo';
                              icon = Icons.directions_car_filled;
                              imageFile = controller.vehiclePhoto;
                              break;
                            default:
                              label = 'Upload';
                              icon = Icons.add_a_photo;
                              imageFile = null;
                          }

                          return GestureDetector(
                            onTap: () => controller.pickImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                children: [
                                  if (imageFile != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        imageFile,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    )
                                  else
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            icon,
                                            color: Colors.black,
                                            size: 50.0,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            label,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          controller.submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: EdgeInsets.symmetric(
                              horizontal: 60.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Submit',
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
      ),
    );
  }
}
