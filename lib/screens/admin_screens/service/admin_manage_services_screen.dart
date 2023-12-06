import 'package:flutter/material.dart';
import 'package:curly_hairs/screens/admin_screens/service/add_service_screen.dart';
import 'package:curly_hairs/screens/admin_screens/service/edit_service_screen.dart';

class ManageServicesScreen extends StatefulWidget {
  @override
  _ManageServicesScreenState createState() => _ManageServicesScreenState();
}

class _ManageServicesScreenState extends State<ManageServicesScreen> {
  void _navigateToAddServiceScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddServiceScreen()),
    );
  }

  void _navigateToEditServiceScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              EditServiceScreen(/* Pass service data here */)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Services"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _navigateToAddServiceScreen,
              child: Text('Add Service'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            SizedBox(height: 16), // Space between buttons
            ElevatedButton(
              onPressed: _navigateToEditServiceScreen,
              child: Text('Edit Service'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            // ... Add more widgets if needed
          ],
        ),
      ),
    );
  }
}
