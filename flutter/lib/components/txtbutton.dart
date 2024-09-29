import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  String Inputtext;
  void Function()? onTap;
  Textbutton({super.key, required this.Inputtext, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              Inputtext,
              style: TextStyle(color: const Color.fromARGB(255, 38, 38, 38)),
            ),


            
          )),
    );
  }
}
