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
      body: Container(
        alignment: Alignment.center,
        child: Consumer<FollowerProvider>(builder: (context, value, child) {
          if (value.userinfo!=null) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(value.getuserinfo()['avatar_url']),
                  radius: 60,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(value.getuserinfo()['login'], style: TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.w700),),
SizedBox(height:30),
                SizedBox(
                  height: 450,
                  child: ListView.builder(
                      itemCount: value
                          .getfollower()
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              ListTile(

                                title: Text(value.getfollower()[index]['login']),
                                leading: CircleAvatar(backgroundImage: NetworkImage(
                                        value.getfollower()[index]['avatar_url']),
                                  radius: 30,),
                                trailing: GestureDetector(
                                  onTap: () async {
                                    final prefs = await SharedPreferences
                                        .getInstance();
                                    final username = value
                                        .getfollower()[index]['login'];
                                    prefs.setString("username", username);
                                    value.importFollowers();

                                  },
                                  child: Text("Followers",
                                    style: TextStyle(color: Colors.blue,fontSize: 15),),
                                ),
                              ),
                              Divider(color: Colors.grey,thickness: 1,)
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          }
          return Text("Loading");
        }
        ),
      ),
    );
  }

}