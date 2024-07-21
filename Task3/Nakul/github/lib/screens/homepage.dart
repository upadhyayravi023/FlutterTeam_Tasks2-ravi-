import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController username=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: 
    Container(
      height: double.infinity,
      width: double.infinity,
            color: Colors.black,
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(17),
                 child: Column(
                  
                 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 180,),
                    Text("Github",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight:FontWeight.w600),),
                     SizedBox(height: 137,),
                     
                   
                    Container(
                      height: 90,
                      
                      //if you want to set the size of textfromfield put it in container set container height and 
                      //turn expands true and maxlines null
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        
                        expands: true,
                        maxLines: null,
                        
                        controller: username,
                        
                        cursorColor: Colors.red,
                        
                        style: TextStyle(color: Colors.white,fontSize: 18),
                        decoration: InputDecoration(
                          
                           fillColor: const Color.fromARGB(255, 42, 42, 42),
                           filled: true,
                         
                          hintText: "Github username",
                          hintStyle: TextStyle(color: Colors.grey),
                           focusedBorder: OutlineInputBorder(
                          
                            
                      borderRadius: BorderRadius.circular(10),
                      
                      
                                    ),
                                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                                     
                                    ),
                        ),
                        
                      ),
                    ),
                    SizedBox(height: 20,),
                   GestureDetector(
                    onTap: () {
                      
                    },
                    child:  Container(
                      height: 65,
                      width:  700,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                        
                        
               
                      ),
                      alignment:Alignment.center,
                      child: Text("Get Your Followers Now",style: TextStyle(color: Colors.white,fontSize: 16),),
                    
                    ),
                   )
                    
                  ],
                         ),
               ),
             ),
           ),
         
      
    );
  }
}