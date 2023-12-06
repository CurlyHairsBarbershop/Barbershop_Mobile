import 'package:flutter/material.dart';
import 'package:curly_hairs/models/service_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class EditServiceScreen extends StatefulWidget {
  final Service service;

  EditServiceScreen({required this.service});

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _costController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the existing service data
    _nameController = TextEditingController(text: widget.service.name);
    _descriptionController =
        TextEditingController(text: widget.service.description);
    _costController = TextEditingController(text: widget.service.cost.toString());
  }

  Future<void> _editService() async {
    try {
      // Update the Service instance with new values
      Service updatedService = Service(
        id: widget.service.id, // Keep the existing ID
        name: _nameController.text,
        description: _descriptionController.text,
        cost: double.parse(_costController.text),
      );

      // Call the API to edit the service
      await ApiService.editService(widget.service.id, updatedService);

      // Service edited successfully, navigate back or show a success message
      Navigator.of(context).pop();
    } catch (e) {
      // Handle error editing service
      print('Error editing service: $e');
      // Show an error message or handle it as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Service"),
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
              onPressed: _editService,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    super.dispose();
  }
}