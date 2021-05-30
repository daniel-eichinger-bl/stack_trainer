import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/stack_trainer_widgets/button_row.dart';
import 'package:stack_trainer/stack_trainer_widgets/custom_drawer.dart';
import 'package:stack_trainer/stack_trainer_widgets/index_display.dart';
import 'package:stack_trainer/stack_trainer_widgets/mistake_dialog.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'dart:async';
import 'constants.dart' as CONST;
import 'stack_trainer_widgets/card_display.dart';

class StackTrainer extends StatelessWidget {
  static const routeName = '/stack_trainer';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> showMistakeDialog(var context, int p, var c) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => MistakeDialog(position: p, callback: c));
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);

    if (round.showDialog) {
      Future.delayed(
          Duration.zero,
          () => showMistakeDialog(
              context, round.stack.order[round.card], round.newRound));
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Row(
            children: [
              Text('Stack Trainer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  )),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'images/icons/card_icon_red.png',
                    width: 60,
                  )),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.menu, size: 35, color: Colors.red),
            onPressed: () => scaffoldKey.currentState.openDrawer(),
            color: Colors.grey,
          ),
          brightness: Brightness.dark,
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              round.subMode == CONST.TrainModes.cards
                  ? CardDisplay(round.card)
                  : IndexDisplay(round.stack.order[round.card]),
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
          ),
        ));
  }
}
