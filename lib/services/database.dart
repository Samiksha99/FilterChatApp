
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:funchat/models/convo.dart';
import 'package:funchat/models/user.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(User user) async {
    await _db.collection('users').doc(user.uid).set(
        {'id': user.uid, 'name': user.displayName, 'email': user.email, 'profileImgUrl': user.photoURL});
  }

  static Stream<List<UserModel>> streamUsersModelUserModel() {
    return _db
        .collection('users')
        .snapshots()
        .map((QuerySnapshot list) => list.docs
            .map((DocumentSnapshot snap) => UserModel.fromMap(snap.data()))
            .toList())
        .handleError((dynamic e) {
      print(e);
    });
  }

  static Stream<List<UserModel>> getUsersByList(List<String> userIds) {
    final List<Stream<UserModel>> streams = List();
    for (String id in userIds) {
      streams.add(_db
          .collection('users')
          .doc(id)
          .snapshots()
          .map((DocumentSnapshot snap) => UserModel.fromMap(snap.data())));
    }
    return StreamZip<UserModel>(streams).asBroadcastStream();
  }

  static Stream<List<Convo>> streamConversations(String uid) {
    return _db
        .collection('messages')
        .orderBy('lastMessage.timestamp', descending: true)
        .where('users', arrayContains: uid)
        .snapshots()
        .map((QuerySnapshot list) => list.docs
            .map((DocumentSnapshot doc) => Convo.fromFireStore(doc))
            .toList());
  }

  static void sendMessage(
    String convoID,
    String id,
    String pid,
    String content,
    String timestamp,
  ) {
    final DocumentReference convoDoc =
        FirebaseFirestore.instance.collection('messages').doc(convoID);

    convoDoc.set(<String, dynamic>{
      'lastMessage': <String, dynamic>{
        'idFrom': id,
        'idTo': pid,
        'timestamp': timestamp,
        'content': content,
        'read': false
      },
      'users': <String>[id, pid]
    }).then((dynamic success) {
      final DocumentReference messageDoc = FirebaseFirestore.instance
          .collection('messages')
          .doc(convoID)
          .collection(convoID)
          .doc(timestamp);

      FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
        transaction.set(
          messageDoc,
          <String, dynamic>{
            'idFrom': id,
            'idTo': pid,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'read': false
          },
        );
      });
    });
  }

  static void updateMessageRead(DocumentSnapshot doc, String convoID) {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(convoID)
        .collection(convoID)
        .doc(doc.id);

    documentReference.update(<String, dynamic>{'read': true});
  }

  static void updateLastMessage(
      DocumentSnapshot doc, String uid, String pid, String convoID) {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection('messages').doc(convoID);

    documentReference
        .set(<String, dynamic>{
          'lastMessage': <String, dynamic>{
            'idFrom': doc['idFrom'],
            'idTo': doc['idTo'],
            'timestamp': doc['timestamp'],
            'content': doc['content'],
            'read': doc['read']
          },
          'users': <String>[uid, pid]
        })
        .then((dynamic success) {})
        .catchError((dynamic error) {
          print(error);
        });
  }
}