import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationScreen extends StatelessWidget {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Book a Ride'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pickup Point
              TextField(
                controller: pickupController,
                decoration: InputDecoration(
                  labelText: 'Pickup Point',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on, color: Colors.pink),
                ),
              ),
              SizedBox(height: 20),

              // Destination Point
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination Point',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on, color: Colors.pink),
                ),
              ),
              SizedBox(height: 20),

              // Date Picker
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.pink),
                ),
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
              TextField(
                controller: timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time, color: Colors.pink),
                ),
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
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Square borders
                    ),
                  ),
                  child: Text("Confirm Reservation", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
