
class FollowersModel{
  final String login;
  final int id;
  final String avatar_url;
  final String followers_url;

  FollowersModel({
    required this.login,
    required this.id,
    required this.avatar_url,
    required this.followers_url,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json){
    return FollowersModel(
    login : json['login'],
    id : json['id'],
    avatar_url : json['avatar_url'],
    followers_url : json['followers_url'],
    );
  }



  Map<String, dynamic> toJson(){
    return {
      'login' : login,
      'id' : id,
      'avatar_url' : avatar_url,
      'followers_url' : followers_url,
    };
  }
}
