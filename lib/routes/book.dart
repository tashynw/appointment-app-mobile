// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, depend_on_referenced_packages, avoid_function_literals_in_foreach_calls

import 'package:appointment_app_mobile/routes/home.dart';
import 'package:appointment_app_mobile/utils/apiService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedDoctorId = "";
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> doctorsArray = [];

  @override
  void initState(){
    super.initState();
    getDoctors();
  }

  void getDoctors() async{
    final doctors = await ApiService.getDoctors();
    List<DropdownMenuItem<String>> doctorLabel=[];
    doctors.forEach((doctor)=>{
      doctorLabel.add(DropdownMenuItem(
        value: doctor['userId'],
        child: Text("Dr. ${doctor['firstName']} ${doctor['lastName']}"),
      )) 
    });
    setState(() {
      doctorsArray = doctorLabel;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if(value==0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return HomePage();},));
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
        child: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Book Appointment",
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
                        "Doctor",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      DropdownButtonFormField(
                        items: doctorsArray,
                        onChanged: (value) {
                          setState(() {
                            selectedDoctorId = value.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: Color(0xff8696BB),
                                    ),
                                  ),
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Mandatory field';
                                    }
                                    return null;
                                  },
                                  onTap: () async{
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context, 
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(Duration(days: 14)),
                                    );
                                    if(pickedDate != null ){
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                                      setState(() {
                                        dateController.text = formattedDate;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.timer_outlined,
                                      color: Color(0xff8696BB),
                                    ),
                                  ),
                                  controller: timeController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Mandatory field';
                                    }
                                    return null;
                                  },
                                  onTap: () async{
                                    TimeOfDay? pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay(hour: 8, minute: 0),
                                      context: context,
                                    );
                                    if(pickedTime != null ){
                                      setState(() {
                                        timeController.text = pickedTime.format(context);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: descriptionController,
                      ),
                      SizedBox(height: 50,),
                      InkWell(
                        onTap: () async{
                          if(_formKey.currentState!.validate()) {
                            //add then push to home page
                            final request = await ApiService.addAppointment(selectedDoctorId, dateController.text, timeController.text, descriptionController.text);
                            if(!request){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error booking appointmet.')),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Appointment successfully booked')),
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return HomePage();},));
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
                              "Submit",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}