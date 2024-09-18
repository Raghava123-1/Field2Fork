import 'package:flutter/material.dart';

class FarmerScreen extends StatelessWidget {
  const FarmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer'),
      ),
      body: const Center(
        child: Text('This is the farmer screen.'),
      ),
    );
  }
}
