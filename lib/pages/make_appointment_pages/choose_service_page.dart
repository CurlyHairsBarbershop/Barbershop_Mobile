import 'package:curly_hairs/screens/client_screens/client_make_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/models/service_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class ChooseServicePage extends StatefulWidget {
  final Appointment appointment;

  ChooseServicePage({required this.appointment});

  @override
  _ChooseServicePageState createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      List<Service> fetchedServices = await ApiService.getAllServices();

      setState(() {
        services = fetchedServices;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Service'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          Service service = services[index];
          return ListTile(
            title: Text(service.name),
            subtitle: Text(
                '\$${service.cost.toStringAsFixed(2)}\nDescription: ${service.description}'),
            onTap: () {
              setState(() {
                if (widget.appointment.services.contains(service)) {
                  widget.appointment.services.remove(service);
                } else {
                  widget.appointment.services.add(service);
                }
              });
            },
            trailing: widget.appointment.services.contains(service)
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.circle_outlined),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.appointment.services.isNotEmpty) {
            navigateToChoosePaymentPage();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select at least one service.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  void navigateToChoosePaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MakeAppointmentScreen(appointment: widget.appointment),
      ),
    );
  }
}
