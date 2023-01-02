// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;
  final String description;

  const AppointmentPage({super.key, required this.doctorName, required this.appointmentDate, required this.appointmentTime, required this.description});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  TextEditingController doctorController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();
    setState(() {
      doctorController.text = widget.doctorName;
      dateController.text = widget.appointmentDate;
      timeController.text = widget.appointmentTime;
      descriptionController.text = widget.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Color.fromRGBO(99, 180, 255, 0.1),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Appointment",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 45,
                ),
                Text(
                  "Doctor",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
                  controller: doctorController,
                  readOnly: true,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Date",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Color(0xff8696BB),
                    ),
                  ),
                  readOnly: true,
                  controller: dateController,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Time",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.timer_outlined,
                      color: Color(0xff8696BB),
                    ),
                  ),
                  readOnly: true,
                  controller: timeController,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextField(
                  readOnly: true,
                  controller: descriptionController,
                  maxLines: 5,
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}