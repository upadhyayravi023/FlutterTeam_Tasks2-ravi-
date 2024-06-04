import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../activity/homeScreen.dart';
import '../activity/signupScreen.dart';
import '../utils/utils.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

   final ValueNotifier<bool> _loadingcircle = ValueNotifier<bool>(false);
   final ValueNotifier<bool> _visible = ValueNotifier<bool>(false);

   final _formkey = GlobalKey<FormState>();
   final TextEditingController emailcontroller = TextEditingController();
   final TextEditingController passwordcontroller = TextEditingController();
   final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold),)),
          elevation: 8.0,
          shadowColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                Text("Welcome Students!",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500,color: Colors.green.shade800),),
                const SizedBox(height: 24,),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        enabled: true,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.5
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1.5
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Email";
                          }else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15,),
                      ValueListenableBuilder(valueListenable: _visible, builder: (context, visibility, child){
                        return TextFormField(
                          controller: passwordcontroller,
                          obscureText: !visibility,
                          enabled: true,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: visibility ? IconButton(onPressed: (){ _visible.value = false;},icon: const Icon(Icons.visibility)): IconButton(onPressed: (){ _visible.value = true;},icon: const Icon(Icons.visibility_off)),
                          ),

                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter Password";
                            }else{
                              return null;
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      login(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.079,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: ValueListenableBuilder<bool>(
                      valueListenable: _loadingcircle,
                      builder: (context, loading, child){
                        return loading ?
                            const CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0,)
                            : const Text("Log In",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 25),);
                      },
                    )),
                  ),
                ),
                const SizedBox(height: 10,),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                    child: const Text("Create an Account",style: TextStyle(fontSize: 24,color: Colors.blueAccent,),))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context){
    _loadingcircle.value = true;
    _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordcontroller.text.toString()).then((value) {
      Utils().toastMessage(value.user!.email.toString(),Colors.green.shade400);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      _loadingcircle.value = false;
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), Colors.red.shade400);
      _loadingcircle.value = false;
    });
  }

}
