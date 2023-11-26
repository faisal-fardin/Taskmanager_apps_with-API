import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/data/models/auth_utility.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('UpdateProfileScreen');
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        title: Text(
          '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle:  Text(
          AuthUtility.userInfo.data?.email ?? 'Unknown',
          style: const TextStyle(color: Colors.white),
        ),
        tileColor: Colors.green,
        leading:  CircleAvatar(
          backgroundImage: NetworkImage(AuthUtility.userInfo.data?.photo ?? ''),
          onBackgroundImageError: (_, __) {
             const Icon(Icons.image);
          },
        ),
        trailing: IconButton(
          onPressed: () async{
            await AuthUtility.clearUserInfo();
            Get.offNamed('/LogIn');
          },
          icon: const Icon(Icons.login_outlined , color: Colors.white, size: 30,),
        ),
      ),
    );
  }
}
