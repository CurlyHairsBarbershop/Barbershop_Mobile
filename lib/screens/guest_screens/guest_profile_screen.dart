import 'package:curly_hairs/screens/authentication_screens/login_screen.dart';
import 'package:curly_hairs/screens/authentication_screens/register_screen.dart';
import 'package:flutter/material.dart';
// import 'package:curly_hairs/screens/role_section_screen.dart'; // for debugging purposes

class GuestProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          // currently not needed
          // ListTile(
          //   leading: Icon(Icons.info),
          //   title: Text('Guest Info'),
          //   onTap: () {
          //     // navigate to Info screen
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.people),
          //   title: Text('Explore Barbers'),
          //   onTap: () {
          //     // navigate to Explore Barbers screen
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.content_cut),
          //   title: Text('Explore Haircuts'),
          //   onTap: () {
          //     // navigate to Explore Haircuts screen
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.login),
          //   title: Text('Log In'),
          //   onTap: () {
          //     // handle log in
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.app_registration),
          //   title: Text('Register'),
          //   onTap: () {
          //     // handle registration
          //   },
          // ),
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
          //             builder: (context) => RoleSelectionScreen(),
          //           ),
          //     );
          //   },
          // ),
        ],
      ).toList(),
    );
  }
}


//--------------------------------------------------

