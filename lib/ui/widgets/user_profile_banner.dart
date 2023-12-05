// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taskmanager_apps_api/data/models/auth_utility.dart';
//
// class UserProfileBanner extends StatelessWidget {
//   const UserProfileBanner({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.toNamed('UpdateProfileScreen');
//       },
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//         title: Text(
//           '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
//           style: const TextStyle(color: Colors.white),
//         ),
//         subtitle:  Text(
//           AuthUtility.userInfo.data?.email ?? 'Unknown',
//           style: const TextStyle(color: Colors.white),
//         ),
//         tileColor: Colors.green,
//         leading:  CircleAvatar(
//           backgroundImage: NetworkImage(AuthUtility.userInfo.data?.photo ?? ''),
//           onBackgroundImageError: (_, __) {
//              const Icon(Icons.image);
//           },
//         ),
//         trailing: IconButton(
//           onPressed: () async{
//             await AuthUtility.clearUserInfo();
//             Get.offNamed('/LogIn');
//           },
//           icon: const Icon(Icons.login_outlined , color: Colors.white, size: 30,),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/auth_utility.dart';
import '../screen/logIn/login_screen.dart';

class UserProfileBannerAppBar extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileBannerAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileBannerAppBar> createState() => _UserProfileBannerAppBarState();
}

class _UserProfileBannerAppBarState extends State<UserProfileBannerAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          Get.toNamed('/UpdateProfileScreen');
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CircleAvatar(
                    child: CachedNetworkImage(
                      placeholder: (_,__) => const Icon(Icons.image),
                      imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      errorWidget: (_,__,___) => const Icon(Icons.account_circle_outlined,),
                    ),
                  ),
                  
                  
                  // CachedNetworkImage(
                  //   placeholder: (_, __) => const Icon(Icons.account_circle_outlined),
                  //   imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                  //   errorWidget: (_, __, ___) => const Icon(Icons.account_circle_outlined),
                  // ),
                   const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false);
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}