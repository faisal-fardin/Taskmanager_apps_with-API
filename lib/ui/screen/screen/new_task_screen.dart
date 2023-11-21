import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/list_tile_item.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/usere_profile_banner.dart';


class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
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
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const TaskListTile(
                    title: 'Title will be here',
                    subTitle: 'Title will be here',
                    chip: 'New', color: Colors.blue,
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
              },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){
          Get.toNamed('/AddNewTaskScreen');
        },
        child: const Icon(Icons.add , color: Colors.white,),
      ),
    );
  }
}


