import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funchat/models/convo.dart';
import 'package:funchat/models/user.dart';
import 'package:funchat/screens/chatMainScreem.dart';
import 'package:funchat/services/database.dart';
import 'package:provider/provider.dart';

class ConversationProvider extends StatelessWidget {
  const ConversationProvider({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Convo>>.value(
        value: Database.streamConversations(user.uid),
        child: ConversationDetailsProvider(user: user));
  }
}

class ConversationDetailsProvider extends StatelessWidget {
  const ConversationDetailsProvider({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
        value: Database.getUsersByList(
            getUserIds(Provider.of<List<Convo>>(context))),
        child: HomeBuilder());
  }

  List<String> getUserIds(List<Convo> _convos) {
    final List<String> users = <String>[];
    if (_convos != null) {
      for (Convo c in _convos) {
        c.userIds[0] != user.uid
            ? users.add(c.userIds[0])
            : users.add(c.userIds[1]);
      }
    }
    return users;
  }
}