import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';
import '../services/gemini_service.dart';
import '../services/message_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GeminiService _geminiService = GeminiService();
  final MessageService _messageService = MessageService();
  final List<ChatMessage> messages = [];
  final ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
    profileImage:
        "https://img.freepik.com/premium-vector/avatar-profile-pink-neon-icon-brick-wall-background-colour-neon-vector-icon_549897-254.jpg",
  );
  final ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://storage.googleapis.com/gweb-uniblog-publish-prod/images/Gemini_SS.width-1300.jpg",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 2, 58),
        centerTitle: true,
        title: const Text(
          "Gemini CHAT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 64, 10, 103), Colors.black],
            stops: [0.0, 0.67],
          ),
        ),
        child: DashChat(
            inputOptions: InputOptions(
              trailing: [
                IconButton(
                  onPressed: () => _pickAndSendImage(),
                  icon: Icon(Icons.image),
                ),
              ],
            ),
            currentUser: currentUser,
            onSend: _sendMessage,
            messages: messages),
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    _messageService.sendTextMessage(
      chatMessage: chatMessage,
      messages: messages,
      setMessageState: (message) {
        setState(() {
          messages.insert(0, message);
        });
      },
      currentUser: currentUser,
      geminiUser: geminiUser,
    );
  }

  void _pickAndSendImage() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      _messageService.sendImageMessage(
        file: file,
        sendTextMessage: _sendMessage,
        currentUser: currentUser,
        setMessageState: (message) {
          setState(() {
            messages.insert(0, message);
          });
        },
      );
    }
  }
}
