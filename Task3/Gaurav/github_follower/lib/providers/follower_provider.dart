import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/follower.dart';
import '../services/github_api_service.dart';

class FollowerProvider extends ChangeNotifier {
  final GetApiData _apiData = GetApiData();
  List<FollowersModel> _followers = [];
  bool fetchingData = false;
  List<FollowersModel> get followers => _followers;
   late FollowersModel _userData;
   FollowersModel get userData => _userData;

  Future<void> fetchUser(String username) async {
    try {
      _userData = (await _apiData.fetchMe(username))!;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchFollowers(String username) async {
    fetchingData = true;
    try {
      // fetchUser(username);
      _followers = await _apiData.fetchFollowersList(username);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
    fetchingData = false;
  }
}
