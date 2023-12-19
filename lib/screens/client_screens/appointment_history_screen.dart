import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: ApiService.getAllAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Appointment History')),
            body: _buildErrorMessage(snapshot.error.toString()),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text('Appointment History')),
            body: _buildNoDataMessage(),
          );
        } else {
          List<Appointment> fetchedAppointments = snapshot.data!;
          return Scaffold(
            appBar: AppBar(title: Text('Appointment History')),
            body: ListView.builder(
              itemCount: fetchedAppointments.length,
              itemBuilder: (context, index) {
                final appointment = fetchedAppointments[index];
                return Card(
                  color: Colors.blue[100],
                  margin: EdgeInsets.all(8.0),
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0), // Add padding inside the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Appointment: ${_formatDateTime(appointment.appointmentTime)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8), // Add space between elements
                        Text(
                          'Barber: ${appointment.barber?.name ?? "Unknown"}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Services: ${appointment.services.map((s) => s.name).join(', ')}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "Unknown";
    // Define your date format here
    return DateFormat('yyyy-MM-dd: HH:mm').format(dateTime.toLocal());
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Error: $message',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildNoDataMessage() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No appointments available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
