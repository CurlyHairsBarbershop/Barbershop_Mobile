import 'barber_model.dart';
import 'client_model.dart';
import 'service_model.dart';

class Appointment {
  Barber? barber;
  Client? client;
  DateTime? appointmentTime;
  List<Service> services;
  double totalSum;
  String? paymentMethod;

  Appointment({
    this.barber,
    this.client,
    this.appointmentTime,
    required this.services,
    this.totalSum = 0.0,
    this.paymentMethod = '',
  });
}
