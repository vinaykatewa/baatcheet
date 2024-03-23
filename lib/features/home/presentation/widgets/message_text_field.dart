// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onPressed;
  const MessageTextField({
    // Key? key,
    required this.hintText,
    required this.controller,
    required this.onPressed,
  });
  //  : super(key: key);
  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: TextField(
                controller: widget.controller,
                onSubmitted: (value) {
                  widget.onPressed();
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your message',
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }
}
