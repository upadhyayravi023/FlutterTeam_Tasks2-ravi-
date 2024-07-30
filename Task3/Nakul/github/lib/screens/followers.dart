import 'package:flutter/material.dart';
import 'package:github/provider/follower_provider.dart';
import 'package:github/widgits/follower_list_item.dart';
import 'package:provider/provider.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),

      body:Padding(
          padding: EdgeInsets.only(left: 3,right: 3),
          
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            
          
            child: Consumer<FollowersProvider>(builder: (context,value,child){
              if(value.userinfo.userName!=null){
                return Column(
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  backgroundImage: NetworkImage(value.userinfo.avatarUrl.toString()),
                  radius: 60,
                  
                ),
                SizedBox(height: 30,),
                Text(value.userinfo.userName.toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24),),
          
                
                  Container(
                    
                  height: 500,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                       
                       
                       shrinkWrap: true,
                      itemCount: value.followers.length,
                      itemBuilder: (context,Index){
                        return  FollowerListItem(name: value.followers[Index].userName.toString(), image:value.followers[Index].avatarUrl.toString());
                                 }),
                  ),
                  
                
               
              ],
            );
              }
              else{
                return Text("Wait");
              }
            })
          ),
        
      ),
      
    );
  }
}