import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class EditBarberScreen extends StatefulWidget {
  final Barber barber;

  EditBarberScreen({required this.barber});

  @override
  _EditBarberScreenState createState() => _EditBarberScreenState();
}

class _EditBarberScreenState extends State<EditBarberScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.barber.name);
    _lastNameController = TextEditingController(text: widget.barber.lastName);
    _emailController = TextEditingController(text: widget.barber.email);
    _phoneNumberController =
        TextEditingController(text: widget.barber.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _submitChanges() async {
    // Create a map with the updated barber data
    Map<String, dynamic> updatedData = {
      'name': _nameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneNumberController.text,
      // Add other fields as needed
    };

    try {
      await ApiService.editBarber(widget.barber.id, updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Barber updated successfully')),
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update barber')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Barber Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            ElevatedButton(
              onPressed: _submitChanges,
              child: Text('Submit Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
