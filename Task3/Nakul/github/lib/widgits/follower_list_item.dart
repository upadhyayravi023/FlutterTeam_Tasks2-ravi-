import 'package:flutter/material.dart';
import 'package:github/provider/follower_provider.dart';
import 'package:provider/provider.dart';

class FollowerListItem extends StatefulWidget {
 final String name;
  final String image;
   FollowerListItem({super.key, required this.name,required this.image});

  @override
  State<FollowerListItem> createState() => _FollowerListItemState();
}

class _FollowerListItemState extends State<FollowerListItem> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<FollowersProvider>(context,listen: false);
    return Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  
                                  height: 86,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:NetworkImage(widget.image),
                                      radius: 29,
                                    ),
                                    title: Transform.translate(
                                       offset: Offset(-9, 0),
                                      
                                      child: Text(widget.name,style: TextStyle(fontSize: 18,color: Colors.grey ,),)),
                                    trailing: GestureDetector(
                                      onTap: () async{
                                        user.getdata(widget.name);
                                        
                                      },
                                      
                                      
                                      child: Text("Followers",style: TextStyle(fontSize: 15,color: Colors.blue),)),
                                    
                                            
                                  ),
                                  
                                ),
                                Opacity(
                                  opacity: 0.1,
                                  child: Divider(height: 1,color: Colors.grey,))
                              ],
                            
                        );
  }
}