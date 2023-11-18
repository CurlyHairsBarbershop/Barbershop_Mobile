import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/screens/client_screens/client_home_screen.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_barber_page.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_service_page.dart';
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
      appBar: AppBar(
        title: Text("Make appointment"),
        automaticallyImplyLeading: false,
      ),
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

  Future<void> submitAppointment() async {
    // Calculate the total sum of the services

    print('-----APPOINTMENT TO POST-----');
    // print(appointment.toJson());

    if (appointment.barber != null &&
        appointment.appointmentTime != null &&
        appointment.services.isNotEmpty) {
      try {
        await ApiService.postAppointment(appointment.toJson());

        // placeholder
        // setState(() {
        //   // appointment.id = '';
        //   appointment.barber = null;
        //   appointment.appointmentTime = DateTime.now();
        //   appointment.services = [];
        // });
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