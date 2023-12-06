import 'barber_model.dart';
import 'client_model.dart';
import 'service_model.dart';

class Appointment {
  int id;
  DateTime? appointmentTime;
  Barber? barber;
  List<Service> services;

  Appointment({
    required this.id,
    required this.barber,
    required this.appointmentTime,
    required this.services,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    print(json);
    return Appointment(
      id: json['id'] as int,
      appointmentTime: DateTime.parse(json['at']),
      barber: Barber.fromJson(json['barber']),
      services: (json['favors'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'at': appointmentTime?.toIso8601String(),
      'barber': barber?.toJson(),
      'favors': services.map((service) => service.toJson()).toList(),
    };
  }
}
