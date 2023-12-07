// file: admin_main_screen.dart

import 'package:curly_hairs/screens/admin_screens/appointment/admin_manage_appointments_screen.dart';
import 'package:curly_hairs/screens/admin_screens/barber/admin_manage_barbers_screen.dart';
import 'package:curly_hairs/screens/admin_screens/service/admin_manage_services_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_personal_info_screen.dart';
import 'package:curly_hairs/screens/guest_screens/guest_home_screen.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // prevents the screen from being popped
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                leading: Icon(Icons.build),
                title: Text('Manage Services'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageServicesScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.content_cut),
                title: Text('Manage Barbers'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageBarbersScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Manage Appointments'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageAppointmentsScreen()),
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

