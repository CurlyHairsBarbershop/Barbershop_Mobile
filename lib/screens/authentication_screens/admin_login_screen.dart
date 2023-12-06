import 'package:curly_hairs/screens/admin_screens/admin_main_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_home_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_profile_screen.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/login_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class AdminLoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  //   LoginModel loginModel = LoginModel(
                  //     email: emailController.text,
                  //     password: passwordController.text,
                  //   );
                  //   await ApiService.loginAdmin(loginModel);

                  // if (await UserService.getToken() != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdminMainScreen()),
                  );
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content: Text("Login failed. Please try again.")),
                  //   );
                  // }
                  // }
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//------------------------------------------------------------------------

