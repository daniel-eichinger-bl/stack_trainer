import 'package:flutter/material.dart';
import 'package:stack_trainer/position_trainer.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(StackTrainer());

class StackTrainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Trainer',
      theme: ThemeData(
        primaryColor: Colors.purple[800],
        accentColor: Colors.white,
        backgroundColor: Color.fromRGBO(0, 4, 7, 1.0),
        textTheme: GoogleFonts.robotoCondensedTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: PositionTrainer.routeName,
      routes: {PositionTrainer.routeName: (context) => PositionTrainer()},
    );
  }
}
