import 'package:flutter/material.dart';
import 'booking_form_screen.dart';
import 'service_request_form_screen.dart';
import 'tracking_form_screen.dart';
import 'local_list_form_screen.dart';
import 'login_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locksmith Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginFormScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            // Optionally, you can add a visible logout button at the bottom:
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(builder: (context) => const LoginFormScreen()),
            //       (route) => false,
            //     );
            //   },
            //   child: const Text('Logout'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingFormScreen()),
                );
              },
              child: const Text('Book Appointment'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServiceRequestFormScreen()),
                );
              },
              child: const Text('Request Locksmith Service'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrackingFormScreen()),
                );
              },
              child: const Text('Track Locksmith Requests'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocalListFormScreen()),
                );
              },
              child: const Text('Local List Form Example'),
            ),
          ],
        ),
      ),
    );
  }
}
