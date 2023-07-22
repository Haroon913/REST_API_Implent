import 'dart:convert';

import 'package:chapter_10/uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String message='';
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  void login(String email,password)async {
    try{
      Response response =await post(
        Uri.parse('https://reqres.in/api/register'),
        body:{
          'email':email,
          'password':password
        }
      );
      if(response.statusCode==200){
        var data=jsonDecode(response.body.toString());
        print(data);
        message='Account Created ! Click Login';
        setState(() {

        });

      }
      else{
        print('Failed');
      }
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          message = '';
        });
      });


    }
    catch(e){
      print(e.toString());

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Expanded(
            flex:1,
            child: Container(
              child: Text('SignUp API',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),

            ),
          ),

          Expanded(
            flex:4,
            child: Container(

              decoration: BoxDecoration(
      color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(50),
                    topRight:Radius.circular(50))
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.bold),
                        hintText: 'Enter  email',
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.teal[50],
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.teal,width: 3)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.teal,width: 3)
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.bold),
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.password),
                          filled: true,
                          fillColor: Colors.teal[50],
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal,width: 3)
                          ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.teal,width: 3)
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(child: Text(message.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                    SizedBox(height: 40,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(children: [
                        Expanded(
                          flex:1,
                          child: GestureDetector(
                            onTap: (){
                              login(emailController.text.toString(), passwordController.text.toString());},
                            child: Container(
                              height: 50,

                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text('SignUp',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50,),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImage()));
                              },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text('Login',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                      ],),
                    )

                  ],
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
