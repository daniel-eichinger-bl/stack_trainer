import 'package:flutter/material.dart';

class IndexDisplay extends StatelessWidget {
  final position;
  const IndexDisplay(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 306,
      width: 200,
      margin: const EdgeInsets.only(top: 32, bottom: 32),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.blueGrey,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(3.0, 2.0))
      ]),
      child: Center(
          child: Text(
        "$position",
        style: const TextStyle(
            color: Colors.white, fontSize: 120, fontWeight: FontWeight.bold),
      )),
    );
  }
}
