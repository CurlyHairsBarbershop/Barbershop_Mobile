import 'package:curly_hairs/models/barber_model.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class FavoriteBarbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Barber>>(
      future: ApiService.getFavoriteBarbers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Center(
            child: CircularProgressIndicator(), // Replace this with your loading indicator
          );
        } else if (snapshot.hasError) {
  // Error state  
        return Scaffold(
          appBar: AppBar(
              title: Text('Favorite Barbers'),
            ),
          body: Center(
            child: Container(
              color: Colors.grey[200], // Background color
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
        );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // No data state
          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite Barbers'),
            ),
            body: Center(
              child: Container(
                color: Colors.grey[200], // Background color
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No barbers available.',
                  style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          );
        } else {
          List<Barber> fetchedBarbers = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite Barbers'),
            ),
            body: ListView.builder(
              itemCount: fetchedBarbers.length,
              itemBuilder: (context, index) {
                final barber = fetchedBarbers[index];
                return ListTile(
                  title: Text(
                    '${barber.lastName} ' + '${barber.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${barber.email}',
                    style: TextStyle(fontSize: 14),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
