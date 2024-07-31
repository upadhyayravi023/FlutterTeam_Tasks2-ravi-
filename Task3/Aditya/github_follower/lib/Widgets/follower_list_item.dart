import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class FollowerListItem extends StatefulWidget {
  final String username;
  final String profileUrl;
  const FollowerListItem({super.key, required this.username, required this.profileUrl});

  @override
  State<FollowerListItem> createState() => _FollowerListItemState();
}

class _FollowerListItemState extends State<FollowerListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(widget.profileUrl),radius: 35,),
          SizedBox(width: 10,),
          Expanded(child: Text(widget.username,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,overflow: TextOverflow.ellipsis),)),
          Spacer(),
          Text("Followers",style: TextStyle(color: Colors.blueAccent),),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}
