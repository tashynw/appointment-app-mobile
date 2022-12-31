// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:appointment_app_mobile/routes/home.dart';
import 'package:appointment_app_mobile/routes/login.dart';
import 'package:appointment_app_mobile/utils/apiService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //text input controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Name",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Last Name",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Email Address",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!regex.hasMatch(value)){
                            return 'This field must be an email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Password",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordVisible ? false : true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 16,
                              color: Color(0xff8696BB),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
                          //validate password
                          if(!regex.hasMatch(value)){
                            return 'Invalid password. include a minimum of eight characters, at least one letter, number and a special character.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Confirm Password",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: isConfirmPasswordVisible ? false : true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                isConfirmPasswordVisible = !isConfirmPasswordVisible;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 16,
                              color: Color(0xff8696BB),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          else if (value != passwordController.text){
                            return 'The password does not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50,),
                      InkWell(
                        onTap: () async{
                          try{
                            if(_formKey.currentState!.validate()) {
                              await ApiService.createUser(
                                emailController.text.trim(),
                                firstNameController.text.trim(),
                                lastNameController.text.trim(),
                                passwordController.text.trim()
                              );
                              //sign in user
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                              //push to home page
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Account successfully created')),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return HomePage();},));
                            }
                          } catch(e){
                            if(e.toString().contains("The email address is already in use")){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('This email address is already taken.')),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error occured. Try again')),
                            );
                          }
                        },
                        child: Container(
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
                      ),
                    ],
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