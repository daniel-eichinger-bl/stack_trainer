import 'package:flutter/material.dart';
import 'package:stack_trainer/PositionTrainerWidgets/ButtonRow.dart';
import 'package:stack_trainer/PositionTrainerWidgets/CustomAppBar.dart';
import 'package:stack_trainer/PositionTrainerWidgets/CustomDrawer.dart';
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

  String card = '';
  int _position = -1;
  var _positions = [];
  CONST.TrainModes _mode = CONST.TrainModes.mix;

  void sliderOnChange(value) {
    print(value);
    setState(() {
      _mode = value;
    });
  }

  void setupRandom() {
    final l = List.generate(52, (i) => i + 1);
    l.shuffle();
    final randomPositions = [l[1], l[2], l[3], l[4]];

    setState(() {
      card = CONST.stack.keys.elementAt(randomPositions[0] - 1);
      randomPositions.shuffle();
      _positions = randomPositions;
    });
  }

  Future<void> btnPress(position) async {
    setState(() {
      _position = position;
    });

    final correct = CONST.stack[card] == _position;
    if (correct) {
      Timer(new Duration(milliseconds: 250), handleTimeout);
    } else {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => MistakeDialog(position: CONST.stack[card]));
      setState(() {
        _position = -1;
      });
    }
  }

  void handleTimeout() {
    setState(() {
      _position = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_position == -1) {
      setupRandom();
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(height: 80, scaffoldKey: scaffoldKey),
        drawer: CustomDrawer(_mode, sliderOnChange),
        body: Column(
          children: <Widget>[
            CardDisplay(randomCard: card),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonRow(_position, card, btnPress, _positions.sublist(0, 2)),
                ButtonRow(_position, card, btnPress, _positions.sublist(2, 4)),
              ],
            )
          ],
        ));
  }
}
