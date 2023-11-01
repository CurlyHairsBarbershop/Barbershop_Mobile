import 'package:flutter/material.dart';
import 'package:curly_hairs/pages/explore_pages/barber_profile_page.dart';
import 'package:curly_hairs/models/barber_model.dart';

class BarbersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hardcoded list of barbers
    final List<Barber> barbers = [
      Barber(
        name: "James",
        lastName: "Smith",
        email: "james.smith@example.com",
        phoneNumber: "123-456-7890",
      ),
      Barber(
        name: "Robert",
        lastName: "Johnson",
        email: "robert.johnson@example.com",
        phoneNumber: "234-567-8901",
      ),
      Barber(
        name: "Michael",
        lastName: "Williams",
        email: "michael.williams@example.com",
        phoneNumber: "345-678-9012",
      ),
      // Add more items if necessary
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Barbers'),
      ),
      body: ListView.builder(
        itemCount: barbers.length,
        itemBuilder: (context, index) {
          Barber barber = barbers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BarberProfilePage(barber: barber),
                ),
              );
            },
            child: ListTile(
              leading: Icon(Icons.image), // replace with your image
              title: Text(barber.name),
            ),
          );
        },
      ),
    );
  }
}
