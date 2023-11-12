import 'package:curly_hairs/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class CommentPage extends StatefulWidget {
  final Barber barber;

  const CommentPage({required this.barber});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      // List<Review> fetchedReviews =
      //     await ApiService.fetchReviews(widget.barber.barberId);

      List<Review> fetchedReviews = [
        Review(
          id: 1, // Assuming you have a unique identifier for each review
          title: 'Fantastic Haircut!', // Placeholder title
          content: 'Great service! Highly recommend.',
          rating: 5.0,
          publisher: UserData(
            name: 'John',
            lastName: 'Doe',
            email: 'john.doe@example.com',
            phoneNumber: '123-456-7890',
          ),
          replies: [],
        ),
        Review(
          id: 1, // Assuming you have a unique identifier for each review
          title: 'Fantastic Haircut!', // Placeholder title
          content: 'Good service, will visit again.',
          rating: 4.0,
          publisher: UserData(
            name: 'Jane',
            lastName: 'Doe',
            email: 'jane.doe@example.com',
            phoneNumber: '098-765-4321',
          ),
          replies: [],
        ),
        Review(
          id: 1, // Assuming you have a unique identifier for each review
          title: 'Fantastic Haircut!', // Placeholder title
          content: 'Service was okay, could be better.',
          rating: 3.0,
          publisher: UserData(
            name: 'Jim',
            lastName: 'Beam',
            email: 'jim.beam@example.com',
            phoneNumber: '555-555-5555',
          ),
          replies: [],
        ),
        // ...add more Review instances as needed
      ];

      setState(() {
        reviews = fetchedReviews;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          Review review = reviews[index];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person), // replace with commenter image
            ),
            title: Text(review.rating.toString()), // replace with rating
            subtitle: Text(review.content), // replace with comment
          );
        },
      ),
    );
  }
}
