import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:curly_hairs/models/appointment_model.dart';
import 'package:curly_hairs/services/api_service.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_service_page.dart';

class ChooseDatePage extends StatefulWidget {
  final Appointment appointment;

  ChooseDatePage({required this.appointment});

  @override
  _ChooseDatePageState createState() => _ChooseDatePageState();
}

class _ChooseDatePageState extends State<ChooseDatePage> {
  DateTime? selectedDate;
  String? selectedTime;
  List<DateTime> availableTimes = [];

  Future<void> fetchSchedule() async {
    if (selectedDate == null) return; // Ensure a date is selected

    int barberID = widget.appointment.barber?.id ?? 0;
    try {
      // Fetch busy times from the API
      List<DateTime> busyTimes = await ApiService.getAllDateTime(
          barberID, selectedDate!.day - DateTime.now().day);

      // Create all potential time slots
      List<DateTime> allTimes = List.generate(10, (i) {
        return DateTime(
            selectedDate!.year, selectedDate!.month, selectedDate!.day, i + 9);
      });

      // Filter out busy and past times
      DateTime now = DateTime.now();
      setState(() {
        availableTimes.clear(); // Clear previous times
        availableTimes = allTimes.where((slot) {
          return !busyTimes.contains(slot) && slot.isAfter(now);
        }).toList();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch busy times.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Date and Time'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(selectedDate == null
                    ? 'Select Date'
                    : DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)),
              ),
            ),
            SizedBox(height: 20),
            if (selectedDate != null) ...[
              Center(
                child: Text(
                  'Available Times:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (availableTimes.isNotEmpty) ...[
                for (DateTime time in availableTimes)
                  Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        DateFormat('hh:mm a').format(time),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio<String>(
                        value: DateFormat('HH:mm').format(time),
                        groupValue: selectedTime,
                        onChanged: (String? value) {
                          setState(() {
                            selectedTime = value;
                          });
                        },
                      ),
                    ),
                  ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('No available slots',
                        style:
                            TextStyle(fontSize: 16, color: Colors.redAccent)),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedDate != null && selectedTime != null) {
            var timeParts = selectedTime!.split(':');
            widget.appointment.appointmentTime = DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              int.parse(timeParts[0]),
              int.parse(timeParts[1]),
            );
            navigateToChooseServicePage();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select both a date and a time.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedTime = null; // Reset the time selection
      });
      fetchSchedule();
    }
  }

  void navigateToChooseServicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChooseServicePage(appointment: widget.appointment),
      ),
    );
  }
}
