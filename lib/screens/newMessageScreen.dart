import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funchat/models/user.dart';
import 'package:funchat/widgets/userRow.dart';
import 'package:provider/provider.dart';

class NewMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final List<UserModel> userDirectory = Provider.of<List<UserModel>>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Select Contact')),
      body: user !=null && userDirectory != null
          ? ListView(
              shrinkWrap: true, children: getListViewItems(userDirectory, user))
          : Container(),
    );
  }

  List<Widget> getListViewItems(List<UserModel> userDirectory, User user) {
    final List<Widget> list = <Widget>[];
    for (UserModel contact in userDirectory) {
      if (contact.id != user.uid) {
        list.add(UserRow(uid: user.uid, contact: contact));
        list.add(Divider(thickness: 1.0));
      }
    }
    return list;
  }
}