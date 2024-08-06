import 'package:flutter/material.dart';
import 'package:follower_fetch/provider/pro.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowerListItem extends StatelessWidget {
  FollowerListItem({required this.imageUrl, required this.username});
  final String imageUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<gitProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Column(
        children: [
          ListTile(
            title: Text(username),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl.toString()),
              radius: 30,
            ),
            trailing: GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("username", username);
                value.getData();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Followers",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
