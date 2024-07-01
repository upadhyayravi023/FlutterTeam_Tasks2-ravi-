
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_ai_bot/widgets/chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  //bool isLoading = false;
 // late final content;
  late final chat;
  final List<({String? image, String? text, bool isUser})> contentList =  <({String? image, String? text, bool isUser})>[];
  final ScrollController scrollController = ScrollController();

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
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('kk:mm - d MMM').format(now);
                  return chat_ui(isUser: contentList[index].isUser, text: contentList[index].text, time: formattedDate, image: contentList[index].image,);
                },
                itemCount: contentList.length,
                  controller: scrollController,
                )
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.08,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blueAccent,
              child: Row(
                children: [
                  IconButton(
                   icon:  Icon(Icons.add_photo_alternate_outlined),
                    color: Colors.white,
                    onPressed: () {
                     sendImagePrompt(chatText.text);
                    },
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
   // scrollDown();
    contentList.add((image: null,text: chat,isUser: true));
    setState(() {
      contentList.add((image: null,text: "Gemini is typing!!!",isUser: false));
      // isLoading = true;
      chatText.clear();
        scrollDown();
    });
   final content = [Content.text(chat)];
    response = await model.generateContent(content);
    contentList.insert(contentList.length-1, (image: null, text: response.text, isUser: false));
    //contentList.add((image: null,text: response.text,isUser: false));
    setState(() {
      contentList.removeAt(contentList.length-1);
      // isLoading = false;
      scrollDown();
    });
  }
  Future<void> sendImagePrompt(String chat) async{
    Uint8List byteData;
   ImagePicker imagePicker = new ImagePicker();
   final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  if(pickedFile != null){
    byteData = await pickedFile.readAsBytes();

  contentList.add((image: pickedFile.path,text: chat.isNotEmpty?chat:"Describe the image.",isUser: true));
  setState(() {
    // isLoading = true;
    contentList.add((image: null,text: "Gemini is typing!!!",isUser: false));
    chatText.clear();
    scrollDown();
  });
  final content = [Content.multi([
    TextPart(chat.isNotEmpty?chat:"Describe the image."),
    DataPart("image/*", byteData)
  ])];

    var response = await model.generateContent(content);
    var text = response.text;
    contentList.insert(contentList.length-1, (image: null, text: text, isUser: false));
   // contentList.add((image: null, text: text, isUser: false));
    setState(() {
      contentList.removeAt(contentList.length-1);
      // isLoading = false;
      scrollDown();
    });
  }
  }

  void scrollDown(){
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }
}
