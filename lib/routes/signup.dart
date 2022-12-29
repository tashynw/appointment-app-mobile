// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appointment_app_mobile/routes/home.dart';
import 'package:appointment_app_mobile/routes/login.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Sign Up To WoorkRoom",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Text(
                  "First Name",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
              
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Last Name",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
              
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Email Address",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
              
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Password",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffix: Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Color(0xff8696BB),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Confirm Password",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffix: Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Color(0xff8696BB),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xff4894FE),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return LoginPage();},));
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4894FE),
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
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