import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final ThemeData theme = ThemeData();

  StackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameRound>(
      create: (context) => GameRound(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stack Trainer',
        theme: theme.copyWith(
            primaryColor: const Color.fromRGBO(0, 4, 7, 1.0),
            colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.white,
              surface: const Color.fromRGBO(0, 4, 7, 1.0),
            ),
            textTheme: GoogleFonts.robotoCondensedTextTheme(
                Theme.of(context).textTheme),
            appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                toolbarTextStyle: GoogleFonts.robotoCondensed(),
                titleTextStyle: GoogleFonts.robotoCondensed())),
        initialRoute: StackTrainer.routeName,
        routes: {
          StackTrainer.routeName: (context) => StackTrainer(),
          StackCreator.routeName: (context) => const StackCreator()
        },
      ),
    );
  }
}
