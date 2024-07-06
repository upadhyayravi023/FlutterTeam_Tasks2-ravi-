import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  final Gemini gimini = Gemini.instance;
  ChatUser currentuser = ChatUser(id: "0", firstName: "user");
  ChatUser Guser = ChatUser(
      id: "1", firstName: "Gimini",
      profileImage:"https://cdn.analyticsvidhya.com/wp-content/uploads/2023/12/Gemini-scaled.jpg"
  );
  List<ChatMessage> messages = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        title: Text('Gemini Chat', style: TextStyle(fontWeight: FontWeight.w400),),
      ),
      body: buildUI(),
    );
  }
  Widget buildUI(){
    return DashChat(
      currentUser: currentuser,
      onSend: sendmessage,
      messages: messages,
      inputOptions: InputOptions(
          trailing: [
            IconButton(onPressed: sendImage, icon: Icon(Icons.image_outlined))
          ]
      ),
    );
  }

  void sendImage()async{
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery
    );
    if (file != null){
      ChatMessage chatMessage = ChatMessage(user: currentuser, createdAt: DateTime.now(), text: "Description of the above image ",
          medias: [ChatMedia(url: file.path, fileName: "", type: MediaType.image)]
      );
      sendmessage(chatMessage);
    }
  }

  void sendmessage(ChatMessage chatMessage){
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images ;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
      gimini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (
        lastMessage != null && lastMessage.user == Guser) {
          String response = event.content?.parts?.fold(
              "", (pvalue, cvalue) => "$pvalue ${cvalue.text}") ?? "";
          lastMessage = messages.removeAt(0);
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
              "", (pvalue, cvalue) => "$pvalue ${cvalue.text}") ?? "";
          ChatMessage message = ChatMessage(
              user: Guser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ... messages];
          });
        }
      });
    }
    catch(e){
      print(e);
    }
  }
}

