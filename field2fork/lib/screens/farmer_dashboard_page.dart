// TODO Implement this library.
import 'package:flutter/material.dart';

class FarmerDashboardPage extends StatefulWidget {
  const FarmerDashboardPage({super.key});

  @override
  _FarmerDashboardPageState createState() => _FarmerDashboardPageState();
}

class _FarmerDashboardPageState extends State<FarmerDashboardPage> {
  final _produceController = TextEditingController();
  final _quantityController = TextEditingController();

  void _saveProduce() {
    final produce = _produceController.text;
    final quantity = _quantityController.text;

    // Implement logic to save or update produce details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Produce Saved'),
        content: Text('Produce: $produce\nQuantity: $quantity'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmer Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manage Your Produce', style: Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _produceController,
              decoration: const InputDecoration(
                labelText: 'Produce Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduce,
              child: const Text('Save Produce'),
            ),
          ],
        ),
      ),
    );
  }
}
