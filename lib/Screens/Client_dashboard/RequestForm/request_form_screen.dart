import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/RequestForm/request_form_ctrl.dart';
import 'package:get/get.dart';

class ReservationScreen extends StatelessWidget {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestFormController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Book a Ride',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.toNamed(AppRoutes.clientwelcome);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickup Point
                appTextField(
                    controller: controller.pickupPointController,
                    icon: Icons.location_on,
                    labelText: "PickUp Point",),
                SizedBox(height: 20),

                // Destination Point
                appTextField(
                    controller: controller.destinationController,
                    icon: Icons.location_on,
                    labelText: "Destination"),
                SizedBox(height: 20),

                // Date Picker
                appTextField(
                  controller: dateController,
                 icon: Icons.calendar_view_day,
                 labelText: "Date",
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      dateController.text = formattedDate;
                    }
                  },
                ),
                SizedBox(height: 20),

                // Time Picker
                appTextField(
                  controller: timeController,
                  icon: Icons.access_time,
                  labelText: "Time",
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      String formattedTime = pickedTime.format(context);
                      timeController.text = formattedTime;
                    }
                  },
                ),
                SizedBox(height: 40),

                // Confirm Reservation Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle reservation logic here
                      Get.snackbar(
                        "Reservation Confirmed",
                        "Your ride from ${pickupController.text} to ${destinationController.text} has been reserved!",
                        backgroundColor: Colors.pink,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Square borders
                      ),
                    ),
                    child: Text("Confirm Reservation",
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
