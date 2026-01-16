import 'package:flutter/material.dart';

class CareCornerPage extends StatelessWidget {
  const CareCornerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.park_outlined, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Care Corner',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text('Coming soon.'),
        ],
      ),
    );
  }
}
