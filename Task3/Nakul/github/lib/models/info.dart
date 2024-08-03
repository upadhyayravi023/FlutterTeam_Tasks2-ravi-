class Info {
  final String? userName;
  final String? avatarUrl;
 

  Info(
      {
        required this.userName,
        required this.avatarUrl,
      });

 factory Info.fromJson(Map<String, dynamic> json) => Info(userName: json['login'], avatarUrl:json['avatar_url'] );

  Map<String, dynamic> toJson() {
    return {
      'avatar_url':avatarUrl,
      'login':userName
    };
  }
}
