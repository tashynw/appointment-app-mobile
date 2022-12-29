// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MenuOption extends StatefulWidget {
  final String menuTitle;
  const MenuOption({super.key, required this.menuTitle});

  @override
  State<MenuOption> createState() => _MenuOptionState();
}

class _MenuOptionState extends State<MenuOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(99, 180, 255, 0.1),
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),
      child: Center(child: Text(
        widget.menuTitle,
        style: Theme.of(context).textTheme.headline4
      )),
    );
  }
}