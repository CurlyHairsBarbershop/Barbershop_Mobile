import 'package:flutter/material.dart';
import 'package:curly_hairs/models/service_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  Future<void> _addService() async {
    try {
      // Create a new Service instance using the input values
      Service newService = Service(
        id: 0, // Set the ID as needed or handle it on the backend
        name: _nameController.text,
        description: _descriptionController.text,
        cost: double.parse(_costController.text),
      );

      // Call the API to add the service
      await ApiService.addService(newService);

      // Service added successfully, navigate back or show a success message
      Navigator.of(context).pop();
    } catch (e) {
      // Handle error adding service
      print('Error adding service: $e');
      // Show an error message or handle it as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _costController,
              decoration: InputDecoration(labelText: 'Cost'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addService,
              child: Text('Add Service'),
            ),
          ],
        ),
      ),
    );
  }
}
