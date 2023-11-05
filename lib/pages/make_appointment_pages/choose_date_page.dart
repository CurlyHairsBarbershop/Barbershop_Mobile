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

  List<String> availableTimes = List<String>.generate(
      10, (i) => (9 + i).toString().padLeft(2, '0') + ":00");

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
              for (var time in availableTimes)
                ListTile(
                  title: Text(time),
                  leading: Radio<String>(
                    value: time,
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
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
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
