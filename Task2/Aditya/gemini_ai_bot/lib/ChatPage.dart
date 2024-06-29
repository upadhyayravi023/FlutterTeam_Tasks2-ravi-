import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_ai_bot/widgets/chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}



class _ChatPageState extends State<ChatPage> {
  late final GenerativeModel model;
  TextEditingController chatText = TextEditingController();
  bool showIcon = false;
  String prompt = '';
  late final response;
  late final content;
  late final chat;
  final List<({Image? image, String? text, bool isUser})> contentList =  <({Image? image, String? text, bool isUser})>[];

  void initState() {
    super.initState();
    model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: '${dotenv.env["API_KEY"].toString()}',
    );
    chat = model.startChat();
    chatText.addListener(() {
      if (chatText.text.isNotEmpty) {
        setState(() {
          showIcon = true;
        });
      } else {
        setState(() {
          showIcon = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My AI Bot",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                  return chat_ui(isUser: contentList[index].isUser, text: contentList[index].text, time: "12:00 AM (12 June)", image: contentList[index].image,);
                },
                itemCount: contentList.length,
                )
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.08,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blueAccent,
              child: Row(
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 13),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          hintText: "Write a message...",
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.white),
                          suffixIcon: showIcon
                              ? IconButton(
                                  onPressed: () async {
                                     sendTextChat(chatText.text);
                                     print(response.text);
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ))
                              : null,
                        ),
                        controller: chatText,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
  Future<void> sendTextChat(String chat) async{
    contentList.add((image: null,text: chat,isUser: true));
    setState(() {

    });
    content = [Content.text(chat)];
    response = await model.generateContent(content);
    contentList.add((image: null,text: response.text,isUser: false));
    setState(() {

    });
  }
}
