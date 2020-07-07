import 'package:flutter/material.dart';

class IndexDisplay extends StatelessWidget {
  final int position;
  IndexDisplay(this.position);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      margin: EdgeInsets.only(top: 32, bottom: 32),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.blueGrey,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(3.0, 2.0))
      ]),
      child: Center(
          child: Text(
        "$position",
        style: TextStyle(
            color: Colors.white, fontSize: 120, fontWeight: FontWeight.bold),
      )),
    );
  }
}
