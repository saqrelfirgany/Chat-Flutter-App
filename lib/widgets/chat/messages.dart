import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    print(userId);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            message: chatDocs[index]['text'],
            isMe: chatDocs[index]['userId'] == userId,
            key1: ValueKey(DateTime.now()),
            userId: chatDocs[index]['userId'],
          ),
        );
      },
    );
  }
}
