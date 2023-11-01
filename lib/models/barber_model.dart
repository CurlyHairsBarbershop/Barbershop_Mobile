import 'package:curly_hairs/models/user_model.dart';

class Barber extends UserData {
  Barber({
    required String name,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) : super(
          name: name,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
        );
}
