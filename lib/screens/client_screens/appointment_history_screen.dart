import 'package:flutter/material.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment History"),
      ),
      body: Center(
        child: Text("Your appointment history will be displayed here."),
      ),
    );
  }
}
