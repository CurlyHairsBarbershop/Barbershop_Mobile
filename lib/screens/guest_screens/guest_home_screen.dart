// guest_home_screen.dart

import 'package:flutter/material.dart';

import 'package:curly_hairs/screens/guest_screens/guest_profile_screen.dart';
import 'package:curly_hairs/pages/explore_page.dart';

class GuestHomeScreen extends StatefulWidget {
  final int initialTabIndex;

  GuestHomeScreen({this.initialTabIndex = 0});

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

