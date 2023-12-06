import 'package:flutter/material.dart';
import 'package:curly_hairs/models/service_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/screens/admin_screens/edit_service_screen.dart';
import 'package:curly_hairs/screens/admin_screens/add_service_screen.dart';

class ManageServicesScreen extends StatefulWidget {
  @override
  _ManageServicesScreenState createState() => _ManageServicesScreenState();
}

class _ManageServicesScreenState extends State<ManageServicesScreen> {
  late List<Service> services = [];

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      List<Service> fetchedServices = await ApiService.getAllServices();
      setState(() {
        services = fetchedServices;
      });
    } catch (e) {
      // Handle error fetching services
      print('Error fetching services: $e');
    }
  }

  void _navigateToAddServiceScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddServiceScreen()),
    );
  }

  void _navigateToEditServiceScreen(Service service) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditServiceScreen(service: service)),
    );
  }

  Future<void> _deleteService(Service service) async {
    try {
      // Call the API to delete the service
      await ApiService.deleteService(service.id);
      // Refresh services after deletion
      await _fetchServices();
    } catch (e) {
      // Handle error deleting service
      print('Error deleting service: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Services"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _navigateToAddServiceScreen,
              child: Text('Add Service'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            SizedBox(height: 16), // Space between add service and services list
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(services[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _navigateToEditServiceScreen(services[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteService(services[index]);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
