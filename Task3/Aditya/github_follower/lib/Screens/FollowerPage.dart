import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_follower/Providers/follower_provider.dart';
import 'package:github_follower/Widgets/follower_list_item.dart';
import 'package:provider/provider.dart';

class FollowerPage extends StatefulWidget {
  const FollowerPage({super.key});

  @override
  State<FollowerPage> createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<followerProvider>(builder:
              (BuildContext context, followerProvider value, Widget? child) {
            if (value.userInfoData.username.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(value.userInfoData.profileUrl),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    value.userinfo.username.toString(),
                    style: const TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.followersInfo.length,
                        itemBuilder: (context, index) {
                          return FollowerListItem(username: value.followersInfo[index].username, profileUrl: value.followersInfo[index].profileUrl);
                        }),
                  ),
                ],
              );
            } else {
              return Text("Loading");
            }
          }),
        ),
      ),
    );
  }
}
