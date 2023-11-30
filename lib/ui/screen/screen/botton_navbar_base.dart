import 'package:flutter/material.dart';
import '../../../data/models/new_task_status_model.dart';
import 'cancel_task_screen.dart';
import 'completed_task_screen.dart';
import 'in_progress_screen.dart';
import 'new_task_screen.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({super.key});

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {

  NewTaskStatusModel _newTaskStatusModel = NewTaskStatusModel();

   int _selectedIndex = 0;

   final List<Widget> _screen = const[
     NewTaskScreen(),
     InProgressScreen(),
     CancelTaskScreen(),
     CompletedTaskScreen(),

   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        onTap: (int index){
          _selectedIndex = index;
          if(mounted){
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Cancel'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: 'Completed'),
        ],
      ),
    );
  }
}
