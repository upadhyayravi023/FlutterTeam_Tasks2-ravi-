import 'package:flutter/material.dart';
import 'package:github_follower/providers/follower_provider.dart';
import 'package:github_follower/res/app_theme.dart';
import 'package:github_follower/widgets/follower_list_item.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatefulWidget {
  final String username;
   FollowersScreen({super.key, required this.username});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();

}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers List"),
      ),
      body: Consumer<FollowerProvider>(builder: (context, fprovider, child) {
        if(fprovider.fetchingData==false && fprovider.followers.isEmpty==true){
          fprovider.fetchUser(widget.username);
          fprovider.fetchFollowers(widget.username);
        }
        if(fprovider.fetchingData){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppTheme.falcon800,
                  strokeWidth: 2,
                ),
                Text("Followers is Loading...",style: Theme.of(context).textTheme.bodyMedium,)
              ],
            ),
          );
        }else{
          return FollowerListItem(fprovider.followers, fprovider.userData);
        }
      }),
    );
  }
}

