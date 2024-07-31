import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../Models/follower.dart';

class githubApiService {

  final String key= dotenv.env['KEY'].toString();

  Future<List<follower>> getFollowers(String username) async {

    final response = await http.get(
      Uri.parse("https://api.github.com/users/$username/followers"),

      headers: {'Authorization': 'Bearer $key'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<follower> followerList=[];
      for(Map i in data){
        followerList.add(
            follower(profileUrl: i['avatar_url'], username: i['login'])
        );
      }
      return followerList;
    } else {
      return [];
    }
  }

  Future <follower> getUser(String username) async {
    final String token= dotenv.env['KEY'].toString();
    final response = await http.get(
        Uri.parse(  "https://api.github.com/users/$username"),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return follower(profileUrl: data['avatar_url'], username: data['login']);
    } else {
      return follower(profileUrl: "https://unsplash.com/photos/selective-focus-photography-of-latte-in-teacup-jn-HaGWe4yw" , username: "User Not Found");
    }
  }


}