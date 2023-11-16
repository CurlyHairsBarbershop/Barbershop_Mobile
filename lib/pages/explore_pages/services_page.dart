import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/models/service_model.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: FutureBuilder<List<Service>>(
        future: ApiService.getAllServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data to load, display a loading indicator.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message.
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
            // If no data is available, display a message indicating no barbers found.
            return Text('No barbers found.');
          } else {
            // Data has been loaded successfully. Display the list of barbers.
            List<Service> services = snapshot.data ?? [];
            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                Service service = services[index];
                return GestureDetector(
                  
                  child: ListTile(
                    leading: Icon(Icons.image), // replace with your image
                    title: Text('${service.name}'),
                    subtitle: Text(
                '\$${service.cost.toStringAsFixed(2)}\nDescription: ${service.description}'),
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
