import 'package:flutter/material.dart';

import '../../widgets/list_tile_item.dart';

import '../../widgets/user_profile_banner.dart';


class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const TaskListTile(
                    title: 'Title will be here',
                    subTitle: 'Title will be here',
                    chip: 'Completed', color: Colors.green
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


