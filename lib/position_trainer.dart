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
  String _randomCard = '';
  var _positions = [];
  int _chosenPosition = -1;
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
      _randomCard = CONST.stack.keys.elementAt(randomPositions[0] - 1);
      randomPositions.shuffle();
      _positions = randomPositions;
    });
  }

  Future<void> btnPress(position) async {
    setState(() {
      _chosenPosition = position;
    });

    final correct = CONST.stack[_randomCard] == _chosenPosition;
    if (correct) {
      Timer(new Duration(milliseconds: 250), handleTimeout);
    } else {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              MistakeDialog(position: CONST.stack[_randomCard]));
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
      setupRandom();
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(height: 80, scaffoldKey: scaffoldKey),
        drawer: CustomDrawer(sliderOnChange),
        body: Column(
          children: <Widget>[
            CardDisplay(randomCard: _randomCard),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonRow(_chosenPosition, _randomCard, btnPress,
                    _positions.sublist(0, 2)),
                ButtonRow(_chosenPosition, _randomCard, btnPress,
                    _positions.sublist(2, 4)),
              ],
            )
          ],
        ));
  }
}
