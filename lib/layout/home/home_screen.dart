import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Gaming'),
        actions: const [
          Icon(Icons.search),
          Icon(Icons.notification_add),
        ],
      ),
    );
  }
}
