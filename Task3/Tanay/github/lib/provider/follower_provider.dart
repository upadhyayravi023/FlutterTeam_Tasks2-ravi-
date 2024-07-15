import 'package:flutter/foundation.dart';
import 'package:github/Services/github_api_services.dart';
import 'package:github/models/userinfo.dart';

class FollowerProvider with ChangeNotifier {
  final GithubApiService _apiService = GithubApiService();
  bool _isLoading = false;
  List<UserInfo> _followers = [];
  List<UserInfo> get followers => _followers;
  late UserInfo _userinfo;
  UserInfo get userinfo => _userinfo;
  bool get isloading => _isLoading;

  Future<void> getData() async {
    _isLoading = true;
    notifyListeners();
    _followers = await _apiService.getFollowers();
    _userinfo = await _apiService.getUser();
    _isLoading = false;
    notifyListeners();
  }
}
