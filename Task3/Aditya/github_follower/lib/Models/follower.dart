class follower{
  final String profileUrl;
  final String username;

  const follower({required this.profileUrl, required this.username});

  factory follower.fromJson(Map<String, dynamic> json){
    return follower(profileUrl: json['avatar_url'], username: json['login']);
  }

  Map<String, dynamic> toJson(){
    return{
      "avatar_url" : profileUrl,
      "login": username,
    };
  }
}