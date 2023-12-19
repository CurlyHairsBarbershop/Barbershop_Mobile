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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No services found.'));
          } else {
            List<Service> services = snapshot.data!;
            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                Service service = services[index];
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  color:
                      Colors.blue[100], // Light grey color for card background
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    title: Text(service.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('\$${service.cost.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(service.description),
                      ],
                    ),
                    // Optionally, add an onTap event or other widgets
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
