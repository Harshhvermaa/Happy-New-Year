import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Widgett {
  button(Function() function, String text) {
    return Container(
      width: 200,
      height: 60,
      child: ElevatedButton(
          onPressed: function(),
          child: Text(
            "$text",
            style: GoogleFonts.lato(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(12.0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 255, 128, 74)),
          )),
    );
  }
}
