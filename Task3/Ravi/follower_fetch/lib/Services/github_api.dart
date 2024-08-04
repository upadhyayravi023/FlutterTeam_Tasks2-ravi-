import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user.dart';

class ServiceApi {
  final String key= dotenv.env['key'].toString();
  Future<String?> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<List<UserInfo>> getFollowers() async {
    final username = await _getUsername();
    if (username == null) {
      return [];
    }

    final response = await http.get(
      Uri.parse("https://api.github.com/users/$username/followers"),
      headers: {'Authorization': 'Bearer $key'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => UserInfo(avatar_url: json['avatar_url'], name: json['login'])).toList();
    } else {
      return [];
    }
  }

  Future<UserInfo> getUser() async {
    final username = await _getUsername();
    if (username == null) {
      return UserInfo(
        avatar_url: "https://www.istockphoto.com/photo/indian-street-stray-dogs-with-ears-straight-upwards-and-frowned-with-anger-looking-gm1193747353-339672446?utm_campaign=srp_photos_bottom&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fpicture-not-found&utm_medium=affiliate&utm_source=unsplash&utm_term=picture+not+found%3A%3A%3A",
        name: "User Not Found",
      );
    }

    final response = await http.get(
      Uri.parse("https://api.github.com/users/$username"),
      headers: {'Authorization': 'Bearer $key'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserInfo(avatar_url: data['avatar_url'], name: data['login']);
    } else {
      return UserInfo(
        avatar_url: "https://www.istockphoto.com/photo/indian-street-stray-dogs-with-ears-straight-upwards-and-frowned-with-anger-looking-gm1193747353-339672446?utm_campaign=srp_photos_bottom&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fpicture-not-found&utm_medium=affiliate&utm_source=unsplash&utm_term=picture+not+found%3A%3A%3A",
        name: "User Not Found",
      );
    }
  }
}
