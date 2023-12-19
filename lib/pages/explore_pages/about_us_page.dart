import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to CurlyHairs - Your Ultimate Barbershop Destination!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'At CurlyHairs, we reimagine the traditional barbershop experience. We provide a seamless connection between our skilled barbers and cherished clients, ensuring everyone walks out satisfied. Discover a realm of convenience, quality, and style!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'What We Offer for Customers:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '• Real-time booking of available appointment slots.\n'
                '• Insightful barber profiles with specialties, ratings, and reviews.\n'
                '• Full control over your appointments – reschedule or cancel easily.\n'
                '• Handy notifications to keep you updated.\n'
                '• A platform to share feedback and rate your experience.\n'
                '• Secure integrated payment options.\n'
                '• Exciting special offers, promotions, and loyalty rewards.\n'
                '• Profile photo option to express your desired haircut style.\n'
                '• Share your new look or appointment details on social media.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Empowering Barbers:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '• Customize and control your availability.\n'
                '• Easy management of appointments and profile updates.\n'
                '• Instant notifications on new bookings or changes.\n'
                '• Track earnings and view customer feedback.\n'
                '• Showcase your skills and past work to attract new clients.\n'
                '• Offer and promote unique services and discounts.\n'
                '• Easy requisition of professional supplies and equipment.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Join us at CurlyHairs and experience the revolution in barber services!',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
