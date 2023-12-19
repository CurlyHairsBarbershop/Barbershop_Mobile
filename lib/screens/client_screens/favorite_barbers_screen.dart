import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'dart:convert'; // Needed for base64 decoding

class FavoriteBarbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Barbers'),
      ),
      body: FutureBuilder<List<Barber>>(
        future: ApiService.getFavoriteBarbers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 16)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No favorite barbers available.',
                  style: TextStyle(fontSize: 16)),
            );
          } else {
            List<Barber> fetchedBarbers = snapshot.data!;
            return ListView.builder(
              itemCount: fetchedBarbers.length,
              itemBuilder: (context, index) {
                final barber = fetchedBarbers[index];
                return Card(
                  color: Colors.blue[100], // Light blue background color
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          MemoryImage(base64.decode(barber.image ?? '')),
                    ),
                    title: Text('${barber.name} ${barber.lastName}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${barber.email}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
