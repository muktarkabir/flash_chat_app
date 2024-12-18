import 'package:flash_chat_app/components/input_text_field.dart';
import 'package:flutter/material.dart';

class UserInputRow extends StatelessWidget {
  const UserInputRow(
      {super.key,
      this.focusNode,
      required this.controller,
      required this.onPressed});

  final FocusNode? focusNode;
  final TextEditingController controller;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: InputTextField(
              maxLines: 3,
              focusNode: focusNode,
              hintText: 'Type a message',
              controller: controller,
              startTextAtStart: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
