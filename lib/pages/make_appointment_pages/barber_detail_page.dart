import 'package:flutter/material.dart';
import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/pages/make_appointment_pages/comment_page.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'dart:typed_data';
import 'dart:convert';

class BarberDetailPage extends StatefulWidget {
  final Barber barber;

  const BarberDetailPage({required this.barber});

  @override
  _BarberDetailPageState createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  List<Review> comments = [];

  @override
  void initState() {
    super.initState();
    //fetchComments();
  }

  // Future<void> fetchComments() async {
  //   try {
  //     List<Review> fetchedComments =
  //         await ApiService.fetchReviews(widget.barber.barberId);
  //     setState(() {
  //       comments = fetchedComments;
  //     });
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barber Detail'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the border radius as needed
              child: FractionallySizedBox(
                widthFactor:
                    0.32, // Set the width to 30% of the available screen width
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(255, 113, 185, 243),
                        const Color.fromARGB(255, 255, 106, 106),
                      ], // Adjust colors as needed
                    ),
                  ),
                  child: FractionallySizedBox(
                    heightFactor: 0.96,
                    child: Image.memory(
                      base64.decode(widget.barber.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(widget.barber.name), // replace with barber name
            subtitle: Text('Available schedule...'), // replace with schedule
          ),
          ElevatedButton(
            onPressed: () {
              navigateToCommentPage(widget.barber);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: Text('Comments'),
          ),
          // add other information about barber here
        ],
      ),
    );
  }

  void navigateToCommentPage(Barber barber) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommentPage(barber: barber)),
    );
  }
}
