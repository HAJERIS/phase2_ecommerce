import 'package:ecommerce/app/app.locator.dart';
import 'package:ecommerce/views/login/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

// This is the root of your app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 2 Ecommerce',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginView(),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Placeholder')),
      body: const Center(child: Text('Phase 2 App Starts Here')),
    );
  }
}
