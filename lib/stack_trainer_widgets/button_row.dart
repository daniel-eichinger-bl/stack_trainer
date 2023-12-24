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
      this.mode, this.chosenPosition, this.card, this.callback, this.positions,
      {super.key});

  Color _getButtonColor(ele, correct, context) {
    if (chosenPosition == ele) {
      return correct ? Colors.green : Colors.red;
    } else {
      return Theme.of(context).colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);

    final buttonsDisabled = chosenPosition != -1 ? true : false;
    var correctChoice = false;
    if (chosenPosition != -1) {
      correctChoice = round.stack.order[card] == chosenPosition;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(positions.length, (idx) {
        final ele = positions[idx];

        final String card = round.stack.order.keys.elementAt(ele - 1);
        final value = card[0] != '1' ? card[0] : card.substring(0, 2);
        final suit = CONST.suitDic[card[card.length - 1]];

        return Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(10),
            width: 150,
            height: 70,
            child: ElevatedButton(
              onPressed: buttonsDisabled ? null : () => callback(ele),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 1,
                  disabledBackgroundColor:
                      _getButtonColor(ele, correctChoice, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    mode == CONST.TrainModes.indexes ? value : '$ele',
                    style: const TextStyle(fontSize: 20),
                  ),
                  mode == CONST.TrainModes.indexes
                      ? Image.asset(
                          'images/poker_cards/$suit.png',
                          width: 20,
                        )
                      : Container(),
                ],
              ),
            ));
      }),
    );
  }
}
