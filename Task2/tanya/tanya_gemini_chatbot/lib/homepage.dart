
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "user");
  ChatUser geminiuser = ChatUser(
      id: "1",
      firstName: "Gemini",
      profileImage:
          "https://th.bing.com/th/id/OIP.AbGafkazjc_S1pZPh0B9cQHaIm?rs=1&pid=ImgDetMain");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 100, 167, 243),
        centerTitle: true,
        title: Text(
          "Gemini Chatbot",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        currentUser: currentUser, onSend: _sendMessage, messages: messages);
  } 

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiuser) {
          lastMessage=messages.removeAt(0);
          String response = event.content?.parts
                  ?.fold("", (previous, current) => "$previous$current") ??
              "";
         lastMessage.text=response;
         setState(() {
           messages=[lastMessage!, ...messages];
         });
        } else {
          String response = event.content?.parts
                  ?.fold("", (previous, current) => "$previous$current") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiuser, createdAt: DateTime.now(), text: response,);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
