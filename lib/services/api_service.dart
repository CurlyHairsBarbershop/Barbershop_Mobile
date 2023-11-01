import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:curly_hairs/models/register_model.dart';
import 'package:curly_hairs/models/login_model.dart';
import 'package:curly_hairs/models/user_model.dart';
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

    if (response.statusCode == 202) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await UserService.storeToken(token);

      // You can also return the token if needed
      // return token;
    } else {
      print('Login failed');
    }
  }
}
