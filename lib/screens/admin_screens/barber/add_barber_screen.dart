import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class AddBarberScreen extends StatefulWidget {
  @override
  _AddBarberScreenState createState() => _AddBarberScreenState();
}

class _AddBarberScreenState extends State<AddBarberScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _addBarber() async {
    if (_formKey.currentState!.validate()) {
      Barber newBarber = Barber(
        id: 0, // ID is likely set by your backend
        name: _nameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        earnings: 0.0, // Set default earnings
        rating: 0.0, // Set default rating
        image: '', // Provide a default image or a way to upload one
        reviews: [], // Initialize with no reviews
      );

      try {
        await ApiService.addBarber(newBarber);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Barber added successfully'),
              backgroundColor: Colors.green),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to add barber'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Barber'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _addBarber,
                child: Text('Add Barber'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
