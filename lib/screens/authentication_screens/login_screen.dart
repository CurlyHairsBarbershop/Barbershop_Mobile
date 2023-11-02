// file: login_screen.dart

import 'package:curly_hairs/screens/client_screens/client_home_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_profile_screen.dart';
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
                // uncomment when connected to db
                //bool success = await ApiService.loginUser(loginModel);
                bool success = true;

                // TODO: redirect to screen according to role
                if (success) {
                  // for now, redirect to client profile (but need to change ASAP)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => ClientHomeScreen(
                              initialTabIndex: 2,
                            )),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login failed. Please try again.")),
                  );
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

//------------------------------------------------------------------------

