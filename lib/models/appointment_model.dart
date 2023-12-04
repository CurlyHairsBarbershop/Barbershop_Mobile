import 'barber_model.dart';
import 'client_model.dart';
import 'service_model.dart';

class Appointment {
  DateTime? appointmentTime;
  Barber? barber;
  List<Service> services;

  Appointment(
      {required this.barber,
      required this.appointmentTime,
      required this.services});

    factory Appointment.fromJson(Map<String, dynamic> json) {
    print(json);
    return Appointment(
      appointmentTime: DateTime.parse(json['at']),
      barber: Barber.fromJson(json['barber']),
      services: (json['favors'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'at': appointmentTime.toString(),
      'barber': barber,
      'favors': services,
    };
  }
}
