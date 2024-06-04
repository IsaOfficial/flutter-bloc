import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Text('Welcome, $uid', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
