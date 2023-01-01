// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:appointment_app_mobile/components/appointmentCard.dart';
import 'package:appointment_app_mobile/components/menuOptions.dart';
import 'package:appointment_app_mobile/routes/book.dart';
import 'package:appointment_app_mobile/routes/login.dart';
import 'package:appointment_app_mobile/utils/apiService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = "";
  List<AppointmentCard> appointments = [];
  @override
  void initState(){
    super.initState();
    fetchFirstName();
    fetchAcceptedAppointments();
  }
  void fetchFirstName() async{
    final session = FirebaseAuth.instance.currentUser;
    final user = await ApiService.getUserFromEmail(session?.email as String);
    setState(() {
      firstName = user['firstName'];
    });
  }
  void fetchAcceptedAppointments() async{
    final acceptedAppointments = await ApiService.getAcceptedAppointments();
    List<AppointmentCard> appointmentList = [];
    var doctor ={};

    for(var appointment in acceptedAppointments){
      List<String> dateArray = appointment['appointmentDate'].split("-");
      DateTime date = DateTime(
        int.parse(dateArray[0]),
        int.parse(dateArray[1]),
        int.parse(dateArray[2]),
      );
      String dateFormatted = DateFormat('EEEE, d MMMM').format(date);
      doctor = await ApiService.getUser(appointment['doctorId']);
      appointmentList.add(
        AppointmentCard(doctorName: "Dr. ${doctor['firstName']} ${doctor['lastName']}", appoinmentDate: dateFormatted, appointmentTime: appointment['appointmentTime'])
      );
    }
    setState(() {
      appointments = appointmentList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) async{
          if(value==1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return BookPage();},));
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
              children: [
                //Hello, Hi James column
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 6,),
                        Text(
                          "Hi $firstName",
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () async{
                        await FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User signed out.')),
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return LoginPage();},));
                      },
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Image(
                          image: AssetImage("images/home-hello.png"),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MenuOption(
                  menuTitle: "Accepted Appointments",
                ),
                SizedBox(
                  height: 24,
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: appointments,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}