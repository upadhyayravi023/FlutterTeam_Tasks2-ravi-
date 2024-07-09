import 'dart:convert';
import 'package:github_follower/models/follower.dart';
import 'package:http/http.dart' as http;

class GetApiData {
  Future<List<FollowersModel>> fetchFollowersList(String username) async {
    try {
      var baseUrl = "https://api.github.com/users/";
      var getFollowerUrl = "$baseUrl$username/followers";

      http.Response response = await http
          .get(Uri.parse(getFollowerUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return List<FollowersModel>.from(
            jsonDecode(response.body).map((x) => FollowersModel.fromJson(x)));
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<FollowersModel?> fetchMe(String username) async {
    try {
      var baseUrl = "https://api.github.com/users/";
      var getMeUrl = "$baseUrl$username";

      http.Response response = await http
          .get(Uri.parse(getMeUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return FollowersModel.fromJson(map);
      }
      
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
