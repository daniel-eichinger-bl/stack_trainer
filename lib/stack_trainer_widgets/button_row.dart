import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/constants.dart' as CONST;
import 'package:stack_trainer/models/GameRound.dart';

class ButtonRow extends StatelessWidget {
  final List<int> positions;
  final int chosenPosition;
  final String card;
  final void Function(int) callback;
  final mode;

  const ButtonRow(
    this.mode,
    this.chosenPosition,
    this.card,
    this.callback,
    this.positions,
  );

  Color _getButtonColor(ele, correct, context) {
    if (chosenPosition == ele) {
      return correct ? Colors.green : Colors.red;
    } else {
      return Theme.of(context).accentColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);

    final buttonsDisabled = chosenPosition != -1 ? true : false;
    var correctChoice = false;
    if (chosenPosition != -1) {
      correctChoice = round.stackOrder[card] == chosenPosition;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(positions.length, (idx) {
        final ele = positions[idx];

        final String card = round.stackOrder.keys.elementAt(ele - 1);
        final value = card[0] != '1' ? card[0] : card.substring(0, 2);
        final suit = CONST.suitDic[card[card.length-1]];

        return Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(10),
            width: 150,
            height: 70,
            child: RaisedButton(
              onPressed: buttonsDisabled ? null : () => callback(ele),
              disabledElevation: 1,
              disabledTextColor: Colors.black,
              disabledColor: _getButtonColor(ele, correctChoice, context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    mode == CONST.TrainModes.indexes ? '$value' : '$ele',
                    style: TextStyle(fontSize: 20),
                  ),
                  mode == CONST.TrainModes.indexes
                      ? Image.asset(
                          'images/poker_cards/$suit.png',
                          width: 20,
                        )
                      : Container(),
                ],
              ),
              color: Theme.of(context).accentColor,
            ));
      }),
    );
  }
}
