// file: client_profile_screen.dart

import 'package:curly_hairs/screens/client_screens/appointment_history_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_personal_info_screen.dart';
import 'package:curly_hairs/screens/client_screens/favorite_barbers_screen.dart';
import 'package:curly_hairs/screens/guest_screens/guest_home_screen.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:flutter/material.dart';

class ClientProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // prevents the screen from being popped
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Personal Info'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInfoScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Appointment History'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentHistoryScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite_border_outlined),
                title: Text('Favorite Barbers'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteBarbersScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
                onTap: () async {
                  await UserService.clearToken();
                  // for now, lets navigate to guest profile screen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => GuestHomeScreen(
                              initialTabIndex: 1,
                            )),
                    (Route<dynamic> route) => false,
                  );
                  // Implement log-out functionality
                  // Example: context.read<AuthenticationService>().signOut();
                  print('Log Out Tapped'); // Placeholder action
                },
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}


//------------------------------------------------------------------------

