import 'package:curly_hairs/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:curly_hairs/pages/explore_pages/barber_profile_page.dart';
import 'package:curly_hairs/models/barber_model.dart';

// class BarbersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Barbers'),
//       ),
//       body: FutureBuilder<List<Barber>>(
//         future: ApiService.getAllBarbers(),
//         builder: (context, snapshot) {
          
//   }
// }

class BarbersPage extends StatefulWidget {
  @override
  _BarbersPageState createState() => _BarbersPageState();
}

class _BarbersPageState extends State<BarbersPage> {
  late Future<List<Barber>> _barbersFuture;

  @override
  void initState() {
    super.initState();
    _fetchBarbers();
  }

  Future<void> _fetchBarbers() async {
    _barbersFuture = ApiService.getAllBarbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbers'),
      ),
      body: FutureBuilder<List<Barber>>(
        future: _barbersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data to load, display a loading indicator.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message.
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
            // If no data is available, display a message indicating no barbers found.
            return Text('No barbers found.');
          } else {
            // Data has been loaded successfully. Display the list of barbers.
            List<Barber> barbers = snapshot.data ?? [];
            return ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                Barber barber = barbers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarberProfilePage(barber: barber), // Pass the reviews here
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.image), // replace with your image
                    title: Text('${barber.name} ${barber.lastName}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
