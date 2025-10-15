import 'package:flutter/material.dart';

class ToDoAppPage extends StatelessWidget {
  const ToDoAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoAppPage Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome ToDoAppPage!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
