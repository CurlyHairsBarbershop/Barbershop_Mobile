import 'package:flutter/material.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:curly_hairs/pages/explore_pages/barber_profile_page.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/pages/explore_pages/barber_profile_guest_page.dart';
import 'dart:typed_data';
import 'dart:convert';

class BarbersPage extends StatefulWidget {
  @override
  _BarbersPageState createState() => _BarbersPageState();
}

class _BarbersPageState extends State<BarbersPage> {
  late Future<List<Barber>> _barbersFuture;

  @override
  void initState() {
    super.initState();
    _fetchBarbers();
  }

  Future<void> _fetchBarbers() async {
    _barbersFuture = ApiService.getAllBarbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbers'),
      ),
      body: FutureBuilder<List<Barber>>(
        future: _barbersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No barbers found.'));
          } else {
            List<Barber> barbers = snapshot.data!;
            return ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                Barber barber = barbers[index];
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  color: Colors.blue[100],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          MemoryImage(base64.decode(barber.image ?? '')),
                    ),
                    title: Text('${barber.name} ${barber.lastName}'),
                    onTap: () async {
                      String? token = await UserService.getToken();
                      if (token != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BarberProfilePage(barber: barber),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BarberProfileGuestPage(barber: barber),
                          ),
                        );
                      }
                    },
                    
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
