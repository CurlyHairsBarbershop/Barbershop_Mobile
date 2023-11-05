import 'user_model.dart';
import 'role_model.dart';

class Client extends UserData {
  Client({
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
