import 'local_submission_store.dart';
import 'package:flutter/material.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({Key? key}) : super(key: key);

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Select Date'
                    : 'Date: \\${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_selectedTime == null
                    ? 'Select Time'
                    : 'Time: \\${_selectedTime!.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedTime = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_selectedDate != null && _selectedTime != null) {
                    LocalSubmissionStore.add('Appointment: \\${_selectedDate!.toLocal().toString().split(' ')[0]} at \\${_selectedTime!.format(context)}');
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text('Appointment set for \\${_selectedDate!.toLocal().toString().split(' ')[0]} at \\${_selectedTime!.format(context)}'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Book Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
