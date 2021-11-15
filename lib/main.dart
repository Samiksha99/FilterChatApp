import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funchat/provider/convoProvider.dart';
import 'package:funchat/provider/providerInit.dart';
import 'package:funchat/screens/homePage.dart';
import 'package:funchat/screens/loginScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ProviderInit());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final User firebaseUser = Provider.of<User>(context);
    return MaterialApp(
      title: 'FunChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: firebaseUser!=null ? ConversationProvider(user: firebaseUser): Login()
    );
  }
}
