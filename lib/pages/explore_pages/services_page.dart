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
  void initState() async {
    super.initState();
    services = await ApiService.getAllServices();
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
                'Price: \$${service.cost.toStringAsFixed(2)}\nDescription: ${service.description}'),
          );
        },
      ),
    );
  }
}
