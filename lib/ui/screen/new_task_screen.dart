import 'package:flutter/material.dart';

import '../widgets/summary_card.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                    child: SummaryCard(
                  title: 'New',
                  number: 123,
                )),
                Expanded(
                    child: SummaryCard(
                  title: 'Progress',
                  number: 123,
                )),
                Expanded(
                    child: SummaryCard(
                  title: 'Cancel',
                  number: 123,
                )),
                Expanded(
                    child: SummaryCard(
                  title: 'Completed',
                  number: 123,
                )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text('Title'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
