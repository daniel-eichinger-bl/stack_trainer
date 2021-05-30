import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/storage_service.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'package:stack_trainer/stack_creator.dart';
import 'package:stack_trainer/stack_trainer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.getInstance();
  runApp(StackApp());
}

class StackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameRound>(
      create: (context) => GameRound(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stack Trainer',
        theme: ThemeData(
            primaryColor: Color.fromRGBO(0, 4, 7, 1.0),
            accentColor: Colors.white,
            backgroundColor: Color.fromRGBO(0, 4, 7, 1.0),
            textTheme: GoogleFonts.robotoCondensedTextTheme(
                Theme.of(context).textTheme),
            appBarTheme: AppBarTheme(
                brightness: Brightness.dark,
                textTheme: GoogleFonts.robotoCondensedTextTheme(
                    Theme.of(context).appBarTheme.textTheme))),
        initialRoute: StackTrainer.routeName,
        routes: {
          StackTrainer.routeName: (context) => StackTrainer(),
          StackCreator.routeName: (context) => StackCreator()
        },
      ),
    );
  }
}
