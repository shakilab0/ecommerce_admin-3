import 'package:flutter/material.dart';

class UserlistPage extends StatelessWidget {
  static const String routeName="/userlist_page";
  const UserlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
    );
  }
}
