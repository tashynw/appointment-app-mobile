// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ApiService {
  const ApiService();

  static Future<void> createUser(String email, String firstName, String lastName, String password ) async {
    //creating firebase Auth record
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    //creating firestore user record
    final uuid = Uuid();
    final String userId = uuid.v1();
    
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': "Patient"
    });
  }

  static Future<void> getUser() async {
    return;
  }

  static Future<void> deleteUser() async {
    return;
  }

  static Future<bool> loginUser(String email, String password) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e){
      return false;
    }
  }
  
}