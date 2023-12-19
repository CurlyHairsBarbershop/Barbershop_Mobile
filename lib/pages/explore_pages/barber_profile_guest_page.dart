// ignore_for_file: unnecessary_null_comparison

import 'package:curly_hairs/models/reply_model.dart';
import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'dart:typed_data';
import 'dart:convert';

class BarberProfileGuestPage extends StatefulWidget {
  final Barber barber;

  const BarberProfileGuestPage({required this.barber});

  @override
  _BarberProfileGuestPageState createState() => _BarberProfileGuestPageState();
}

class _BarberProfileGuestPageState extends State<BarberProfileGuestPage> {
  late Barber? selectedBarber;

  @override
  void initState() {
    super.initState();
    selectedBarber = widget.barber;
  }

  String reviewTitle = ''; // Declare reviewTitle variable

  Future<void> _showReviewDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String reviewContent = '';

        return AlertDialog(
          title: Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  reviewTitle = value; // Assign value to reviewTitle
                },
                decoration: InputDecoration(
                  hintText: 'Review Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10), // Add some space between title and content
              TextFormField(
                onChanged: (value) {
                  reviewContent = value;
                },
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Type your review here...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                print('Title: $reviewTitle');
                print('Review: $reviewContent');
                // Call the API service method to post a review here
                await ApiService.postReview({
                  'title': reviewTitle,
                  'content': reviewContent,
                  'barberEmail': widget.barber.email,
                  'rating': 0,
                  // Add other necessary fields for posting a review
                });

                // You might want to update the UI after posting the review
                // For example, fetching updated barber data

                Navigator.of(context).pop(); // To close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedBarber?.name ?? widget.barber.name}\'s Profile'),
        // If selectedBarber is null, use the widget.barber.name instead
      ),
      body: selectedBarber == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                  subtitle: Text(
                      selectedBarber!.name + ' ' + selectedBarber!.lastName),
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
                  child: Text('Reviews',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('You need to sign in to post a review.'),
                              action: SnackBarAction(
                                label: 'Sign In',
                                onPressed: () {
                                  // Navigate to the sign-in screen or any appropriate screen for authentication
                                },
                              ),
                            ),
                          );
                        },
                        child: Text('Write a Review'),
                      );
                    },
                  ),
                ),
                for (var review in selectedBarber!.reviews)
                  ReviewWidget(review: review, barber: selectedBarber!),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final Review review;
  Barber barber;
  final double replyIndent = 20.0; // Indentation for each reply level

  ReviewWidget({required this.review, required this.barber});

  Future<void> _showReplyDialog(
      BuildContext context, int parentReviewId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String replyContent = '';

        return AlertDialog(
          title: Text('Write a Reply'),
          content: TextFormField(
            onChanged: (value) {
              replyContent = value;
            },
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Type your reply here...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                // Here, you can handle the reply content

                print('Reply to Review $parentReviewId: $replyContent');
                await ApiService.postReply({
                  'reviewId': parentReviewId,
                  'content': replyContent,
                });

                // Barber selectedBarber = (await ApiService.getAllBarbers())
                //   .firstWhere((element) => element.email == barber.email);
                // barber = selectedBarber;
                Navigator.of(context).pop(); // To close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildReply(Reply reply, int level, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: replyIndent * level),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${reply.publisher.name}:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You need to sign in to post a reply.'),
                        action: SnackBarAction(
                          label: 'Sign In',
                          onPressed: () {
                            // Navigate to the sign-in screen or any appropriate screen for authentication
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Reply'),
                ),
              ],
            ),
            Text(
              reply.content,
              style: TextStyle(fontSize: 18.0),
            ),
            for (var subReply in reply.replies)
              buildReply(subReply, level + 1, context),
          ],
        ),
      ),
    );
  }

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
          Padding(
            padding: EdgeInsets.only(left: replyIndent * 0),
            child: Row(
              children: [
                Text(
                  '${review.publisher.name}:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You need to sign in to post a reply.'),
                        action: SnackBarAction(
                          label: 'Sign In',
                          onPressed: () {
                            // Navigate to the sign-in screen or any appropriate screen for authentication
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Reply'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: replyIndent * 0),
            child: Text(
              review.content,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          for (var reply in review.replies) buildReply(reply, 1, context),
        ],
      ),
    );
  }
}
