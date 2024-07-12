import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github/widgets/follower_list_item.dart';
import '../provider/follower_provider.dart';

class followers extends StatefulWidget{
  const followers({super.key});
  @override
  State<followers> createState() => _followersState();
}

class _followersState extends State<followers>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Consumer<FollowerProvider>(builder: (context, value, child) {
            if (value.userinfo.username!=null) {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(value.userinfo.imageUrl.toString()),
                    radius: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(value.userinfo.username.toString(), style: const TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.w700),),
        const SizedBox(height:30),
                  SizedBox(
                    height: 450,
                    child: ListView.builder(
                        itemCount: value
                            .followers
                            .length,
                        itemBuilder: (context, index) {
                          return followerListItem(imageUrl: value.followers[index].imageUrl.toString(), username: value.followers[index].username.toString());
                        }),
                  )
                ],
              );
            }
            return const Text("Loading");
          }
          ),
        ),
      ),
    );
  }

}