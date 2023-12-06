import 'barber_model.dart';
import 'client_model.dart';
import 'service_model.dart';

class Appointment {
  int id;
  DateTime? appointmentTime;
  Barber? barber;
  List<Service> services;
  bool cancelled;

  Appointment({
    required this.id,
    required this.appointmentTime,
    required this.barber,
    required this.services,
    required this.cancelled,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as int,
      appointmentTime:
          json['at'] != null ? DateTime.parse(json['at'] as String) : null,
      barber: Barber.fromJson(json['barber'] as Map<String, dynamic>),
      services: (json['favors'] as List)
          .map((serviceJson) =>
              Service.fromJson(serviceJson as Map<String, dynamic>))
          .toList(),
      cancelled: json['cancelled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'at': appointmentTime?.toIso8601String(),
      'barberId': barber!.id,
      'serviceIds': services.map((service) => service.id).toList(),
      'cancelled': cancelled,
    };
  }
}
