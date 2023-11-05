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
          reviewID: 1,
          rating: 5,
          text: 'Great service! Highly recommend.',
          appointmentID: 101,
          photo: 'https://example.com/photo1.jpg',
        ),
        Review(
          reviewID: 2,
          rating: 4,
          text: 'Good service, will visit again.',
          appointmentID: 102,
          photo: 'https://example.com/photo2.jpg',
        ),
        Review(
          reviewID: 3,
          rating: 3,
          text: 'Service was okay, could be better.',
          appointmentID: 103,
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
            subtitle: Text(review.text), // replace with comment
          );
        },
      ),
    );
  }
}
