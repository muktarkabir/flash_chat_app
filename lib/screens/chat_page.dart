import 'package:flash_chat_app/components/chat_bubble.dart';
import 'package:flash_chat_app/components/user_input_row.dart';
import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/services/databases/user_database.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverId});

  final String receiverEmail;
  final String receiverId;

  static const pathName = 'chat_page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  final _myScrollController = ScrollController();

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await UsersDatabase.sendMessage(
          widget.receiverId, _messageController.text);
      _messageController.clear();
      scrollDown();
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 100), () => scrollDown());
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void scrollDown() {
    _myScrollController.animateTo(_myScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildMessagesList(), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessagesList() {
    final senderId = AuthService.currentUserId!;
    return StreamBuilder(
        stream: UsersDatabase.getMessagesStream(senderId, widget.receiverId),
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
            return const Text('No data to display');
          }
          final messages = snapshot.data?.docs;

          List<ChatBubble> chatBubbles = [];

          for (var message in messages!) {
            final messageSender = message['senderId'];
            final messageText = message['message'];
            final isCurrentUser = messageSender == AuthService.currentUserId;
            chatBubbles.add(
                ChatBubble(message: messageText, isCurrentUser: isCurrentUser));
          }
          return Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              controller: _myScrollController,
              children: chatBubbles,
            ),
          );
        });
  }

  // Widget _buildMessageItem(QueryDocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   var isCurrentUser = data['senderId'] == AuthService.currentUserId!;
  //   var alignment =
  //       isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
  //   return Container(
  //     alignment: alignment,
  //     child: Column(
  //       crossAxisAlignment:
  //           isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  //       children: [
  //         ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildUserInput() {
    return UserInputRow(
        controller: _messageController, onPressed: _sendMessage);
  }
}
