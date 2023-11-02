// file: client_home_screen.dart

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

  final List<Widget> _children = [
    ExplorePage(),
    MakeAppointmentScreen(),
    ClientProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}


//------------------------------------------------------------------------


