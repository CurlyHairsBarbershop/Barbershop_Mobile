// file: guest_profile_screen.dart

import 'package:curly_hairs/screens/authentication_screens/admin_login_screen.dart';
import 'package:curly_hairs/screens/authentication_screens/login_screen.dart';
import 'package:curly_hairs/screens/authentication_screens/register_screen.dart';
import 'package:flutter/material.dart';

class GuestProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Log In'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Log In As Administrator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Register'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
            // for debugging purposes
            // ListTile(
            //   leading: Icon(Icons.change_circle),
            //   title: Text('Change Role'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => RoleSelectionScreen(),
            //         ),
            //     );
            //   },
            // ),
          ],
        ).toList(),
      ),
    );
  }
}

// -----------------------------------------------------------------

