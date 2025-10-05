
import 'package:flutter/material.dart';
import 'views/login_form_screen.dart';

void main() {
	runApp(const LocksmithApp());
}

class LocksmithApp extends StatelessWidget {
	const LocksmithApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Locksmith Services',
			theme: ThemeData(primarySwatch: Colors.blue),
			home: const LoginFormScreen(),
		);
	}
}

