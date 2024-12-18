import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.startTextAtStart,
    this.focusNode, this.maxLines,
  });

  final String hintText;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;
  final bool? startTextAtStart;
  final FocusNode? focusNode;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: 1,
      textAlign: startTextAtStart == true ? TextAlign.start : TextAlign.center,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
