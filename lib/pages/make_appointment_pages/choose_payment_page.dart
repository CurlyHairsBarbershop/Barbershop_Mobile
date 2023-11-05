import 'package:flutter/material.dart';
import 'package:curly_hairs/pages/make_appointment_pages/card_payment_page.dart';
import 'package:curly_hairs/models/appointment_model.dart';
// import 'package:curly_hairs/screens/customer_screens/customer_home_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_make_appointment_screen.dart';

class ChoosePaymentPage extends StatefulWidget {
  final Appointment appointment;

  ChoosePaymentPage({required this.appointment});

  @override
  _ChoosePaymentPageState createState() => _ChoosePaymentPageState();
}

class _ChoosePaymentPageState extends State<ChoosePaymentPage> {
  String? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Payment Method'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text('Credit Card'),
            leading: Radio(
              value: 'card',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                  widget.appointment.paymentMethod = paymentMethod;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Cash'),
            leading: Radio(
              value: 'cash',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                  widget.appointment.paymentMethod = paymentMethod;
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (paymentMethod != null) {
            if (paymentMethod == 'card') {
              navigateToCardPaymentPage();
            } else {
              navigateToMakeAppointmentScreen();
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please choose a payment method.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  void navigateToCardPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardPaymentPage(appointment: widget.appointment),
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
