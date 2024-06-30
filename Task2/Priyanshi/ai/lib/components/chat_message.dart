import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isCurrentUser;

  const ChatMessageWidget({
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background to see the gradient
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: isCurrentUser ? Colors.white : Colors.black, // Text color of messages
        ),
      ),
    );
  }
}
