
import 'package:flutter/material.dart';


Widget buttonPrimary(BuildContext context, String text, VoidCallback action) {
  return Container(
    width: 300,
    height: 60,
    child: ElevatedButton(
      onPressed: () async {
        action();
      },
      style: ElevatedButton.styleFrom(       
        backgroundColor:Colors.blueAccent ,       
        shape: const  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      child: Text(
        text,
        style:const  TextStyle(
          fontSize: 20.0,          
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );
}

Widget buttonSecondary(BuildContext context, String text, VoidCallback action) {
  return Container(
    width: 300,
    height: 60,
    child: ElevatedButton(
      onPressed: () async {
        action();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:Colors.blueAccent ,     
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20.0),
      ),
    ),
  );
}