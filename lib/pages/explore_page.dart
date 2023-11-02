//file: explore_page.dart

import 'package:flutter/material.dart';

import 'package:curly_hairs/pages/explore_pages/about_us_page.dart';
import 'package:curly_hairs/pages/explore_pages/barbers_page.dart';
import 'package:curly_hairs/pages/explore_pages/services_page.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.cut),
            title: Text('View Barbershop Services'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServicesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('View Barbers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarbersPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

//----------------------------------


