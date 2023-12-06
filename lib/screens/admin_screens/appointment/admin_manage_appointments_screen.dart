import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class ManageAppointmentsScreen extends StatefulWidget {
  @override
  _ManageAppointmentsScreenState createState() =>
      _ManageAppointmentsScreenState();
}

class _ManageAppointmentsScreenState extends State<ManageAppointmentsScreen> {
  Future<List<Appointment>>? _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = ApiService.getAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Appointments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Appointment>>(
          future: _appointmentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Appointment appointment = snapshot.data![index];
                  return ListTile(
                    title: Text(
                        'Appointment with ${appointment.barber?.name ?? "N/A"}'),
                    subtitle: Text('Time: ${appointment.appointmentTime}'),
                    // Add more details as needed
                  );
                },
              );
            } else {
              return Center(child: Text("No appointments found"));
            }
          },
        ),
      ),
    );
  }
}
