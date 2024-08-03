import 'package:flutter/material.dart';
import 'package:github/models/info.dart';
import 'package:github/services/github_api_service.dart';

class FollowersProvider with ChangeNotifier{
  final githubApiService services=githubApiService();
  List<Info> _followers=[];
  List<Info> get followers=>_followers;
  bool _isLoading=false;
  bool get isloading =>_isLoading;
   late Info _userinfo;
  Info get userinfo=> _userinfo;

  Future<void> getdata(String userNam) async{
    _isLoading=true;
    notifyListeners();
    _userinfo =await services.getUserinfo(userNam);
    _followers=await services.getFollowers(userNam);
    _isLoading=false;
    notifyListeners();


  }


}