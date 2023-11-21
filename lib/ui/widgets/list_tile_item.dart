
import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key, required this.title, required this.subTitle, required this.chip, required this.color,
  });

  final String title;
  final String subTitle;
  final String chip;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:  Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subTitle),
          const Text('Date'),
          Row(
            children: [
              Chip(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                label: Text(chip, style: const TextStyle(color: Colors.white,),),
                backgroundColor: color,
              ),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever, color: Colors.red,),),
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit, color: Colors.green,),),

            ],
          ),
        ],
      ),
    );
  }
}