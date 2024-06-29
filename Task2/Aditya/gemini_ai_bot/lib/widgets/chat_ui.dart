import 'package:flutter/material.dart';
class chat_ui extends StatefulWidget {
  final image;
  final isUser;
  final text;
  final time;

  const chat_ui({super.key, this.image, required this.isUser, required this.text, required this.time});

  @override
  State<chat_ui> createState() => _chat_uiState();
}

class _chat_uiState extends State<chat_ui> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        textDirection: widget.isUser ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            radius: 27,
            backgroundImage: AssetImage(widget.isUser?"assets/images/user.jpg":"assets/images/ai.jpg"),
          ),
          //Icon(widget.isUser?Icons.person:Icons.adb,),
          Column(
            children: [
              if(widget.image!=null)...[Image(image: widget.image)],
              Container(
                  child: Text(widget.text,),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.5,
                ),
                decoration: BoxDecoration(
                  color: widget.isUser?Colors.blue[100]:Colors.green[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text(widget.time,style: TextStyle(fontSize: 10),textAlign: TextAlign.end,)
            ],
          ),
        ],
      ),
    );
  }
}
