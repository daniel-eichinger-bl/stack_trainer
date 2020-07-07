import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stack_trainer/PositionTrainerWidgets/ButtonRow.dart';
import 'package:stack_trainer/PositionTrainerWidgets/CustomAppBar.dart';
import 'package:stack_trainer/PositionTrainerWidgets/CustomDrawer.dart';
import 'package:stack_trainer/PositionTrainerWidgets/IndexDisplay.dart';
import 'package:stack_trainer/PositionTrainerWidgets/MistakeDialog.dart';
import 'dart:async';
import 'constants.dart' as CONST;
import 'PositionTrainerWidgets/CardDisplay.dart';

class PositionTrainer extends StatefulWidget {
  static const routeName = '/quiz_trainer';

  @override
  State<StatefulWidget> createState() {
    return _PositionTrainerState();
  }
}

class _PositionTrainerState extends State<PositionTrainer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final random = new Random();
  static final subModes = [CONST.TrainModes.cards, CONST.TrainModes.indexes];

  String card = '';
  int _chosenPosition = -1;
  var _positions = [];
  CONST.TrainModes _mode = CONST.TrainModes.mix;
  CONST.TrainModes _subMode = CONST.TrainModes.cards;

  void sliderOnChange(value) {
    setState(() {
      _mode = value;
    });
  }

  List<int> getRandomPositions() {
    final l = List.generate(52, (i) => i + 1);
    l.shuffle();
    return [l[1], l[2], l[3], l[4]];
  }

  void newRound() {
    final randomPositions = getRandomPositions();

    setState(() {
      card = CONST.stack.keys.elementAt(randomPositions[0] - 1);
      randomPositions.shuffle();
      _positions = randomPositions;

      if (_mode == CONST.TrainModes.mix) {
        _subMode = subModes[random.nextInt(subModes.length)];
      }
    });
  }

  Future<void> btnPress(position) async {
    setState(() {
      _chosenPosition = position;
    });

    final correct = CONST.stack[card] == _chosenPosition;
    if (correct) {
      Timer(new Duration(milliseconds: 250), handleTimeout);
    } else {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => MistakeDialog(position: CONST.stack[card]));
      setState(() {
        _chosenPosition = -1;
      });
    }
  }

  void handleTimeout() {
    setState(() {
      _chosenPosition = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_chosenPosition == -1) {
      newRound();
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(height: 80, scaffoldKey: scaffoldKey),
        drawer: CustomDrawer(_mode, sliderOnChange),
        body: Column(
          children: <Widget>[
            _subMode == CONST.TrainModes.cards
                ? CardDisplay(randomCard: card)
                : IndexDisplay(CONST.stack[card]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonRow(_subMode,_chosenPosition, card, btnPress, _positions.sublist(0, 2)),
                ButtonRow(_subMode,_chosenPosition, card, btnPress, _positions.sublist(2, 4)),
              ],
            )
          ],
        ));
  }
}
