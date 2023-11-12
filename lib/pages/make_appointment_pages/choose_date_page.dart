import 'package:curly_hairs/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:curly_hairs/pages/make_appointment_pages/choose_service_page.dart';
import 'package:curly_hairs/models/appointment_model.dart';

class ChooseDatePage extends StatefulWidget {
  final Appointment appointment;

  ChooseDatePage({required this.appointment});

  @override
  _ChooseDatePageState createState() => _ChooseDatePageState();
}

class _ChooseDatePageState extends State<ChooseDatePage> {
  DateTime? selectedDate;
  String? selectedTime;

  Future<void> fetchSchedule() async {
    // Assuming this is the barber's ID and it's passed correctly to the widget
    int barberID = widget.appointment.barber?.id ?? 0;
    List<DateTime> busyTimes = [];
    try {
      // Fetch busy times from the API
      busyTimes = await ApiService.getAllDateTime(
          barberID, selectedDate!.day - DateTime.now().day);

      print(busyTimes);
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch busy times.')),
      );
    }

    // Assuming barber works from 09:00 to 19:00, create all time slots
    List<DateTime> allTimes = List.generate(10, (i) {
      DateTime time = DateTime(
          selectedDate!.year, selectedDate!.month, selectedDate!.day, i);
      return time.toLocal();
    });

    print(allTimes);

    // Remove the busy times from all times to get the available times
    setState(() {
      for (var slot in allTimes) {
        if (busyTimes.any((time) =>
            slot.compareTo(time.add(Duration(hours: 1))) < 0 &&
            slot.compareTo(time) >= 0)) {
          continue;
        }
        availableTimes.add(slot);
      }
    });
  }

  List<DateTime> availableTimes = [];

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
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            if (selectedDate != null)
              Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'),
            SizedBox(height: 20),
            if (selectedDate != null) ...[
              for (DateTime time in availableTimes)
                ListTile(
                  title: Text(
                      '${time.toLocal().hour.toString().padLeft(2, '0')}:${time.toLocal().minute.toString().padLeft(2, '0')}'),
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
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
