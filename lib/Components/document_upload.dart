import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadGrid extends StatelessWidget {
  final List<File?> images;
  final List<String> labels;
  final List<IconData> icons;
  final void Function(int, File) onImagePick;

  DocumentUploadGrid({
     required this.images,
    required this.labels,
    required this.icons,
    required this.onImagePick,
  });

  Future<void> _pickImage(BuildContext context, int index) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePick(index, File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        String label = labels[index];
        IconData icon = icons[index];
        File? imageFile = images[index];

        return GestureDetector(
          onTap: () => _pickImage(context, index),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Stack(
              children: [
                if (imageFile != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: Colors.black,
                          size: 50.0,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          label,
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 8.0,
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
    );
  }
}
