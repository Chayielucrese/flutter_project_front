import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDocumentsPage extends StatelessWidget {
  const DriverDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("My Documents", style: TextStyle(color:Colors.pink),),
            DocumentCard(
              documentType: 'Driver\'s License',
              status: 'Verified',
             
              imageUrl: "",
            ),
            DocumentCard(
              documentType: 'Vehicle Registration',
              status: 'Pending',
             
              imageUrl: "",
         
            ),
            DocumentCard(
              documentType: 'Insurance',
              status: 'Verified',
              
              imageUrl: "",
              
            ),
            // Add more DocumentCards as needed
          ],
        ),
      ),
    );
  }
}


class DocumentCard extends StatelessWidget {
  final String documentType;
  final String status;
  final String imageUrl; 
 


  const DocumentCard({
    Key? key,
    required this.documentType,
    required this.status,
    required this.imageUrl,
 

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the uploaded image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(width: 16),
            // Document details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    documentType,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status: $status',
                    style: TextStyle(color: status == 'Verified' ? Colors.green : Colors.red),
                  ),
                ],
              ),
            ),
            // Action buttons
          ],
        ),
      ),
    );
  }
}
