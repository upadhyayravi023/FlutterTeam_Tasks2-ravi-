// ignore_for_file: file_names

import 'dart:io';
import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_chat_bot/Widgets/chatmsg.dart';
import 'package:ai_chat_bot/Widgets/datebox.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});
  final String title;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final apiKey = dotenv.env['Gemini_API'].toString();
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final _scrollController =ScrollController();
 DateTime _initialDate = DateTime.now().subtract(const Duration(hours: 25));
  final _controller= TextEditingController();
  final ImagePicker picker = ImagePicker();
  bool downbtn = false;
  bool showSend=false;
    final List _elements=[{'Date': DateFormat.yMMMd().format(DateTime.now().subtract(const Duration(hours: 48))), 'message': const ChatMessage(
      ifUser: true,
      text: "Hello! Nice to meet you. (Demo)",
      time: "11:59 PM",
    )},{'Date': DateFormat.yMMMd().format(DateTime.now().subtract(const Duration(hours: 24))), 'message': const ChatMessage(
      ifUser: false,
      text: "It's nice to meet you too!😊 How can i help you today? (Demo) ",
      time: "12:01 AM",
    )}];


  @override
  void initState() {

    super.initState();
    _controller.addListener(() {
      if(_controller.text.isEmpty){
       setState(() {
         showSend=false;
       });
      }
      else{
        setState(() {
          showSend=true;
        });
      }
    });
    _scrollController.addListener(() {
      if(_scrollController.position.pixels < _scrollController.position.maxScrollExtent){
        setState(() {
          downbtn=true;
        });
      }
      else{
        setState(() {
          downbtn=false;
        });
      }
    });
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    _chat = _model.startChat();
  }

  void _scrolldown(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    });
  }

  void _sendContents(Content content) async{
    try {

      var responses = _chat.sendMessageStream(content);
      String resptext="";
      await for(final response in responses){
        resptext+= response.text!;
        setState(() {
          _elements[_elements.length-1]=({'Date':DateFormat.yMMMd().format(_initialDate),'message':ChatMessage(ifUser: false, text: resptext,time: DateFormat.jm().format(DateTime.now()))});
        
        });
        _scrolldown();
      }

    } on Exception catch (e) {
      setState(() {
        _elements.add({'Date':DateFormat.yMMMd().format(_initialDate),'message':ChatMessage(ifUser: false, text: e.toString() ,time: DateFormat.jm().format(DateTime.now()))});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Colors.blue,
        title: Text(widget.title ,style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white,fontSize: 25, letterSpacing: 1.5),),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.78,
                  child: GroupedListView<dynamic, String>(
                    useStickyGroupSeparators: true,
                    shrinkWrap: true,
                    elements: _elements,
                    groupBy: (element) => element['Date'],
                    stickyHeaderBackgroundColor: Colors.transparent,
                    controller: _scrollController,
                    groupSeparatorBuilder: (String value)=>SizedBox(height: 65,child: Datebox(date: value)),
                    indexedItemBuilder: (context, dynamic element, index) => Column(
                        children: [
                      element['message'] as ChatMessage,
                        ],
                      ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _controller,
                          decoration: InputDecoration(hintText: "Write Someting...",border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.blue)
                          ),
                               suffixIcon: showSend? IconButton(
                                icon: const Icon(Icons.send,color: Colors.blue),
                                onPressed: ()async{
                                  String message= _controller.text;
                                  _controller.clear();
                                  setState(() {
                                    if(_initialDate.day!=DateTime.now().day || _initialDate.month!=DateTime.now().month ||_initialDate.year!=DateTime.now().year){
                                        _initialDate= DateTime.now();
                                    }
                                    _elements.add({'Date':DateFormat.yMMMd().format(_initialDate),'message':ChatMessage(ifUser: true, text: message,time: DateFormat.jm().format(DateTime.now()))});
                                    _elements.add({'Date':DateFormat.yMMMd().format(_initialDate),'message':ChatMessage(ifUser: false, text: "Gemini Typing...",time: DateFormat.jm().format(DateTime.now()))});
      
                                  });
                                  _scrolldown();
                                  Content ask=  Content.text(message);
                                   _sendContents(ask);

                                },
                              ):null
                          ),

                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final XFile? xFileimage = await picker.pickImage(source: ImageSource.gallery);
                          final  image = File(xFileimage!.path);
                          Uint8List img = await image.readAsBytes();
                          setState(() {
                           if(_initialDate.day!=DateTime.now().day || _initialDate.month!=DateTime.now().month ||_initialDate.year!=DateTime.now().year){
                           _initialDate = DateTime.now();
                         }
                           _elements.add({'Date':DateFormat.yMMMd().format(_initialDate), 'message': ChatMessage(ifUser: true, text:"What's this picture",image: image ,time: DateFormat.jm().format(DateTime.now()))});
                            _elements.add({'Date':DateFormat.yMMMd().format(_initialDate), 'message': ChatMessage(ifUser: false, text:"Gemini Typing ...",time: DateFormat.jm().format(DateTime.now()))});
                                   });
                            final content =
                              Content.multi([
                                TextPart("Describe this picture"),
                                DataPart('image/jpeg', img),
                              ]);
                            _scrolldown();
                          _sendContents(content);

                        },
                        icon: const Icon(Icons.image,size: 30,color: Colors.blue,),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),

          if(downbtn)Positioned(
              bottom: 80,
              right: 10,
              child: IconButton(onPressed: (){
                _scrolldown();
              }, icon: const Icon(Icons.keyboard_double_arrow_down, size: 30,))
          ),

        ],
      ),
    );
  }
}