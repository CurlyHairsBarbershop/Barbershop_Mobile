// file: client_home_screen.dart

import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/models/client_model.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/screens/client_screens/client_profile_screen.dart';
import 'package:curly_hairs/screens/client_screens/client_make_appointment_screen.dart';
import 'package:curly_hairs/pages/explore_page.dart';

class ClientHomeScreen extends StatefulWidget {
  final int initialTabIndex;

  ClientHomeScreen({this.initialTabIndex = 0});

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _currentIndex = 0;
  final List<String> _titles = [
    'Explore',
    'Make Appointment',
    'Profile',
  ];

  Future<Appointment>? _appointmentFuture;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    _appointmentFuture = _initAppointment();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  Future<Appointment> _initAppointment() async {
    Appointment appointment = Appointment(
      id: 0,
      barber: null,
      appointmentTime: null,
      services: [],
    );

    return appointment;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Appointment>(
      future: _appointmentFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Appointment appointment = snapshot.data!;
          List<Widget> _children = [
            ExplorePage(),
            MakeAppointmentScreen(appointment: appointment),
            ClientProfileScreen(),
          ];

          return Scaffold(
            // appBar: AppBar(
            //   title: Text(_titles[_currentIndex]),
            //   automaticallyImplyLeading: false,
            // ),
            body: Center(
              child: _children[_currentIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Make Appointment',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Profile',
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load appointment data'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
//------------------------------------------------------------------------
