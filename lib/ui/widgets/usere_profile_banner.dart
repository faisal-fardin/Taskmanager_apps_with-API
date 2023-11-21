import 'package:flutter/material.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: const ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        title: Text('User Name',style: TextStyle(color: Colors.white),),
        subtitle: Text('User Email',style: TextStyle(color: Colors.white),),
        tileColor: Colors.green,
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/f2.jpg'),
        ),
      ),
    );
  }
}