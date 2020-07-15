import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class CardPickerKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;
  static const double _kKeyboardHeight = 250;

  CardPickerKeyboard({Key key, this.notifier}) : super(key: key);

  void notifyCard(card) {
    notifier.value = '';
    updateValue(card);
  }

  Widget _buildFlatButton(card) {
    String value = card[0] != '1' ? card[0] : card.substring(0, 2);
    String suit = CONST.suitDic[card[card.length - 1]];

    return FlatButton(
        onPressed: () => this.notifyCard(card),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Image.asset(
              'images/poker_cards/$suit.png',
              width: 14,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(48, 48, 48, 1.0),
      child: GridView.count(
          childAspectRatio: 1.3,
          padding: EdgeInsets.all(8),
          crossAxisCount: 5,
          children: List.generate(CONST.newDeck.length, (i) {
            final card = CONST.newDeck[i];

            if (card.length > 0) {
              return _buildFlatButton(card);
            } else {
              return Container(child: Text(''));
            }
          }).toList()),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kKeyboardHeight);
}
