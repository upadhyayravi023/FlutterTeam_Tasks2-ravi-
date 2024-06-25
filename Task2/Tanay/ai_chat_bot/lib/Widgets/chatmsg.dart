import 'package:flutter/material.dart';
import 'dart:io';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
      this.text,
      this.image,
      required this.time,
      required this.ifUser});
  final String? text;
  final String time;
  final File? image;
  final bool ifUser;

  @override
  Widget build(BuildContext context) {
    String _time = time;
    final textPainter = TextPainter(
      text: TextSpan(text: "${text!.trimRight()}\n"),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textWidth = textPainter.size.width;
    final File boximage = image != null ? image! : File("assets/user.png");
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: ifUser ? TextDirection.rtl : TextDirection.ltr,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    ifUser ? "assets/user.png" : "assets/Designer.png"),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment:
                    ifUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(ifUser ? "You  " : "  Gemini"),
                  if (text != null)
                    Container(
                      width: textWidth + 95,
                      constraints:
                          const BoxConstraints(maxWidth: 250, minWidth: 100),
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 20, bottom: 5),
                      decoration: BoxDecoration(
                          color: ifUser ? Colors.lightBlue : Colors.grey[350],
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Text(
                            "${text!.trimRight()}\n",
                            softWrap: true,
                            textAlign: TextAlign.left,
                          ),
                          Positioned(bottom: 0, right: 0, child: Text(_time))
                        ],
                      ),
                    ),
                  if (image != null)
                    const SizedBox(
                      height: 15,
                    ),
                  if (image != null) Image.file(boximage, width: 250),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
