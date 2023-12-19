import 'package:flutter/material.dart';
import 'package:curly_hairs/screens/client_screens/client_change_password_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_edit_personal_info_screen.dart';
import 'package:curly_hairs/models/user_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  Future<UserData>? _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = ApiService.getUserData();
  }

  void _refreshUserData() {
    setState(() {
      _userDataFuture = ApiService.getUserData();
    });
  }

  void _navigateToEditScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditPersonalInfoScreen()),
    );
    if (result == true) {
      _refreshUserData();
    }
  }

  void _navigateToChangePasswordScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: FutureBuilder<UserData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email: ${userData.email}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('First Name: ${userData.name}',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('Last Name: ${userData.lastName}',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Edit Personal Info'),
                    onPressed: _navigateToEditScreen,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: Icon(Icons.lock_outline),
                    label: Text('Change Password'),
                    onPressed: _navigateToChangePasswordScreen,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }
}
