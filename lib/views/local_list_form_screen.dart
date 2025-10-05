import 'package:flutter/material.dart';
import 'local_submission_store.dart';

class LocalListFormScreen extends StatefulWidget {
  const LocalListFormScreen({Key? key}) : super(key: key);

  @override
  State<LocalListFormScreen> createState() => _LocalListFormScreenState();
}

class _LocalListFormScreenState extends State<LocalListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _submitInput() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        LocalSubmissionStore.add(_inputController.text);
        _inputController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local List Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _inputController,
                      decoration: const InputDecoration(labelText: 'Enter something'),
                      validator: (value) => (value == null || value.isEmpty) ? 'Please enter something' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _submitInput,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Submitted Inputs:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: LocalSubmissionStore.submissions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(LocalSubmissionStore.submissions[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
