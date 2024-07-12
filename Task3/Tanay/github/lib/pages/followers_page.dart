import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                        final String username = value.followers[index].username.toString();
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(username),
                                  leading: CircleAvatar(backgroundImage: NetworkImage(
                                          value.followers[index].imageUrl.toString()),
                                    radius: 30,),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      final prefs = await SharedPreferences
                                          .getInstance();
                                      prefs.setString("username", username);
                                      value.getData();
                                    },
                                    child: const Text("Followers",
                                      style: TextStyle(color: Colors.blue,fontSize: 15),),
                                  ),
                                ),
                                const Divider(color: Colors.grey,thickness: 1,)
                              ],
                            ),
                          );
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