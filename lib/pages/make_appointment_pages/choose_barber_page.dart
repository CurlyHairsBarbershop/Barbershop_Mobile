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

      List<Barber> fetchedBarbers = [
        Barber(
          name: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          phoneNumber: '123-456-7890',
        ),
        Barber(
          name: 'Jane',
          lastName: 'Doe',
          email: 'jane.doe@example.com',
          phoneNumber: '098-765-4321',
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
