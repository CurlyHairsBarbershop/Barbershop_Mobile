import 'package:curly_hairs/models/review_model.dart';
import 'package:curly_hairs/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/pages/make_appointment_pages/barber_detail_page.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_date_page.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'dart:typed_data';
import 'dart:convert';


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
      List<Barber> fetchedBarbers = await ApiService.getAllBarbers();
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
          Uint8List imageBytes = base64.decode(barber.image ?? '');

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: MemoryImage(imageBytes),
            ),
            title: Text(barber.name), // replace with barber name
            subtitle: Text('Available schedule...'), // replace with schedule
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // IconButton(
                //   icon: Icon(Icons
                //       .favorite_border), // use `Icons.favorite` if favorite
                //   onPressed: () {
                //     // handle favorite action
                //   },
                // ),
                ElevatedButton(
                  onPressed: () {
                    // handle choosing barber
                    setState(() {
                      widget.appointment.barber = barber;
                    });
                    navigateToChooseDatePage();
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print("d ${widget.appointment.barber?.name}");
      //     if (widget.appointment.barber != null) {
      //       navigateToChooseDatePage();
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text('Please choose a barber.'),
      //           duration: Duration(seconds: 2),
      //         ),
      //       );
      //     }
      //   },
      //   child: Icon(Icons.arrow_forward),
      // ),
    );
  }
}
