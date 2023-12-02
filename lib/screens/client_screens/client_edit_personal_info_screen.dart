import 'package:flutter/material.dart';
import 'package:curly_hairs/models/user_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/services/user_service.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();

    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      UserData userData = await ApiService.getUserData();
      _nameController.text = userData.name;
      _lastNameController.text = userData.lastName;
    } catch (e) {
      // Handle error loading user data
    }
  }

  Future<void> _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService.updateClientInfo(
          UserData(
            name: _nameController.text,
            lastName: _lastNameController.text,
            email: '', // Provide email or remove if not required for the update
            phoneNumber:
                '', // Provide phoneNumber or remove if not required for the update
          ),
        );
        // If update is successful, you might want to show a success message or navigate away
      } catch (e) {
        // Handle error updating user info
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Personal Information'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _updateUserInfo,
                child: Text('Update Information'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
