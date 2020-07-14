import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/stack_trainer_widgets/ButtonRow.dart';
import 'package:stack_trainer/stack_trainer_widgets/CustomAppBar.dart';
import 'package:stack_trainer/stack_trainer_widgets/CustomDrawer.dart';
import 'package:stack_trainer/stack_trainer_widgets/IndexDisplay.dart';
import 'package:stack_trainer/stack_trainer_widgets/MistakeDialog.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'dart:async';
import 'constants.dart' as CONST;
import 'stack_trainer_widgets/CardDisplay.dart';

class StackTrainer extends StatelessWidget {
  static const routeName = '/stack_trainer';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> showMistakeDialog(var context, String card, var callback) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) =>
            MistakeDialog(position: CONST.stack[card], callback: callback));
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);

    if (round.showDialog) {
      Future.delayed(Duration.zero,
          () => showMistakeDialog(context, round.card, round.newRound));
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(height: 80, scaffoldKey: scaffoldKey),
        drawer: CustomDrawer(),
        body: Column(
          children: <Widget>[
            round.subMode == CONST.TrainModes.cards
                ? CardDisplay(round.card)
                : IndexDisplay(CONST.stack[round.card]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonRow(round.subMode, round.chosenPosition, round.card,
                    round.setChosenPosition, round.positions.sublist(0, 2)),
                ButtonRow(round.subMode, round.chosenPosition, round.card,
                    round.setChosenPosition, round.positions.sublist(2, 4)),
              ],
            ),
          ],
        ));
  }
}
