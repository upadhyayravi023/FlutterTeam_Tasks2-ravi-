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
        title: const Text("Followers"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(22),
          child: Consumer<gitProvider>(
            builder: (context, value, child) {
              if (value.userinfo.name != null) {
                return Column(
                  children: [
                    const SizedBox(height: 32),
                    ClipOval(
                      child: Image.network(value.userinfo.avatar_url.toString(), width: 120, height: 120, fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value.userinfo.name.toString(),
                      style: const TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.w700,),),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 450,
                      child: ListView.builder(
                        itemCount: value.followers.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  value.followers[index].avatar_url.toString(),
                                ),
                              ),
                              title: Text(
                                value.followers[index].name.toString(),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
