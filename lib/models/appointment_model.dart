import 'barber_model.dart';
import 'client_model.dart';
import 'service_model.dart';

class Appointment {
  DateTime appointmentTime;
  Barber barber;
  List<Service> services;

  Appointment({
    required this.barber,
    required this.appointmentTime,
    required this.services
  });
}
