class UserInfo{
  final String? imageUrl;
  final String? username;

  const UserInfo({required this.imageUrl, required this.username});

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(imageUrl: json['avatar_url'], username: json['login']);
  }

  Map<String, dynamic> toJson(){
    return{
      "avatar_url" : imageUrl,
      "login": username,
    };
  }
}