import 'local_submission_store.dart';
import 'package:flutter/material.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _role = 'Customer';
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      backgroundColor: const Color(0xFFF6F8FB),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Create Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onSaved: (value) => _name = value ?? '',
                        validator: (value) => (value == null || value.isEmpty) ? 'Enter your name' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => _email = value ?? '',
                        validator: (value) => (value == null || !value.contains('@')) ? 'Enter a valid email' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        obscureText: true,
                        validator: (value) => (value == null || value.isEmpty) ? 'Enter a password' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _role,
                        decoration: InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Customer', child: Text('Customer')),
                          DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _role = value ?? 'Customer';
                          });
                        },
                        onSaved: (value) => _role = value ?? 'Customer',
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue[700],
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            LocalSubmissionStore.add('Registered: Name=$_name, Email=$_email, Role=$_role');
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text('Name: $_name\nEmail: $_email\nRole: $_role'),
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
                        child: const Text('Register', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
