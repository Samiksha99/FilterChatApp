// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// Widget buildMessages() {
//     return Flexible(
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('messages')
//             .doc(convoID)
//             .collection(convoID)
//             .orderBy('timestamp', descending: true)
//             .limit(20)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             listMessage = snapshot.data.docs;
//             return ListView.builder(
//               padding: const EdgeInsets.all(10.0),
//               itemBuilder: (BuildContext context, int index) =>
//                   buildItem(index, snapshot.data.docs[index]),
//               itemCount: snapshot.data.docs.length,
//               reverse: true,
//               controller: listScrollController,
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }