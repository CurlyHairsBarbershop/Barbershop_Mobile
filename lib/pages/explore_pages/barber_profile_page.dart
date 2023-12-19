import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'dart:convert';

class BarberProfilePage extends StatefulWidget {
  final Barber barber;

  const BarberProfilePage({required this.barber});

  @override
  _BarberProfilePageState createState() => _BarberProfilePageState();
}

class _BarberProfilePageState extends State<BarberProfilePage> {
  Barber? selectedBarber;
  bool? isBarberFavorite;

  @override
  void initState() {
    super.initState();
    _fetchBarbers();
    _checkIfFavorite();
  }

  Future<void> _fetchBarbers() async {
    List<Barber> allBarbers = await ApiService.getAllBarbers();
    selectedBarber = allBarbers.firstWhere(
      (barber) => barber.email == widget.barber.email,
      orElse: () => widget.barber,
    );
    setState(() {}); // Update the UI after finding the barber
  }

  Future<void> _checkIfFavorite() async {
    isBarberFavorite = await ApiService.getIsBarberFavorite(widget.barber.id);
    setState(() {});
  }

  Future<void> _toggleFavoriteStatus() async {
    if (isBarberFavorite!) {
      await ApiService.deleteBarberFavorite(widget.barber.id);
    } else {
      await ApiService.addBarberFavorite(widget.barber.id);
    }
    // Update the favorite status after toggling
    _checkIfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedBarber?.name ?? widget.barber.name}\'s Profile'),
        actions: [
          IconButton(
            icon: isBarberFavorite == true
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border),
            onPressed: _toggleFavoriteStatus,
          ),
        ],
      ),
      body: selectedBarber == null
          ? Center(child: CircularProgressIndicator())
          : _buildBarberProfilePage(),
    );
  }

  Widget _buildBarberProfilePage() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: ClipOval(
              child: Image.memory(
                base64.decode(widget.barber.image ?? ''),
                width: 120.0, // Adjust the size as needed
                height: 120.0, // Adjust the size as needed
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text('Name'),
          subtitle: Text(selectedBarber!.name + ' ' + selectedBarber!.lastName),
        ),
        ListTile(
          title: Text('Email'),
          subtitle: Text(selectedBarber!.email),
        ),
        ListTile(
          title: Text('Phone Number'),
          subtitle: Text(selectedBarber!.phoneNumber),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Reviews', style: Theme.of(context).textTheme.headline6),
        ),
        ...selectedBarber!.reviews
            .map((review) =>
                ReviewWidget(review: review, barber: selectedBarber!))
            .toList(),
        SizedBox(height: 20),
      ],
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final Review review;
  final Barber barber;

  ReviewWidget({required this.review, required this.barber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${review.publisher.name}:',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
          ),
          Text(
            review.content,
            style: TextStyle(fontSize: 18.0),
          ),
          // Add other elements like replies if needed
        ],
      ),
    );
  }
}
