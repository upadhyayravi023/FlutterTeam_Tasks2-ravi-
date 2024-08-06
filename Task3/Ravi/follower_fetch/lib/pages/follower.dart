import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:follower_fetch/widgits/items.dart';
import 'package:follower_fetch/provider/pro.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});
  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: Consumer<gitProvider>(
            builder: (context, value, child) {
              if (value.userinfo == null) {
                return const CircularProgressIndicator();
              }

              return Column(
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    backgroundImage: NetworkImage(value.userinfo.avatar_url.toString()),
                    radius: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(value.userinfo.name.toString(), style: const TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.w700,),),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 450,
                    child: ListView.builder(
                      itemCount: value.followers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 1.0),
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  FollowerListItem(imageUrl: value.followers[index].avatar_url.toString(), username: value.followers[index].name.toString(),
                          ),

                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
