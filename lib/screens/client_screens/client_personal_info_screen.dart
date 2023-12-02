import 'package:curly_hairs/screens/client_screens/client_change_password_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_edit_personal_info_screen.dart';
import 'package:flutter/material.dart';
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
    _userDataFuture =
        ApiService.getUserData(); // Fetch user data when the screen initializes
  }

  void _refreshUserData() {
    setState(() {
      _userDataFuture = ApiService.getUserData();
    });
  }

  void _navigateToEditScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditPersonalInfoScreen(),
      ),
    );
    // If the edit screen pops with a result, refresh the user data
    if (result == true) {
      _refreshUserData();
    }
  }

  void _navigateToChangePasswordScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangePasswordScreen(),
      ),
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
            // If the UserData is still being fetched, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurred, display it to the user
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // When the UserData is fetched, display it
            final userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('First Name: ${userData.name}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Last Name: ${userData.lastName}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Email: ${userData.email}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  // Text('Phone: ${userData.phoneNumber}',
                  //     style: TextStyle(fontSize: 18)),
                  SizedBox(height: 24), // Add some space before the button
                  ElevatedButton.icon(
                    icon: Icon(Icons.edit), // Icon for the edit button
                    label: Text('Edit'), // Text for the edit button
                    onPressed:
                        _navigateToEditScreen, // Call the function to navigate to the edit screen
                    style: ElevatedButton.styleFrom(
                      // Optional styling
                      primary: Colors.blue, // Background color
                      onPrimary: Colors.white, // Text color
                    ),
                  ),

                  SizedBox(height: 16), // Space between buttons

                  // Change password button
                  ElevatedButton.icon(
                    icon: Icon(Icons.lock_outline),
                    label: Text('Change Password'),
                    onPressed: _navigateToChangePasswordScreen,
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.deepOrange, // Different color to distinguish
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            // If none of the above, this means no data is available
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }
}
