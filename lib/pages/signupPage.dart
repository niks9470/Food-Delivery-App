import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwiggy/pages/homePage.dart';
import 'package:zwiggy/pages/loginPage.dart';
import 'package:zwiggy/service/database.dart';
import 'package:zwiggy/service/shared_preference.dart';
import 'package:zwiggy/widget/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = "", password = "", name = "";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  final _formkey=GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:

              Text("Registered Sucessfully",style: TextStyle(fontSize: 20,
       color:  Colors.green),)));
        
        String Id=randomAlphaNumeric(10);

        Map<String,dynamic> addUserInfo={
          "Name":nameController.text,
          "Email":emailController.text,
          "wallet":"0",
          "Id" :Id,
        };

        await DatabaseMethods().addUserDetails(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserEmail(emailController.text);
        await SharedPreferenceHelper().saveUserWallet("0");
        await SharedPreferenceHelper().saveUserId(Id);


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));
      } on FirebaseException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
              Text("password provided is too weak! ",
            style: TextStyle(fontSize: 18),
          )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
              Text("Account Already Exists ",
            style: TextStyle(color: Colors.green,fontSize: 18),
          )));
        }
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
                margin: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.7,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Sign Up",
                                style: AppWidget.headlineTextFieldStyle(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: nameController,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "please Enter E-mail";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "User Name",
                                  hintStyle: AppWidget.semiboldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: emailController,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "please enter the email";
                                  }return null;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: AppWidget.semiboldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: passwordController,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "please enter the password";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: AppWidget.semiboldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              GestureDetector  (
                                onTap: ()async{
                                  if( _formkey.currentState!.validate()){
                                    setState(() {
                                      name=nameController.text;
                                      email=emailController.text;
                                      password=passwordController.text;

                                    });
                                  }
                                  registration();
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffff5722),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 20),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()));
                        },
                        child: Text(
                          "Already have an account?Log in",
                          style: AppWidget.semiboldTextFieldStyle(),
                        ))
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
