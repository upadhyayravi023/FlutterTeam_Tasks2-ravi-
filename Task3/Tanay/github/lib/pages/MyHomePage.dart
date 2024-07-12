import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/follower_provider.dart';
import 'followers_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final  _controller=TextEditingController();


 @override
 void initState(){
   super.initState();
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
color: Colors.black,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           const Text(
            'Github',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.white
              ),
          ),
            const SizedBox(
              height: 100,
            ),
            Container(
              width: 397,

            padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 20),
                  controller: _controller,
                decoration: InputDecoration(
                  hintText:  "Github Username",
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 20),
                  filled: true,
                  fillColor: Color.fromARGB(255, 63, 62, 62),
                  border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.yellowAccent, width: 10), borderRadius: BorderRadius.circular(10),
                ),
              ),),
            ),
            const SizedBox(
              height: 50,
            ),
            Consumer<FollowerProvider>(
              builder: (context, value, child){
                return GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      if(_controller.text.isNotEmpty){
                        prefs.setString("username",_controller.text);
                        await value.getData();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const followers()));
                    }
                    }, child: Container(
                    width: 357,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: value.isloading ?  const CircularProgressIndicator(color: Colors.white,): Text("Get Followers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),)));
              },
            )

          ],
        ),
      )
    );
  }
}