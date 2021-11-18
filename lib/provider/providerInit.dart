import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:funchat/main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProviderInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: FirebaseAuth.instance.authStateChanges(),
        child: MaterialApp(
            title: 'FunChat',
            debugShowCheckedModeBanner: false,
            home: MyApp()));
  }
}
