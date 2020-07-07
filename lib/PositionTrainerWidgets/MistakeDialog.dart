import 'package:flutter/material.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class MistakeDialog extends StatelessWidget {
  final position;
  const MistakeDialog({Key key, this.position}) : super(key: key);

  int _correctIndex(idx) {
    if (idx <= 0) {
      return CONST.stack.length;
    } else if (idx > CONST.stack.length) {
      return 1;
    } else {
      return idx;
    }
  }

  Widget _getCardImage(p) {
    p = _correctIndex(p);
    final card = CONST.stack.keys.elementAt(p-1);
    return Expanded(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset('images/poker_cards/$card.png'),
            ),
            Text(
              '$p',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _getCardImage(position - 1),
          _getCardImage(position),
          _getCardImage(position + 1),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Ok',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ))
      ],
    );
  }
}
