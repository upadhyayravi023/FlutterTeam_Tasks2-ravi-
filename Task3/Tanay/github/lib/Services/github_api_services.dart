import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/models/userinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class GithubApiService {

  final String token= dotenv.env['Token'].toString();

   Future<List<UserInfo>> getFollowers() async {
   final prefs = await SharedPreferences.getInstance();
    final username=prefs.getString('username');
    final response = await http.get(
      Uri.parse(  "https://api.github.com/users/$username/followers"),

      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
     final data = jsonDecode(response.body);
     final List<UserInfo> followerList=[];
      for(Map i in data){
        followerList.add(
          UserInfo(imageUrl: i['avatar_url'], username: i['login'])
        );
      }
      return followerList;
    } else {
     return [];
    }
  }

  Future <UserInfo> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String token= dotenv.env['Token'].toString();
    final username=prefs.getString('username');
    final response = await http.get(
        Uri.parse(  "https://api.github.com/users/$username"),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserInfo(imageUrl: data['avatar_url'], username: data['login']);
    } else {
      return UserInfo(imageUrl: "https://unsplash.com/photos/selective-focus-photography-of-latte-in-teacup-jn-HaGWe4yw" , username: "User Not Found");
    }
  }


}
