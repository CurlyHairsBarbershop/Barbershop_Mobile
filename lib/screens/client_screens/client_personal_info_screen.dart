import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  // Sample user data - replace this with actual data source
  final Map<String, String> userInfo = {
    'firstName': 'John',
    'lastName': 'Doe',
    'email': 'johndoe@example.com',
    'phone': '+1234567890',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('First Name: ${userInfo['firstName']}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8), // For spacing
            Text('Last Name: ${userInfo['lastName']}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8), // For spacing
            Text('Email: ${userInfo['email']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8), // For spacing
            Text('Phone: ${userInfo['phone']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
