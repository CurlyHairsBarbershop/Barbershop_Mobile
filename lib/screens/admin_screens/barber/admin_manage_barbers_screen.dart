import 'package:flutter/material.dart';
import 'package:curly_hairs/models/barber_model.dart';
import 'package:curly_hairs/screens/admin_screens/barber/add_barber_screen.dart';
import 'package:curly_hairs/screens/admin_screens/barber/edit_barber_screen.dart';
import 'package:curly_hairs/services/api_service.dart';

class ManageBarbersScreen extends StatefulWidget {
  @override
  _ManageBarbersScreenState createState() => _ManageBarbersScreenState();
}

class _ManageBarbersScreenState extends State<ManageBarbersScreen> {
  Future<List<Barber>>? _barbersFuture;

  @override
  void initState() {
    super.initState();
    _barbersFuture = ApiService.getAllBarbers(); // Fetch the list of barbers
  }

  void _navigateToAddBarberScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddBarberScreen()),
    );
    if (result == true) {
      _refreshBarbersList();
    }
  }

  void _navigateToEditBarberScreen(Barber barber) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditBarberScreen(barber: barber)),
    );
    if (result == true) {
      _refreshBarbersList();
    }
  }

  void _refreshBarbersList() {
    setState(() {
      _barbersFuture = ApiService.getAllBarbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Barbers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _navigateToAddBarberScreen,
              child: Text('Add Barber'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Barber>>(
                future: _barbersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Barber barber = snapshot.data![index];
                        return ListTile(
                          title: Text('${barber.name} ${barber.lastName}'),
                          subtitle: Text(
                              'Rating: ${barber.rating.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () =>
                                _navigateToEditBarberScreen(barber),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No barbers found"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
