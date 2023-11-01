import 'package:flutter/material.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/models/service_model.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    // Instead of fetching from an API, we are hardcoding the services
    services = [
      Service(name: "Haircut", cost: 15.00, duration: Duration(minutes: 30)),
      Service(name: "Shaving", cost: 10.00, duration: Duration(minutes: 15)),
      Service(name: "Hair Coloring", cost: 50.00, duration: Duration(hours: 2)),
      // Add more services as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          Service service = services[index];
          return ListTile(
            leading: Icon(Icons.cut),
            title: Text(service.name),
            subtitle: Text(
                'Price: \$${service.cost.toStringAsFixed(2)}\nDuration: ${service.duration.inMinutes} minutes'),
          );
        },
      ),
    );
  }
}
