// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AppointmentCard extends StatefulWidget {
  final String doctorName;
  final String appoinmentDate;
  final String appointmentTime;
  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.appoinmentDate,
    required this.appointmentTime
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 216,
      padding: EdgeInsets.only(
        left: 16,
        top: 20,
        right: 16,
        bottom: 20
      ),
      margin: EdgeInsets.only(
        bottom: 16
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            //spreadRadius: 5,
            color: Color.fromRGBO(90, 117, 167, 0.04),
            offset: Offset(2, 12),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey[300],
                  size: 40,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.doctorName,
                style: Theme.of(context).textTheme.headline2
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Color(0xffF5F5F5),
            height: 2,
            thickness: 1.5,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Color(0xff8696BB),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.appoinmentDate,
                    style: Theme.of(context).textTheme.bodyText2
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Color(0xff8696BB),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    widget.appointmentTime,
                    style: Theme.of(context).textTheme.bodyText2
                  )
                ],
              ),

            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 295,
            height: 39,
            decoration: BoxDecoration(
              color: Color.fromRGBO(99, 180, 255, 0.1),
              borderRadius: BorderRadius.all(Radius.circular(100))
            ),
            child: Center(
              child: Text(
                "Detail",
                style: Theme.of(context).textTheme.button
              ),
            ),
          )
        ],
      ),
    );
  }
}