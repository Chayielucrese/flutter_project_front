import 'package:flutter/material.dart';
import 'dart:async';

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
  bool _isLoading = false;

  Future<void> _showLoadingDialog() async {
    setState(() {
      _isLoading = true;
    });

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Looking for a driver'),
              SizedBox(height: 16),
              LinearProgressIndicator(), // Progress indicator
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: Text('Cancel Request', style: TextStyle(color: Colors.pink)),
            ),
          ],
        );
      },
    );

    // Simulate a network call or some processing time
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop(); // Ensure dialog is closed after processing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showLoadingDialog,
          child: Text('Show Loading Dialog'),
        ),
      ),
    );
  }
}