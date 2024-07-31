import 'package:flutter/material.dart';
import 'package:github_follower/Models/follower.dart';

import '../Services/github_api_service.dart';

class followerProvider extends ChangeNotifier{
  final githubApiService apiService = githubApiService();
  bool isLoadingData = false;
  List<follower> followersInfo = [];
  List<follower> get followers => followersInfo;
  late follower userInfoData;
  follower get userinfo => userInfoData;
  bool get isloading => isLoadingData;

  Future<void> getData(String username) async {
    isLoadingData = true;
    notifyListeners();
    followersInfo = await apiService.getFollowers(username);
    userInfoData = await apiService.getUser(username);
    isLoadingData = false;
    notifyListeners();
  }
}