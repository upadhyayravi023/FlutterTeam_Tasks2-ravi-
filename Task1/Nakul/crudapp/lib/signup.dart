import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/homepage.dart';
import 'package:crudapp/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  
   String? errorMessage ='';

   final formkey=GlobalKey<FormState>();
  final TextEditingController _controllerEmail =TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();
    void dispose() {
   _controllerEmail.dispose();
   _controllerPassword.dispose();
    super.dispose();
  }

 Future<void> createUserWithEmailAndPassword() async{
   try{
     final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text);
          final user = userCredential.user!;
           final userData = {
    
        'email': user.email,
      };
       await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userData);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage()));
   }on FirebaseAuthException catch(e){
    setState((){
      errorMessage =e.message;
    });
   }
  }

 
   
  @override
  Widget build(BuildContext context) {
    final _width=MediaQuery.of(context).size.width;
    final _height=MediaQuery.of(context).size.height;
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.blue,
              
        title: Center(
          child: Container(
            child: Text("SignUp",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
           
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView   (
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Welcome Students!",style: TextStyle(color: Colors.green,fontSize: 27,fontWeight: FontWeight.w600),),
                SizedBox(height: 50,),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _controllerEmail,
                        cursorColor: Colors.blue,
                        style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          prefixIcon: Icon(Icons.email,color: Colors.blue,),
                           focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                      color: Colors.blue,
                                    )
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                      color: Colors.grey,
                                    )
                                  ),
                          
                        ),
                      ),
                      SizedBox(height: 20,),

                 TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  cursorColor: Colors.blue,
                  style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: "Password",
                    
                    
                    prefixIcon: Icon(Icons.lock,color: Colors.red,),
                     focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.blue,
              )
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.grey,
              )
            ),
                    
                  ),
                ),
                    ],
                  ),
                ),
                
                SizedBox(height: 30,),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(onPressed: (){
                   if (formkey.currentState!.validate())  {
                     createUserWithEmailAndPassword();
                    }
                },
                 child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 20 ,),
            
                 
                 ),
                 
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                          
                        ),),
              ),
              SizedBox(height: 36,),
              Row(
                children: [
                  SizedBox(width: 67,),
                  Text("Already Have an Account?  ",style: TextStyle(fontSize: 15),),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                      
                    },
                    child: Text("Login",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize: 15),),
                  )
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}