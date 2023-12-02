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
      appointmentTime: json['at'],
      barber: json['barberId'],
      services: (json['serviceIds'] as List)
          .map((review) => Service.fromJson(review))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'at': appointmentTime.toString(),
      'barberId': barber!.id,
      'serviceIds': services.map((service) => service.id).toList(),
    };
  }
}
