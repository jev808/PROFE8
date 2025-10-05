import 'locksmith_request_store.dart';
import 'local_submission_store.dart';
import 'package:flutter/material.dart';
import 'tracking_form_screen.dart';

class ServiceRequestFormScreen extends StatefulWidget {
  const ServiceRequestFormScreen({Key? key}) : super(key: key);

  @override
  State<ServiceRequestFormScreen> createState() => _ServiceRequestFormScreenState();
}

class _ServiceRequestFormScreenState extends State<ServiceRequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _problemController = TextEditingController();
  bool _isEmergency = false;
  bool _needsFollowUp = false;
  String _submittedText = '';

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locksmith Service Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _problemController,
                decoration: const InputDecoration(labelText: 'Describe your locksmith problem'),
                validator: (value) => (value == null || value.isEmpty) ? 'Please describe the locksmith problem' : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Emergency (Locked out, break-in, etc.)'),
                value: _isEmergency,
                onChanged: (value) {
                  setState(() {
                    _isEmergency = value ?? false;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Needs On-site Visit'),
                value: _needsFollowUp,
                onChanged: (value) {
                  setState(() {
                    _needsFollowUp = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() {
                      _submittedText = _problemController.text;
                      LocalSubmissionStore.add(_submittedText);
                      LocksmithRequestStore.add({
                        'problem': _problemController.text,
                        'emergency': _isEmergency,
                        'followUp': _needsFollowUp,
                      });
                    });
                    // Pass the submitted request to TrackingFormScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackingFormScreen(
                          initialRequest: {
                            'problem': _problemController.text,
                            'emergency': _isEmergency,
                            'followUp': _needsFollowUp,
                          },
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 24),
              if (_submittedText.isNotEmpty)
                Card(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Submitted Locksmith Problem: \$_submittedText'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
