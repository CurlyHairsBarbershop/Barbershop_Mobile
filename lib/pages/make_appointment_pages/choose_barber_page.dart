import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/pages/make_appointment_pages/barber_detail_page.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_date_page.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';

class ChooseBarberPage extends StatefulWidget {
  final Appointment appointment;

  ChooseBarberPage({required this.appointment});

  @override
  _ChooseBarberPageState createState() => _ChooseBarberPageState();
}

class _ChooseBarberPageState extends State<ChooseBarberPage> {
  List<Barber> barbers = [];

  @override
  void initState() {
    super.initState();
    fetchBarbers();
  }

  Future<void> fetchBarbers() async {
    try {
      //List<Barber> fetchedBarbers = await ApiService.fetchBarbers();

      // Mock data for reviews, replace with actual review data.
      List<Review> mockReviews = [
        Review(
          content: 'Great service!',
          rating: 5.0,
          publisher: UserData(
            name: 'Customer',
            lastName: 'One',
            email: 'customer.one@example.com',
            phoneNumber: '555-123-4567',
          ),
        ),
        // ... add more Review instances as needed
      ];

      List<Barber> fetchedBarbers = [
        Barber(
          name: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          phoneNumber: '123-456-7890',
          earnings: 1200.00, // Mock earning
          rating: 4.5, // Mock rating
          image: 'path/to/john_doe_image.jpg', // Mock image path
          reviews: mockReviews,
        ),
        Barber(
          name: 'Jane',
          lastName: 'Doe',
          email: 'jane.doe@example.com',
          phoneNumber: '098-765-4321',
          earnings: 1500.00, // Mock earning
          rating: 4.8, // Mock rating
          image: 'path/to/jane_doe_image.jpg', // Mock image path
          reviews: mockReviews,
        ),
        // ...add more Barber instances as needed
      ];

      setState(() {
        barbers = fetchedBarbers;
      });
    } catch (error) {
      print(error);
    }
  }

  void navigateToBarberDetailPage(Barber barber) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BarberDetailPage(barber: barber)),
    );
  }

  void navigateToChooseDatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseDatePage(appointment: widget.appointment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Barber'),
      ),
      body: ListView.builder(
        itemCount: barbers.length,
        itemBuilder: (context, index) {
          Barber barber = barbers[index];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person), // replace with barber image
            ),
            title: Text(barber.name), // replace with barber name
            subtitle: Text('Available schedule...'), // replace with schedule
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons
                      .favorite_border), // use `Icons.favorite` if favorite
                  onPressed: () {
                    // handle favorite action
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // handle choosing barber
                    setState(() {
                      widget.appointment.barber = barber;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Choose'),
                ),
              ],
            ),
            onTap: () {
              navigateToBarberDetailPage(
                  barber); // Call navigateToBarberDetailPage on tap
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.appointment.barber != null) {
            navigateToChooseDatePage();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please choose a barber.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
