import 'package:flutter/material.dart';

class BazaarHeadScreen extends StatelessWidget {
  const BazaarHeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazaar Head'),
      ),
      body: const Center(
        child: Text('This is the bazaar head screen.'),
      ),
    );
  }
}
