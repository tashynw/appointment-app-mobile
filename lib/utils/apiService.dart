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

  static Future<Map<String, dynamic>> getUserFromEmail(String email) async {
    final users = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    return users.docs[0].data();
  }

  static Future<Map<String, dynamic>> getUser(String userId) async {
    final user = await FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: userId).get();
    return user.docs[0].data();
  }

  static Future<Map<String, dynamic>> getAppointment(String appointmentId) async {
    final appointment = await FirebaseFirestore.instance.collection('appointments').where('appointmentId', isEqualTo: appointmentId).get();
    return appointment.docs[0].data();
  }

  static Future<Map<String, dynamic>> getCurrentUser() async{
    final session = FirebaseAuth.instance.currentUser;
    final users = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: session?.email).get();
    return users.docs[0].data();
  }

  static Future<bool> loginUser(String email, String password) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e){
      return false;
    }
  }

  static Future<bool> addAppointment(String doctorId, String appointmentDate, String appointmentTime, String description) async{
    try{
      final user = await getCurrentUser();
      CollectionReference appointments = FirebaseFirestore.instance.collection('appointments');
      final uuid = Uuid();
      final String appointmentId = uuid.v1();

      await appointments.add({
        'appointmentId': appointmentId,
        'doctorId': doctorId,
        'patientId': user['userId'],
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,
        'description': description,
        'appointmentStatus': "Pending",
      });
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getDoctors() async{
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    final doctorsSnapshot = await FirebaseFirestore.instance.collection('users').where('role', isEqualTo: "Doctor").get();
    final doctorsArray = doctorsSnapshot.docs.map((data)=> data.data()).toList();
    return doctorsArray;
  }

  static Future<List<Map<String, dynamic>>> getAcceptedAppointments() async{
    final user = await getCurrentUser();
    final appointmentsSnapshot = await FirebaseFirestore.instance.collection('appointments').where('patientId', isEqualTo: user['userId']).where('appointmentStatus', isEqualTo: "Accepted").get();
    final appointmentsArray = appointmentsSnapshot.docs.map((appointment) => appointment.data()).toList();
    return appointmentsArray;    
  }

  static Future<List<Map<String, dynamic>>> getAcceptedAppointmentsForDoctor() async{
    final user = await getCurrentUser();
    final appointmentsSnapshot = await FirebaseFirestore.instance.collection('appointments').where('doctorId', isEqualTo: user['userId']).where('appointmentStatus', isEqualTo: "Accepted").get();
    final appointmentsArray = appointmentsSnapshot.docs.map((appointment) => appointment.data()).toList();
    return appointmentsArray;    
  }

  static Future<List<Map<String, dynamic>>> getPendingAppointmentsForDoctor() async{
    final user = await getCurrentUser();
    final appointmentsSnapshot = await FirebaseFirestore.instance.collection('appointments').where('doctorId', isEqualTo: user['userId']).where('appointmentStatus', isEqualTo: "Pending").get();
    final appointmentsArray = appointmentsSnapshot.docs.map((appointment) => appointment.data()).toList();
    return appointmentsArray;    
  }

  static Future<List<Map<String, dynamic>>> getRejectedAppointmentsForDoctor() async{
    final user = await getCurrentUser();
    final appointmentsSnapshot = await FirebaseFirestore.instance.collection('appointments').where('doctorId', isEqualTo: user['userId']).where('appointmentStatus', isEqualTo: "Rejected").get();
    final appointmentsArray = appointmentsSnapshot.docs.map((appointment) => appointment.data()).toList();
    return appointmentsArray;    
  }

  static Future<bool> updateAppointment(String appointmentId, String appointmentStatus) async{
    try{
      CollectionReference appointments = FirebaseFirestore.instance.collection('appointments');
      
      final appointment = await appointments.where('appointmentId', isEqualTo: appointmentId).get();
      final String documentId = appointment.docs[0].id;
      
      await appointments.doc(documentId).update({'appointmentStatus': appointmentStatus});
      return true;
    } catch(e) {
      return false;
    }
  }
  
}