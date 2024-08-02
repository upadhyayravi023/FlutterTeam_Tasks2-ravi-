import 'dart:convert';

import 'package:github/models/info.dart';
import 'package:http/http.dart' as http;

class githubApiService{

  Future<List<Info>> getFollowers(String userName) async{
    final user=userName;
    final response= await http.get(Uri.parse("https://api.github.com/users/$user/followers"));
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
       final List<Info> followerList=[];
       for(Map i in data){
        followerList.add(
          Info(userName: i['login'], avatarUrl: i['avatar_url'])
        );
       }
       return followerList;
    }
    else{
      return [];
    }
  } 

   Future<Info> getUserinfo(String userName) async{
    final user=userName;
    final response= await http.get(Uri.parse("https://api.github.com/users/$user"));
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      return Info(userName: data['login'], avatarUrl: data['avatar_url']);
       
     
       
    }
    else{
      return Info(userName: "Username not found", avatarUrl: "https://w7.pngwing.com/pngs/711/768/png-transparent-white-and-brown-dog-illustration-emoji-emoticon-dog-smiley-whatsapp-emoji-carnivoran-dog-like-mammal-car.png") ;
    }
  } 
  
}