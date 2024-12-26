import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class CardPickerKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  @override
  final ValueNotifier<String> notifier;
  static const double _kKeyboardHeight = 250;

  CardPickerKeyboard({super.key, required this.notifier});

  void notifyCard(card) {
    notifier.value = '';
    updateValue(card);
  }

  Widget _buildFlatButton(card) {
    String value = card[0] != '1' ? card[0] : card.substring(0, 2);
    String suit = CONST.suitDic[card[card.length - 1]]!;

    return TextButton(
        onPressed: () => notifyCard(card),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 18),
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
      color: const Color.fromRGBO(48, 48, 48, 1.0),
      child: GridView.count(
          childAspectRatio: 1.3,
          padding: const EdgeInsets.all(8),
          crossAxisCount: 5,
          children: List.generate(CONST.newDeck.length, (i) {
            final card = CONST.newDeck[i];

            if (card.isNotEmpty) {
              return _buildFlatButton(card);
            } else {
              return const Text('');
            }
          }).toList()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_kKeyboardHeight);
}
