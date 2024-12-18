import 'package:flash_chat_app/components/group_chat_stream.dart';
import 'package:flash_chat_app/components/user_input_row.dart';
import 'package:flash_chat_app/services/databases/group_chat_database.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/constants.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key});

  static const pathName = 'group_chat_screen';

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final messageController = TextEditingController();
  @override
  void initState() {
    messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // void getMessages() async {
  //   final allMessages = await GroupchatDatabase.messagesCollection.get();
  //   for (var message in allMessages.docs) {
  //     print(message.data());
  //   }
  // }

  // void getMessagesStream() async {
  //   await for (var snapshot in GroupchatDatabase.messagesStream) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  void _sendMessage() async {
    messageController.text.isNotEmpty
        ? await GroupchatDatabase.sendMessage(messageController.text)
        : null;
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        actions: const [],
        title: Row(
          children: [lightningBolt, const Text(' Groupchat')],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GroupChatStream(),
          // Container(
          //   decoration: kMessageContainerDecoration,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: messageController,
          //           decoration: kMessageTextFieldDecoration,
          //         ),
          //       ),
          //       TextButton.icon(
          //         label: const Icon(
          //           Icons.send_rounded,
          //           color: Colors.lightBlueAccent,
          //         ),
          //         onPressed: ()=> _sendMessage,
          //       ),
          //     ],
          //   ),

          UserInputRow(
              controller: messageController,
              onPressed: _sendMessage),
        ],
      ),
    );
  }
}
