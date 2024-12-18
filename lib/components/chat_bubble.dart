import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      this.sender});

  final String message;
  final bool isCurrentUser;
  final String? sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
        child: Material(
          borderRadius: BorderRadius.only(
            topRight: isCurrentUser
                ? const Radius.circular(0)
                : const Radius.circular(8),
            topLeft: isCurrentUser
                ? const Radius.circular(8)
                : const Radius.circular(0),
            bottomRight: const Radius.circular(8),
            bottomLeft: const Radius.circular(8),
          ),
          color: isCurrentUser ? Colors.green : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sender != null
                    ? Text(
                        sender!,
                        style: const TextStyle(fontSize: 8.5),
                      )
                    : const SizedBox(height: 0, width: 0),
                Text(
                  message,
                  style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
