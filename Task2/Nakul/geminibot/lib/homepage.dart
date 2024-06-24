import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
    final Gemini gemini=Gemini.instance;//for accessing gemini instance

   List<ChatMessage> messages=[];//will store all of our messages initially it is empty

  ChatUser currentUser = ChatUser(id: "0",firstName: "user");
  ChatUser geminiuser =ChatUser(id: "1",firstName: "Gemini",profileImage: "https://www.shutterstock.com/image-vector/rivne-ukraine-december-18-2023-260nw-2402054293.jpg");
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 248, 203, 41),
        title: Center(child: Container(
          child: Text("Gemini Chat",style: TextStyle(color: Colors.black,fontSize: 24),),
        ),)
      ),
      body: _buildUI(),
    );

  }
  Widget _buildUI(){

    return DashChat(
      inputOptions: InputOptions(trailing: [IconButton(onPressed: _sendMediaMessage, icon: Icon(Icons.image))]),//for selecting images
      currentUser: currentUser,
       onSend: _sendMessage  ,
        messages: messages);//for our messages
  }

  void _sendMessage(ChatMessage chatMessage){//this function contain all of the info about chat messages
   setState(() {
     messages=[chatMessage, ...messages];//... take all the elemnt from list and add it to the new list
   });
   try{
      String question=chatMessage.text;//question that user ask
      List<Uint8List>?images;
      if(chatMessage.medias?.isNotEmpty ?? false){
        images=[File(chatMessage.medias!.first.url).readAsBytesSync()];

      }
      gemini.streamGenerateContent(question,images: images).listen((event) {
        ChatMessage? lastMessage =messages.firstOrNull;
       if(lastMessage !=null && lastMessage.user==geminiuser){  //check last message is from gemini or not
       lastMessage=messages.removeAt(0);
          String response=event.content?.parts?.fold("", (previous,current)=> "$previous ${current.text}")?? "";
          lastMessage.text += response;
          setState(() {
            messages=[lastMessage!,...messages];
          });


       }else{
        String response=event.content?.parts?.fold("", (previous,current)=>"$previous ${current.text}")?? "";
        ChatMessage message=ChatMessage(user: geminiuser, createdAt: DateTime.now(),text: response);
        setState(() {
          messages=[message,...messages];
        });
       }
        
      });

   } catch(e){
    print(e);
   }

  }
  void _sendMediaMessage() async {
    ImagePicker picker=ImagePicker();
    XFile? file= await picker.pickImage(source: ImageSource.gallery);
    if(file !=null){
      ChatMessage chatMessage=ChatMessage(user: currentUser, createdAt: DateTime.now(),text: "Describe this picture?",
      medias: [
        ChatMedia(url: file.path, fileName: "", type: MediaType.image)
        


      ]
    );
    _sendMessage(chatMessage);
    }
  }
}