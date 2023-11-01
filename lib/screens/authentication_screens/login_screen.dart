import 'package:flutter/material.dart';
import 'package:curly_hairs/models/login_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

// TODO: add validation for fields
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                LoginModel loginModel = LoginModel(
                  email: emailController.text,
                  password: passwordController.text,
                );

                String? token =
                    " "; // TODO: add String? token = await ApiService.loginUser(loginModel);
                if (token != null) {
                  // Handle successful login, e.g., navigate to a different screen
                } else {
                  // Handle login failure
                  print('Login failed');
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
