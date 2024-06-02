import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentsrecord1/services/authfunctions.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.blue,
        title: Center(child: Text(login ? 'Login' : 'SignUp',style:  TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              login
                  ? Container()
                  : TextFormField(
                key: ValueKey('fullname'),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black,width: 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Full Name",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      child: Image(image: AssetImage('assets/images/student.png'),height: 10,width: 10,),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Full Name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    fullname = value!;
                  });
                },
              ),
             SizedBox(height: 10,),
              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black,width: 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Email ID",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      child:Icon(Icons.email,color: Colors.blue,) ,
                      width: 2,
                    ),
                  ),
                ),
                  validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black,width: 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Enter Password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      child:Icon(Icons.lock,color: Colors.red,) ,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.length < 5) {
                    return 'Please Enter Password of min length 5';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          login
                              ? AuthServices.signinUser(email, password, context)
                              : AuthServices.signupUser(
                              email, password, fullname, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(login ? 'Login' : 'Signup',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      login = !login;
                    });
                  },
                  child: Text(login
                      ? "Don't have an account? Signup"
                      : "Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}