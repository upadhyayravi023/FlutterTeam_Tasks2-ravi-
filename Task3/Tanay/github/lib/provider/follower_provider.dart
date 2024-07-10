import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FollowerProvider with ChangeNotifier {

  List Followers = [];
  var userinfo;

  final String token = dotenv.env['Token'].toString();

  getuserinfo() => userinfo;
  List<dynamic> getfollower() => Followers;

  void notifyfollowers() {
    notifyListeners();
  }

  void importFollowers() async {
    
    // print("importing followers");

    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    Followers = [];
    final response = await http.get(
      Uri.parse("https://api.github.com/users/$username/followers"),
      headers: {'Authorization': 'Bearer $token'},
    );
    var data = jsonDecode(response.body.toString());

    for (Map i in data) {
      Followers.add(i);
    }
    final response2 = await http.get(
      Uri.parse("https://api.github.com/users/$username"),
      headers: {'Authorization': 'Bearer $token'},
    );
    userinfo = jsonDecode(response2.body.toString());
    notifyfollowers();
  }

  
}
