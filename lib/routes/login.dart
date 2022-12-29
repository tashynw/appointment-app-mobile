// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appointment_app_mobile/routes/home.dart';
import 'package:appointment_app_mobile/routes/signup.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if(value==0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return HomePage();},));
          if(value==1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return LoginPage();},));
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_sharp,
              color: Color(0xff8696BB),
            ),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              color: Color(0xff8696BB),
            ),
            label: "Book"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Color(0xff8696BB),
            ),
            label: "Profile"
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: AssetImage('images/home-hello.png'),
                    ),
                  ),
                ),
                SizedBox(height: 80,),
                Center(
                  child: Text(
                    "Log In To Woorkroom",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Text(
                  "Your Email",
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
                SizedBox(height: 60,),
                Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xff4894FE),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child: Center(
                    child: Text(
                      "Log In",
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
                      "New User? ",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return SignUpPage();},));
                      },
                      child: Text(
                        "Create Account",
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