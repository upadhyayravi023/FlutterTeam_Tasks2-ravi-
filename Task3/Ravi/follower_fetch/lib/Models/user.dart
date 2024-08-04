class UserInfo{
  final String name;
  final String avatar_url;

  const UserInfo(
      {
        required this.name,
        required this.avatar_url
      }
      );

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(name: json['login'],avatar_url: json['avatar_url'],);
  }

  Map<String, dynamic> toJson(){
    return{"login": name, "avatar_url" : avatar_url };
  }
}
