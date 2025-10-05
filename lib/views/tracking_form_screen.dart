import 'locksmith_request_store.dart';
import 'package:flutter/material.dart';


class TrackingFormScreen extends StatefulWidget {
  final Map<String, dynamic>? initialRequest;
  const TrackingFormScreen({Key? key, this.initialRequest}) : super(key: key);

  @override
  State<TrackingFormScreen> createState() => _TrackingFormScreenState();
}

class _TrackingFormScreenState extends State<TrackingFormScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Locksmith Requests'),
        actions: [
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Submitted Locksmith Requests:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: LocksmithRequestStore.requests.length,
                itemBuilder: (context, index) {
                  final req = LocksmithRequestStore.requests[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(req['problem'] ?? ''),
                      subtitle: Text('Emergency: \\${req['emergency'] ? 'Yes' : 'No'} | On-site Visit: \\${req['followUp'] ? 'Yes' : 'No'}'),
                    ),
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
