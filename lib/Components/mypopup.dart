import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/document_upload.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// Import the DocumentUploadGrid widget

class MyPopupComponent extends StatefulWidget {

  
  final void Function(int, File?) onDocumentSelected;

  MyPopupComponent({required this.onDocumentSelected});

  @override
  _MyPopupComponentState createState() => _MyPopupComponentState();
}

class _MyPopupComponentState extends State<MyPopupComponent> {
  final List<File?> _uploadedDocuments = List.filled(4, null);

  void _handleDocumentSelection(int index, File? file) {
    File pickedFile = File(file!.path);
    setState(() {
      _uploadedDocuments[index] = pickedFile;
    });
    widget.onDocumentSelected(index, pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Vehicle Documents',
        style: TextStyle(
            color: Colors.pink, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: DocumentUploadGrid(
        images: _uploadedDocuments,
        labels: [
          'Vehicle Insurance Certificate',
          'Vehicle Registration Certificate',
          'Vehicle Road Worthiness Report',
          'Vehicle Sales Certificate'
        ],
        icons: [Icons.image, Icons.image, Icons.image, Icons.image],
        onImagePick: (index, file) {
          [_handleDocumentSelection(index, file)];
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            // Get.toNamed(AppRoutes.viewvehicle);
          },
          child: Text('OK', style: TextStyle(color: Colors.pink)),
        ),
      ],
    );
  }
}

Future<void> showPopup(
    BuildContext context, void Function(int, File?) onDocumentSelected) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return MyPopupComponent(
        onDocumentSelected: onDocumentSelected,
      );
    },
  );
}
