import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_app/components/chat_bubble.dart';
import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/services/databases/group_chat_database.dart';
import 'package:flutter/material.dart';

class GroupChatStream extends StatelessWidget {
  const GroupChatStream({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: GroupchatDatabase.messagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading messages'));
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No messages yet'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data?.docs;
          List<ChatBubble> messageBubbles = [];
          for (var message in messages!) {
            final messageSender = message['sender'];
            final messageText = message['text'];
            final currentUser = AuthService.getCurrentUserEmail();
            // final timeStamp = message['timestamp'];
            messageBubbles.add(ChatBubble(
              message: messageText,
              sender: messageSender,
              isCurrentUser: messageSender == currentUser,
            ));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}
