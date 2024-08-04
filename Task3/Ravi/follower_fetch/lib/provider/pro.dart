import 'package:flutter/foundation.dart';
import 'package:follower_fetch/Services/github_api.dart';
import 'package:follower_fetch/Models/user.dart';

class gitProvider with ChangeNotifier {
  final ServiceApi _apiService = ServiceApi();
  bool _isLoading = false;
  late UserInfo _userinfo;
  List<UserInfo> _followers = [];
  List<UserInfo> get followers => _followers;
  UserInfo get userinfo => _userinfo;
  bool get isloading => _isLoading;

  Future<void> getData() async {
    _isLoading = true;
    notifyListeners();

    _userinfo = await _apiService.getUser();
    _followers = await _apiService.getFollowers();
    _isLoading = false;
    notifyListeners();
  }
}