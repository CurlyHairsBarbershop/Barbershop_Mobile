import 'dart:convert';
import 'package:curly_hairs/models/reply_model.dart';
import 'package:curly_hairs/models/service_model.dart';
import 'package:http/http.dart' as http;
import 'package:curly_hairs/models/register_model.dart';
import 'package:curly_hairs/models/login_model.dart';
import 'package:curly_hairs/models/user_model.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'user_service.dart';

class ApiService {
  // TO DO add api link
  static const String baseUrl = "http://194.1.220.48:5092";

  static Future<void> registerUser(RegisterModel registerModel) async {
    final url = Uri.parse('$baseUrl/account/register');
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode(registerModel.toJson());
    print("start request to db");
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Registration successful, store the token using the UserService
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await UserService.storeToken(token);

      // You can also return the token if needed
      // return token;
    } else {
      print('Registration failed ${response.body}');
      print('Registration failed ${response.headers}');
      print('Registration failed ${response.statusCode}');
    }
  }

  static Future<UserData> getUserData() async {
    final url = Uri.parse('$baseUrl/account');

    // Retrieve the token using the UserService
    final token = await UserService.getToken();

    if (token == null) {
      // Handle the case where the token is not available
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the JWT token
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Successful response, parse and use user data
      final jsonResponse = jsonDecode(response.body);
      final userData = UserData.fromJson(jsonResponse);

      return userData; // Return the user data
    } else {
      print('Failed to retrieve user data');
      throw Exception('Failed to retrieve user data');
    }
  }

  static Future<void> loginUser(LoginModel loginModel) async {
    final url = Uri.parse('$baseUrl/account/login'); // Modify the URL as needed
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(loginModel.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await UserService.storeToken(token);
    } else {
      print('Login failed');
    }
  }

  static Future<void> loginAdmin(LoginModel loginModel) async {
    final url = Uri.parse('$baseUrl/admin/login');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(loginModel.toJson());
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];
      await UserService.storeToken(token);
    } else {
      
      print('Login failed');
    }
  }

  static Future<List<Barber>> getAllBarbers() async {
    final response = await http.get(Uri.parse('$baseUrl/barbers'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      List<Barber> result = data.map((barberJson) => Barber.fromJson(barberJson)).toList();
      return result;
    } else {
      throw Exception('Failed to fetch barbers');
    }
  }

  static Future<bool> getIsBarberFavorite(int id) async {
    final url = Uri.parse('$baseUrl/account/favourite-barbers');

    final token = await UserService.getToken();

    if (token == null) {
      // Handle the case where the token is not available
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the JWT token
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((barberJson) => Barber.fromJson(barberJson)).map((x) => x.id).toList().contains(id);
    } 
    else 
    {
      throw Exception('Failed to fetch barbers');
    } 
  }

  static Future<List<Barber>> getFavoriteBarbers() async {
    final url = Uri.parse('$baseUrl/account/favourite-barbers');

    final token = await UserService.getToken();

    if (token == null) {
      // Handle the case where the token is not available
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the JWT token
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((barberJson) => Barber.fromJson(barberJson)).toList();
    } 
    else 
    {
      throw Exception('Failed to fetch barbers');
    }
  }

  static Future<void> addBarberFavorite(int id) async {
    final url = Uri.parse('$baseUrl/barbers/favourite/$id');

    final token = await UserService.getToken();

    if (token == null) {
      // Handle the case where the token is not available
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the JWT token
    };

    final response = await http.patch(url, headers: headers);
  }

  static Future<void> deleteBarberFavorite(int id) async {
    final url = Uri.parse('$baseUrl/barbers/favourite/$id');

    final token = await UserService.getToken();

    if (token == null) {
      // Handle the case where the token is not available
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the JWT token
    };

    final response = await http.delete(url, headers: headers);
  }

  static Future<List<Appointment>> getAllAppointments() async {
    final url = Uri.parse('$baseUrl/appointments');

    // Retrieve the token using the UserService
    final token = await UserService.getToken();

    if (token == null) {
      // Handle the case where the token is not available
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the JWT token
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      print('----------------------------------------------');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('----------------------------------------------');

      List<Future<Appointment>> appointments = data.map((appointmentJson) {
        // Extract service IDs from the appointment JSON
        List<int> serviceIds = (appointmentJson['favors'] as List)
            .map((favor) => favor['id'] as int)
            .toList();

        // Fetch details for each service asynchronously
        List<Future<Service>> serviceDetailsFutures = serviceIds
            .map((serviceId) => ApiService.getServiceDetailsById(serviceId))
            .toList();

        return Future.wait(serviceDetailsFutures).then((serviceDetails) {
          return Appointment.fromJson({
            'id': appointmentJson['id'],
            'at': appointmentJson['at'],
            'barber': appointmentJson['barber'],
            'favors':
                serviceDetails.map((service) => service.toJson()).toList(),
            'cancelled': appointmentJson['cancelled']
          });
        });
      }).toList();

      return Future.wait(appointments);
    } 
    else 
    {
      throw Exception('Failed to fetch appointments');
    }
  }

  static Future<List<Service>> getAllServices() async {
  final response = await http.get(Uri.parse('$baseUrl/favors'));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    final String responseBody = response.body;

    if (responseBody.isNotEmpty) {
      final List<dynamic> data = json.decode(responseBody);

      print('Response status: ${response.statusCode}');
      print('Response body: ${responseBody}');

      return data.map((serviceJson) => Service.fromJson(serviceJson)).toList();
    } else {
      // Handle empty response body
      throw Exception('Empty response body');
    }
  } else {
    throw Exception('Failed to fetch services. Status code: ${response.statusCode}');
  }
}


  static Future<Service> getServiceDetailsById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/favors/$id'));

    if (response.statusCode == 200) {
      final dynamic serviceJson = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return Service.fromJson(serviceJson);
    } else {
      throw Exception('Failed to fetch barbers');
    }
  }

  static Future<List<DateTime>> getAllDateTime(
      int barberID, int dayOffset) async {
    print("Barber ID in getAllDateTime: $barberID");
    print("$baseUrl/barbers/${barberID}/schedule");

    final response =
        await http.get(Uri.parse('$baseUrl/barbers/$barberID/schedule'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data =
          json.decode(response.body.isEmpty ? "[]" : response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return data
          .map((dateTimeJson) => DateTime.parse(dateTimeJson).toLocal())
          .toList();
    } else {
      throw Exception(
          'Failed to fetch date times. Status code ${response.statusCode}');
    }
  }

  static Future<void> postReview(Map<String, dynamic> review) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(review);

    final response = await http.post(Uri.parse('$baseUrl/barbers/comment'),
        headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      throw Exception('Failed to post a review');
    }
  }

  static Future<void> postReply(Map<String, dynamic> reply) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(reply);

    final response = await http.post(Uri.parse('$baseUrl/barbers/reply'),
        headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //final List<dynamic> data = json.decode(response.body);
      //final jsonResponse = jsonDecode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      throw Exception('Failed to post a reply');
    }
  }

  static Future<void> postAppointment(Map<String, dynamic> reply) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(reply);

    print(body.toString());

    final response = await http.post(Uri.parse('$baseUrl/appointments'),
        headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //final List<dynamic> data = json.decode(response.body);
      //final jsonResponse = jsonDecode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      throw Exception('Failed to post an appointment');
    }
  }

  static Future<void> cancelAppointment(int appointmentId) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print("Appointment id to cancel: $appointmentId");

    final response = await http.patch(
      Uri.parse('$baseUrl/appointments/cancel/$appointmentId'),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Appointment canceled successfully');
    } else {
      print(
          'Failed to cancel appointment: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to cancel appointment');
    }
  }

  static Future<void> addBarber(Barber barber) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(barber.toJson());

    final response = await http.post(Uri.parse('$baseUrl/barbers'),
        headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Barber added successfully');
    } else {
      print('Failed to add barber');
      throw Exception('Failed to add barber');
    }
  }

  static Future<void> editBarber(
      int id, Map<String, dynamic> barberData) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(barberData);

    final response = await http.patch(Uri.parse('$baseUrl/barbers/$id'),
        headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Barber edited successfully');
    } else {
      print('Failed to edit barber');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to edit barber');
    }
  }

  static Future<void> deleteBarber(int id) async {
    final token = await UserService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response =
        await http.delete(Uri.parse('$baseUrl/barbers/$id'), headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Barber deleted successfully');
    } else {
      print('Failed to delete barber');
      throw Exception('Failed to delete barber');
    }
  }

  static Future<void> updateClientInfo(UserData user) async {
    final url = Uri.parse('$baseUrl/account');
    final token = await UserService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'name': user.name,
      'lastName': user.lastName,
      // Include other fields as needed
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Update successful
      print('Client info updated successfully');
    } else {
      // Handle failure
      print(
          'Failed to update client info: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to update client info');
    }
  }

  static Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    final url = Uri.parse('$baseUrl/account/password');
    final token = await UserService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 204) {
      // Password change successful
      print('Password changed successfully');
      return true;
    } else {
      // Handle failure
      print(
          'Failed to change password: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

  static Future<void> addService(Service service) async {
  final token = await UserService.getToken();
  if (token == null) {
    throw Exception('Token not found');
  }

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = json.encode(service.toJson());

  final response = await http.post(Uri.parse('$baseUrl/favors'),
      headers: headers, body: body);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    print('Service added successfully');
  } else {
    print('Failed to add service');
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
    throw Exception('Failed to add service');
  }
}

static Future<void> editService(int id, Service service) async {
  final token = await UserService.getToken();
  if (token == null) {
    throw Exception('Token not found');
  }

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = json.encode(service.toJson());

  final response = await http.put(Uri.parse('$baseUrl/favors/$id'),
      headers: headers, body: body);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    print('Service edited successfully');
  } else {
    print('Failed to edit service');
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
    throw Exception('Failed to edit service');
  }
}

static Future<void> deleteService(int id) async {
  final token = await UserService.getToken();
  if (token == null) {
    throw Exception('Token not found');
  }

  final headers = {
    'Authorization': 'Bearer $token',
  };

  final response = await http.delete(Uri.parse('$baseUrl/favors/$id'),
      headers: headers);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    print('Service deleted successfully');
  } else {
    print('Failed to delete service');
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
    throw Exception('Failed to delete service');
  }
}
}
