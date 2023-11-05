import 'package:flutter/material.dart';
import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/pages/make_appointment_pages/comment_page.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';

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
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person), // replace with barber image
            ),
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
