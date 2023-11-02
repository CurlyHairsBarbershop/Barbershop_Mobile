import 'package:curly_hairs/screens/client_screens/client_home_screen.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/register_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

// TODO: add validation for fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm Password"),
              obscureText: true,
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            ElevatedButton(
              onPressed: () async {
                RegisterModel registerModel = RegisterModel(
                  email: emailController.text,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  phoneNumber: phoneNumberController.text,
                );
                await ApiService.registerUser(registerModel);

                // TODO: redirect to screen according to role
                if (await UserService.getToken() != null) {
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
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
