// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';

class NewChannelTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onPressed;
  const NewChannelTextField({super.key,
    required this.hintText,
    required this.controller,
    required this.onPressed,
  });
  @override
  _NewChannelTextFieldState createState() => _NewChannelTextFieldState();
}

class _NewChannelTextFieldState extends State<NewChannelTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: SizedBox(
        height: 45.0,
        child: TextField(
          controller: widget.controller,
          onSubmitted: (value) {
            widget.onPressed();
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Enter your message',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send, size: 30.0,),
              onPressed: widget.onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
