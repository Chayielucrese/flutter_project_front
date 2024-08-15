import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickComponent extends StatefulWidget {
  final void Function(File) onImageSelected; // Callback to return the selected image

  ImagePickComponent({required this.onImageSelected});

  @override
  _ImagePickComponentState createState() => _ImagePickComponentState();
}

class _ImagePickComponentState extends State<ImagePickComponent> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage!); // Return the selected image
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectedImage != null
            ? Image.file(
                _selectedImage!,
                height: 200,
                width: 200,
              )
            : Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 200,
              ),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Pick Image'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
          ),
        ),
      ],
    );
  }
}
