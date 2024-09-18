import 'package:flutter/material.dart';

class Option3Page extends StatelessWidget {
  final String marketplaceLocation = 'Rythu Bazaar, Hyderabad';
  final String lastUpdated = 'Last Updated: 31-Aug-2024';

  final List<Map<String, String>> vegetables = [
    {'item': 'Tomato', 'price': '₹20/kg', 'image': 'assets/tomato.jpg'},
    {'item': 'Potato', 'price': '₹25/kg', 'image': 'assets/potato.jpg'},
    {'item': 'Onion', 'price': '₹30/kg', 'image': 'assets/onion.jpg'},
    {'item': 'Carrot', 'price': '₹40/kg', 'image': 'assets/carrot.jpg'},
    // Add more vegetables as needed
  ];

  final List<Map<String, String>> fruits = [
    {'item': 'Apple', 'price': '₹150/kg', 'image': 'assets/apple.jpg'},
    {'item': 'Banana', 'price': '₹50/dozen', 'image': 'assets/banana.jpg'},
    {'item': 'Orange', 'price': '₹60/kg', 'image': 'assets/orange.jpg'},
    {'item': 'Grapes', 'price': '₹80/kg', 'image': 'assets/grapes.jpg'},
    // Add more fruits as needed
  ];

  const Option3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rythu Bazaar Prices'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and Last Updated Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    marketplaceLocation,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastUpdated,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.teal, thickness: 1),

            // Vegetables Section
            SectionTitle(title: 'Vegetables'),
            CollapsiblePriceList(prices: vegetables),

            // Fruits Section
            SectionTitle(title: 'Fruits'),
            CollapsiblePriceList(prices: fruits),
          ],
        ),
      ),
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}

// Collapsible Price List Widget
class CollapsiblePriceList extends StatefulWidget {
  final List<Map<String, String>> prices;

  const CollapsiblePriceList({super.key, required this.prices});

  @override
  _CollapsiblePriceListState createState() => _CollapsiblePriceListState();
}

class _CollapsiblePriceListState extends State<CollapsiblePriceList> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            _isExpanded ? 'Hide List' : 'Show List',
            style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.teal,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.prices.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 3,
                child: ListTile(
                  leading: Image.asset(
                    widget.prices[index]['image']!,
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    widget.prices[index]['item']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    widget.prices[index]['price']!,
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
