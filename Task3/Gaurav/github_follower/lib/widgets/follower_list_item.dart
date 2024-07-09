import 'package:flutter/material.dart';
import '../providers/follower_provider.dart';
import 'package:provider/provider.dart';
import '../models/follower.dart';
import '../res/app_theme.dart';
import '../screens/followers_screen.dart';


class FollowerListItem extends StatelessWidget {
  final List<FollowersModel> followersList;
  FollowersModel userData;
  FollowerListItem(this.followersList, this.userData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: AppTheme.falcon300.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(userData.avatar_url),
                    fit: BoxFit.cover,
                    height: 185,
                    width: 185,
                  ),
                )),
            const SizedBox(
              height: 24,
            ),
            Text(
              userData.login,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.group),
                Text(
                  followersList.length.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: followersList.length,
                    itemBuilder: (context, index) {
                      return FollowerCard(
                        followerList: followersList[index],
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class FollowerCard extends StatelessWidget {
  final FollowersModel followerList;

  const FollowerCard({super.key, required this.followerList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              color: AppTheme.falcon300,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.falcon400,
                  backgroundImage: NetworkImage(followerList.avatar_url),
                  radius: MediaQuery.of(context).size.height * 0.045,
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  followerList.login,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(
                  flex: 5,
                ),
                Consumer<FollowerProvider>(
                  builder: (context, fprovider, child) {
                    return TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowersScreen(
                                      username: followerList.login)));
                          fprovider.fetchFollowers(followerList.login);
                          fprovider.fetchUser(followerList.login);
                        },
                        child: const Text("Followers",
                            style: TextStyle(color: Colors.blue)));
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
