import 'package:curly_hairs/models/reply_model.dart';
import 'package:curly_hairs/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';

class BarberProfilePage extends StatefulWidget {
  final Barber barber;

  const BarberProfilePage({required this.barber});

  @override
  _BarberProfilePageState createState() => _BarberProfilePageState();
}

class _BarberProfilePageState extends State<BarberProfilePage> {
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
            child: Text('Reviews', style: Theme.of(context).textTheme.headline6),
          ),
          for (var review in widget.barber.reviews)
            ReviewWidget(review: review),
        ],
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final Review review;
  final double replyIndent = 20.0; // Indentation for each reply level

  ReviewWidget({required this.review});

  Future<void> _showReplyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String replyContent = ''; // The content of the reply

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
              onPressed: () {
                // Here, you can handle the reply content
                // For instance, you can call a function to save the reply content
                print('Reply: $replyContent');
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Functionality to write a reply
                    _showReplyDialog(context);
                    // This could be a dialog or navigation to a new page for writing replies
                  },
                  child: Text('Reply'),
                ),
              ],
            ),
            Text(
              reply.content,
              style: TextStyle(fontSize: 18.0),
            ),
            for (var subReply in reply.replies) buildReply(subReply, level + 1, context),
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Functionality to write a reply
                    _showReplyDialog(context);
                    // This could be a dialog or navigation to a new page for writing replies
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
