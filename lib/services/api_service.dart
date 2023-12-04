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

    if (response.statusCode == 201) {
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

    if (response.statusCode == 200) {
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

    if (response.statusCode <= 300) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await UserService.storeToken(token);
      // return true;
      // You can also return the token if needed
      // return token;
    } else {
      print('Login failed');
      // return false;
    }
  }

  static Future<List<Barber>> getAllBarbers() async {
    final response = await http.get(Uri.parse('$baseUrl/barbers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return data.map((barberJson) => Barber.fromJson(barberJson)).toList();
    } else {
      throw Exception('Failed to fetch barbers');
    }
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

    if (response.statusCode == 200) 
    {
      final List<dynamic> data = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
          'at': appointmentJson['at'],
          'barber': appointmentJson['barber'],
          'favors': serviceDetails.map((service) => service.toJson()).toList(),
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

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return data.map((serviceJson) => Service.fromJson(serviceJson)).toList();
    } else {
      throw Exception('Failed to fetch barbers');
    }
  }

  static Future<Service> getServiceDetailsById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/favors/$id'));

    if (response.statusCode == 200) {
      final dynamic serviceJson = json.decode(response.body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return Service.fromJson(serviceJson);
    } 
    else {
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

    if (response.statusCode == 202) {
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

    if (response.statusCode == 201) {
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
}
