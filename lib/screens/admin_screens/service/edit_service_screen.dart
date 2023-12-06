import 'package:flutter/material.dart';

class EditServiceScreen extends StatelessWidget {
  // You might want to accept a service object as a parameter if you have one
  // final Service service;

  // EditServiceScreen({this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Service'),
      ),
      body: Center(
        // Add your form or UI elements for editing a service here
        child: Text('Edit Service Form Goes Here'),
      ),
    );
  }
}
