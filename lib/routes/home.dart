// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appointment_app_mobile/components/appointmentCard.dart';
import 'package:appointment_app_mobile/components/menuOptions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
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
                          "Hi Tashyn",
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: Image(
                        image: AssetImage("images/home-hello.png"),
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
                  children: [
                    AppointmentCard(
                      doctorName: "Dr. Joseph Brostito",
                      appoinmentDate: "Sunday, 12 June",
                      appointmentTime: "11:00 AM",
                    ),
                    AppointmentCard(
                      doctorName: "Dr. Andrew Jackson",
                      appoinmentDate: "Tuesday, 15 June",
                      appointmentTime: "2:00 PM",
                    ),
                    AppointmentCard(
                      doctorName: "Dr. Jeremy Anderson",
                      appoinmentDate: "Thursday, 25 July",
                      appointmentTime: "3:00 PM",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}