import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:follower_fetch/provider/pro.dart';
import 'follower.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Github", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold,),),
              const SizedBox(height: 70),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 63, 62, 62),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5),),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 20,),
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Github Username", hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 20), border: InputBorder.none,),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Consumer<gitProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      if (_controller.text.isNotEmpty) {
                        prefs.setString("username", _controller.text);
                        await value.getData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Followers(),
                          ),
                        );
                      }
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5),),
                        ],
                      ),
                      child: Container(
                        width: 357,
                        height: 60,
                        alignment: Alignment.center,
                        child: value.isloading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text("Get Followers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
