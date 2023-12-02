import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: ApiService.getAllAppointments(),
      builder: (context, snapshot) {
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
              title: Text('Appointment Time: ${appointment.appointmentTime}'),
              subtitle: Text('Barber: ${appointment.barber?.toString()}' + '\nServices: ${appointment.services.map((s) => s.name).join(', ')}'),
            );
              },
            ),
          );
        }
    );
  }
}