// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:interview/widgets/avatar_widget.dart';

class UserListTile extends StatelessWidget {
  final String image, firstname, lastname, role;

  UserListTile(this.image, this.firstname, this.lastname, this.role);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarImage(image == null ? "null" : image),
      title: Text.rich(
        TextSpan(
          text: firstname,
          style: TextStyle(),
          children: [
            TextSpan(
              text: " $lastname",
              style: TextStyle(),
            ),
          ],
        ),
      ),
      subtitle: Text(role),
    );
  }
}
