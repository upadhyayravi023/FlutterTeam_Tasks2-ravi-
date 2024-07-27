import 'package:flutter/material.dart';
import 'package:github/widgits/follower_list_item.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Padding(
          padding: EdgeInsets.only(left: 3,right: 3),
          
          child: Container(
            alignment: Alignment.center,
          
            child: Column(
              
             
            
              children: [
                SizedBox(height: 70,),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg"),
                  radius: 60,
                  
                ),
                SizedBox(height: 30,),
                Text("Nakul Varshney",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24),),
          
                
                  Container(
                    
                  height: 540,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                       
                       
                       shrinkWrap: true,
                      itemCount: 100,
                      itemBuilder: (context,builder){
                        return  FollowerListItem(name: "Captain", image:"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg");
                                  
                                      }),
                  ),
                  
                
               
              ],
            ),
          ),
        
      ),
      
    );
  }
}