import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:funchat/models/user.dart';
import 'package:funchat/screens/convoScreen.dart';
import 'package:funchat/utilis/helperFunctions.dart';

class UserRow extends StatelessWidget {
  const UserRow({@required this.uid, @required this.contact});
  final String uid;
  final UserModel contact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => createConversation(context),
      child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 20,
                      onBackgroundImageError: (exception, stackTrace) {
                        print("Network Img Exception");
                        print(exception);
                      },
                      backgroundColor: Colors.black,
                      backgroundImage:
                          CachedNetworkImageProvider(contact.profileImg==null? "": contact.profileImg),
                    ),
                  ),
                  Text(contact.name,
                      style:
                          TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ))),
    );
  }

  void createConversation(BuildContext context) {
    String convoID = HelperFunctions.getConvoID(uid, contact.id);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => NewConversationScreen(
            uid: uid, contact: contact, convoID: convoID)));
  }
}