import 'package:flutter/material.dart';

class EditBarberScreen extends StatelessWidget {
  // You might want to accept a barber object as a parameter if you have one
  // final Barber barber;

  // EditBarberScreen({this.barber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Barber'),
      ),
      body: Center(
        // Add your form or UI elements for editing a barber here
        child: Text('Edit Barber Form Goes Here'),
      ),
    );
  }
}
