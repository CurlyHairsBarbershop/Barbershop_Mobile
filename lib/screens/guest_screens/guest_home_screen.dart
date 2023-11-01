// guest_home_screen.dart

import 'package:flutter/material.dart';

import 'package:curly_hairs/screens/guest_screens/guest_profile_screen.dart';
import 'package:curly_hairs/pages/explore_page.dart';
// import 'package:curly_hairs/screens/role_section_screen.dart';

class GuestHomeScreen extends StatefulWidget {
  @override
  _GuestHomeScreenState createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  int _currentIndex = 0;
  final List<String> _titles = [
    'Explore',
    'Profile',
  ];

  final List<Widget> _children = [
    ExplorePage(),
    GuestProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
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
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//--------------------------------------------------
