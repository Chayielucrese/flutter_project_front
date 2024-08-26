import 'package:flutter/material.dart';

void main() {
  runApp(ClientProfileApp());
}

class ClientProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client Profile',
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ClientProfilePage(),
    );
  }
}

class ClientProfilePage extends StatefulWidget {
  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  bool _isEditing = false;

  final TextEditingController nameController = TextEditingController(text: "John Doe");
  final TextEditingController phoneController = TextEditingController(text: "+1234567890");
  final TextEditingController emailController = TextEditingController(text: "johndoe@example.com");
  final TextEditingController addressController = TextEditingController(text: "New York, USA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Info',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('Assets/Profile pic-cuate.png'),
                    backgroundColor: Colors.pink,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    onPressed: () {
                      // Action for picking an image
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Card(
     
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
               
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _isEditing ? _buildEditableFields() : _buildProfileInfo(),
                ),
              ),
            ),
            SizedBox(height: 34),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Text(_isEditing ? 'Save Profile' : 'Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProfileInfo() {
    return [
      _buildInfoRow("Name", nameController.text, Icons.person),
      _buildInfoRow("Phone", phoneController.text, Icons.phone),
      _buildInfoRow("Email", emailController.text, Icons.email),
      _buildInfoRow("Address", addressController.text, Icons.location_on),
    ];
  }

  List<Widget> _buildEditableFields() {
    return [
      _buildTextField(
        controller: nameController,
        label: "Name",
        icon: Icons.person,
      ),
      SizedBox(height: 16),
      _buildTextField(
        controller: phoneController,
        label: "Phone Number",
        icon: Icons.phone,
      ),
      SizedBox(height: 16),
      _buildTextField(
        controller: emailController,
        label: "Email",
        icon: Icons.email,
      ),
      SizedBox(height: 16),
      _buildTextField(
        controller: addressController,
        label: "Address",
        icon: Icons.location_on,
      ),
    ];
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink),
          SizedBox(width: 12),
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.pink),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
