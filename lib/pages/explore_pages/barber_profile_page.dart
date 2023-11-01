import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';

class Review {
  final double rating;
  final String text;

  Review({required this.rating, required this.text});
}

class BarberProfilePage extends StatefulWidget {
  final Barber barber;

  const BarberProfilePage({required this.barber});

  @override
  _BarberProfilePageState createState() => _BarberProfilePageState();
}

class _BarberProfilePageState extends State<BarberProfilePage> {
  final List<Review> reviews = [
    Review(rating: 4.5, text: "Great service and friendly staff."),
    Review(rating: 5.0, text: "Best haircut I've had in years!"),
    Review(rating: 3.5, text: "Good, but a bit pricey."),
    // Add more reviews as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.barber.name}\'s Profile'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text(widget.barber.name + ' ' + widget.barber.lastName),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text(widget.barber.email),
          ),
          ListTile(
            title: Text('Phone Number'),
            subtitle: Text(widget.barber.phoneNumber),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Text('Reviews', style: Theme.of(context).textTheme.headline6),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // to prevent inner scroll
            shrinkWrap: true, // necessary for nested ListViews
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              Review review = reviews[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person), // Placeholder for commenter image
                ),
                title: Text(review.rating.toString()), // Display rating
                subtitle: Text(review.text), // Display comment
              );
            },
          ),
        ],
      ),
    );
  }
}
