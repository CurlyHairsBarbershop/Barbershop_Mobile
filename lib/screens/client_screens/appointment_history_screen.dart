import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: ApiService.getAllAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Center(
            child: CircularProgressIndicator(), // Replace this with your loading indicator
          );
        } else if (snapshot.hasError) {
          // Error state
          return Center(
            child: Container(
              color: Colors.grey[200], // Background color
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            )
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // No data state
          return Center(
            child: Container(
              color: Colors.grey[200], // Background color
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No appointments available.',
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          );
        } else {
          List<Appointment> fetchedAppointments = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Appointment History'),
            ),
            body: ListView.builder(
              itemCount: fetchedAppointments.length,
              itemBuilder: (context, index) {
                final appointment = fetchedAppointments[index];
                return ListTile(
                  title: Text(
                    'Appointment Time: ${appointment.appointmentTime}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Barber: ${appointment.barber?.toString()}' +
                        '\nServices: ${appointment.services.map((s) => s.name).join(', ')}',
                    style: TextStyle(fontSize: 14),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
