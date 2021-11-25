
import 'package:flutter/material.dart';
import 'package:funchat/models/user.dart';
import 'package:funchat/screens/newMessageScreen.dart';
import 'package:funchat/services/database.dart';
import 'package:provider/provider.dart';

class NewMessageProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
      value: Database.streamUsersModelUserModel(),
      initialData: [],
      child: NewMessageScreen(),
    );
  }
}