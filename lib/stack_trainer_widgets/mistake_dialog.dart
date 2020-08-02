import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';

class MistakeDialog extends StatelessWidget {
  final position;
  final callback;
  const MistakeDialog({Key key, this.position, this.callback})
      : super(key: key);

  int _correctIndex(idx, length) {
    if (idx <= 0) {
      return length;
    } else if (idx > length) {
      return 1;
    } else {
      return idx;
    }
  }

  Widget _getCardImage(p, stackOrder, [color = Colors.white]) {
    p = _correctIndex(p, stackOrder.length);
    final card = stackOrder.keys.elementAt(p - 1);
    return Expanded(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset('images/poker_cards/$card.png'),
              ),
            ),
            Text(
              '$p',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);

    return AlertDialog(
      backgroundColor: Color.fromRGBO(0, 4, 7, 1.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _getCardImage(position - 1, round.stack.order),
          _getCardImage(position, round.stack.order, Colors.red),
          _getCardImage(position + 1, round.stack.order),
        ],
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              callback();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_forward, color: Colors.red)),
      ],
    );
  }
}
