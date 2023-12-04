import 'package:flutter/material.dart';
import 'package:curly_hairs/screens/admin_screens/add_barber_screen.dart';
import 'package:curly_hairs/screens/admin_screens/edit_barber_screen.dart';

class ManageBarbersScreen extends StatefulWidget {
  @override
  _ManageBarbersScreenState createState() => _ManageBarbersScreenState();
}

class _ManageBarbersScreenState extends State<ManageBarbersScreen> {
  void _navigateToAddBarberScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddBarberScreen()),
    );
  }

  void _navigateToEditBarberScreen() {
    // You might want to pass some data to the EditBarberScreen
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EditBarberScreen(/* Pass barber data here */)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Barbers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _navigateToAddBarberScreen,
                  child: Text('Add Barber'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Button color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _navigateToEditBarberScreen,
                  child: Text('Edit Barber'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Button color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
            // ... Add more rows or widgets if needed
          ],
        ),
      ),
    );
  }
}
