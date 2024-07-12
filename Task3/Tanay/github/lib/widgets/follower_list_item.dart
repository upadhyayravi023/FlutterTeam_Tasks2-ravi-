import 'package:flutter/material.dart';
import 'package:github/provider/follower_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class followerListItem extends StatelessWidget{
  
  followerListItem({required this.imageUrl, required this.username});
  final String imageUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<FollowerProvider>(context, listen: false);
   return Padding(
     padding: const EdgeInsets.only(left: 20, right: 20),
     child: Column(
       children: [
         ListTile(
           title: Text(username),
           leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl.toString()),
             radius: 30,),
           trailing: GestureDetector(
             onTap: () async {
               final prefs = await SharedPreferences
                   .getInstance();
               prefs.setString("username", username);
               value.getData();
             },
             child: const Text("Followers",
               style: TextStyle(color: Colors.blue,fontSize: 15),),
           ),
         ),
         const Divider(color: Colors.grey,thickness: 1,)
       ],
     ),
   );
  }

}