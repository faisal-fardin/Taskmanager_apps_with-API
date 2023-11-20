
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key, required this.title, required this.number,
  });

  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 80,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$number',style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            Text(title)
          ],
        ),
      ),
    );
  }
}