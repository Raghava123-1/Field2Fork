import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  final _vegetablePriceController = TextEditingController();
  final _fruitPriceController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _buttonAnimation;
  late Animation<double> _textFieldAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _buttonAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _textFieldAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _savePrices() {
    final vegetablePrice = _vegetablePriceController.text;
    final fruitPrice = _fruitPriceController.text;

    // Implement logic to save or update prices
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Prices Updated'),
        content: Text('Vegetable Price: \$$vegetablePrice\nFruit Price: \$$fruitPrice'),
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
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _textFieldAnimation,
              child: Text(
                'Update Prices',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _textFieldAnimation,
              child: TextField(
                controller: _vegetablePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price for Vegetables',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _textFieldAnimation,
              child: TextField(
                controller: _fruitPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price for Fruits',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _buttonAnimation,
              child: ElevatedButton(
                onPressed: _savePrices,
                child: const Text('Save Prices'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
