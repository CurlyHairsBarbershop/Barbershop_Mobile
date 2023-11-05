// file: client_make_appointment.dart

// import 'package:flutter/material.dart';

// class MakeAppointmentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Make Appointment'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Text('Content goes here'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/screens/client_screens/client_home_screen.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_barber_page.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_service_page.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_payment_page.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_date_page.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final Appointment appointment;

  MakeAppointmentScreen({required this.appointment});

  @override
  _MakeAppointmentScreenState createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  Appointment get appointment => widget.appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Choose a Barber'),
            onTap: () {
              navigateToChooseBarberPage();
            },
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Choose a Date'),
            onTap: () {
              navigateToChooseDatePage();
            },
          ),
          ListTile(
            leading: Icon(Icons.cut),
            title: Text('Choose a Service'),
            onTap: () {
              navigateToChooseServicePage();
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Choose a Payment Method'),
            onTap: () {
              navigateToChoosePaymentPage();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          submitAppointment();
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void navigateToChooseBarberPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseBarberPage(appointment: appointment),
      ),
    );
  }

  void navigateToChooseDatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseDatePage(appointment: appointment),
      ),
    );
  }

  void navigateToChooseServicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseServicePage(appointment: appointment),
      ),
    );
  }

  void navigateToChoosePaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChoosePaymentPage(appointment: appointment),
      ),
    );
  }

  Future<void> submitAppointment() async {
    // Calculate the total sum of the services
    double totalSum = 0.0;
    for (var service in appointment.services) {
      totalSum += service.cost;
    }
    appointment.totalSum = totalSum;
    print('-----APPOINTMENT TO POST-----');
    // print(appointment.toJson());

    if (appointment.barber != null &&
        appointment.appointmentTime != null &&
        appointment.services.isNotEmpty &&
        appointment.paymentMethod != null) {
      try {
        // await ApiService.postAppointment(appointment);
        setState(() {
          // appointment.id = '';
          appointment.barber = null;
          appointment.appointmentTime = DateTime.now();
          appointment.services = [];
          appointment.paymentMethod = null;
          appointment.totalSum = 0;
        });
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        navigateToMakeAppointmentScreen();
      } catch (error) {
        print(error);
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        navigateToMakeAppointmentScreen();
      }
    } else {
      // Show a validation error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please complete all appointment details before submission.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void navigateToMakeAppointmentScreen() {
    // Navigate to the CustomerHomeScreen with MakeAppointmentScreen active in the BottomNavigationBar
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ClientHomeScreen()),
      (Route<dynamic> route) => false,
    );
    //ClientHomeScreen.globalKey.currentState?.setCurrentIndex(0);
  }
}


//-----------------------------------------------