import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

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

    return DashChat(currentUser: currentUser, onSend: _sendMessage  , messages: messages);//for our messages
  }

  void _sendMessage(ChatMessage ChatMessage){//this function contain all of the info about chat messages
   setState(() {
     messages=[ChatMessage, ...messages];//... take all the elemnt from list and add it to the new list
   });
   try{
      String question=ChatMessage.text!;//question that user ask
      gemini.streamGenerateContent(question).listen((event) {
        
      });

   } catch(e){
    print(e);
   }

  }
}