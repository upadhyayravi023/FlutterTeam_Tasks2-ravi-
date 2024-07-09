import 'package:flutter/material.dart';
import '../providers/follower_provider.dart';
import '../res/app_theme.dart';
import '../screens/followers_screen.dart';
import 'package:provider/provider.dart';

import '../services/github_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController userCtrl = TextEditingController();
  final GetApiData apiData = GetApiData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Followers"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Github", style: Theme.of(context).textTheme.displayLarge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: TextFormField(
                controller: userCtrl,
                enabled: true,
                decoration: InputDecoration(
                  hintText: "Github ID",
                  hintStyle: const TextStyle(color: AppTheme.falcon400),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppTheme.falcon300, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppTheme.falcon900, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer<FollowerProvider>(
              builder: (context, fprovider, child) {
                return InkWell(
                  onTap: () {
                    if(userCtrl.text.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowersScreen(
                                username: userCtrl.text.toString())));
                    fprovider.fetchFollowers(userCtrl.text.toString());
                    fprovider.fetchUser(userCtrl.text.toString());
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: AppTheme.falcon700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "Get Followers",
                      style: TextStyle(
                          color: AppTheme.falcon200,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
