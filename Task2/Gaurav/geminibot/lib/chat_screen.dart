import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/color_scheme.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final gemini = Gemini.instance;

  final ChatUser myUser = ChatUser(id: "0", firstName: "User");
  final ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Gemini",
      profileImage:
          "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png");
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gemini Chat"),
        backgroundColor: AppColors.neptune500,
      ),
      backgroundColor: AppColors.neptune100,
      body: DashChat(
        currentUser: myUser,
        onSend: onSend,
        messages: messages,
        inputOptions: InputOptions(leading: [
          IconButton(
            onPressed: sendImageMessage,
            icon: const Icon(
              Icons.image_search,
              color: AppColors.neptune800,
            ),
          )
        ]),
        messageOptions: const MessageOptions(
            containerColor: AppColors.neptune400,
            currentUserContainerColor: AppColors.neptune500,
            textColor: AppColors.neptune950,
            currentUserTextColor: AppColors.neptune100),
      ),
    );
  }

  void onSend(ChatMessage m) {
    setState(() {
      messages = [m, ...messages];
    });
    try {
      String query = m.text;
      List<Uint8List>? images;
      if (m.medias?.isNotEmpty ?? false) {
        images = [File(m.medias!.first.url).readAsBytesSync()];
      }
      gemini.streamGenerateContent(query, images: images).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "}";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "}";
          ChatMessage newmessage = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [newmessage, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendImageMessage() async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: myUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(fileName: "", url: file.path, type: MediaType.image)
          ]);
      onSend(chatMessage);
    }
  }
}
