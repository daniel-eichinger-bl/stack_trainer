import 'package:flutter/material.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class ButtonRow extends StatelessWidget {
  final List<int> positions;
  final int chosenPosition;
  final String card;
  final void Function(int) callback;

  const ButtonRow(
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
    final buttonsDisabled = chosenPosition != -1 ? true : false;
    var correctChoice = false;
    if (chosenPosition != -1) {
      correctChoice = CONST.stack[card] == chosenPosition;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(positions.length, (idx) {
        final ele = positions[idx];

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
              child: Text(
                '$ele',
                style: TextStyle(fontSize: 20),
              ),
              color: Theme.of(context).accentColor,
            ));
      }),
    );
  }
}
