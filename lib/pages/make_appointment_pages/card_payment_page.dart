import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
// import 'package:curly_hairs/screens/customer_screens/customer_home_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_make_appointment_screen.dart';

class CardPaymentPage extends StatefulWidget {
  final Appointment appointment;

  CardPaymentPage({required this.appointment});

  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    expirationDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Payment'),
      ),
      body: Column(
        children: [
          TextField(
            controller: cardNumberController,
            decoration: InputDecoration(labelText: 'Card Number'),
          ),
          TextField(
            controller: expirationDateController,
            decoration: InputDecoration(labelText: 'Expiration Date'),
          ),
          TextField(
            controller: cvvController,
            decoration: InputDecoration(labelText: 'CVV'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.appointment.paymentMethod = 'Card';
          navigateToMakeAppointmentScreen();
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void navigateToMakeAppointmentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MakeAppointmentScreen(appointment: widget.appointment),
      ),
    );
  }
}
