import 'package:flutter/material.dart';
import 'list_element.dart';

class UsersList extends StatelessWidget {
  final users;

  UsersList({this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
      ),
    );
  }
}
