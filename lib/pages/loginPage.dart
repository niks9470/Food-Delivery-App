import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zwiggy/pages/bottomNav.dart';
import 'package:zwiggy/pages/forgotpassword.dart';
import 'package:zwiggy/pages/signupPage.dart';
import 'package:zwiggy/widget/widget_support.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  String email="",password="";

  final _formkey=GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  userLogin()async{
    try{
      await FirebaseAuth.instance.
       signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNav()));
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that email",style: TextStyle(color: Colors.black,fontSize: 20),)));
    }else if(
      e.code=="wrong-password"
      ){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Password Provided by user",style: TextStyle(color: Colors.black,fontSize: 20),)));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffff5c30), Color(0xffe74b1a)])),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Text(""),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50,right: 20,left: 20),
                child:
                Column(
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo.png",
                          width: MediaQuery.of(context).size.width/1.5,
                      ),
                    ),SizedBox(height: 60,),
                  SingleChildScrollView(
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/1.7,
                        decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [SizedBox(height: 20,),
                              Text("Login",style: AppWidget.headlineTextFieldStyle(),
                              ),SizedBox(height: 20,),
                              TextFormField(
                                controller: emailController,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "please enter the E-mail";
                                  }return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle:AppWidget.semiboldTextFieldStyle()
                                    ,prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(height: 35,),
                              TextFormField(
                                controller: passwordController,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return" Please enter the password";
                                  } return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle:AppWidget.semiboldTextFieldStyle()
                                  ,prefixIcon: Icon(Icons.password_outlined),
                    
                                ),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgotpassword()));
                                    },
                                      child: Text("Forgot password?",style: AppWidget.semiboldTextFieldStyle(),))),
                              SizedBox(height: 60,),
                              GestureDetector(onTap: (){
                                if(_formkey.currentState!.validate()){
                                  setState(() {
                                    email=emailController.text;
                                    password=passwordController.text;
                                  });
                                }
                                userLogin();
                              },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 150,height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffff5722),
                                    ),
                                    child: Center(child: Text("Login",style:TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 20),)),
                                  ),
                                ),
                              ),
                    
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),SizedBox(height: 30,),
                  GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                      },
                      child: Text("Don't have an account?Sign Up",style: AppWidget.semiboldTextFieldStyle(),))

                ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
