import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'card_picker_keyboard.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class StackInput extends StatefulWidget {
  @override
  _StackInputState createState() => _StackInputState();
}

class _StackInputState extends State<StackInput> {
  final FocusNode _nodeText = FocusNode();
  final notifier = ValueNotifier<String>('');

  var cards = [];

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.red,
      nextFocus: false,
      actions: [
        KeyboardAction(
          focusNode: _nodeText,
          displayArrows: false,
          toolbarButtons: [
            (node) {
              return IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  notifier.value = '';
                  node.unfocus();
                },
              );
            },
            (node) {
              return IconButton(
                icon: Icon(
                  Icons.backspace,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (cards.length > 0) {
                    setState(() {
                      notifier.value = '';
                      cards.removeLast();
                    });
                  }
                },
              );
            },
          ],
          footerBuilder: (_) => CardPickerKeyboard(
            notifier: notifier,
          ),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() {
    if (_nodeText.hasFocus) {
      notifier.value = '';
      _nodeText.unfocus();
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _buildCardDisplay(card) {
    String value = card[0] != '1' ? card[0] : card.substring(0, 2);
    String suit = CONST.suitDic[card[card.length - 1]];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          border: Border.all(
            width: 2,
            color: Colors.white,
          )),
      margin: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Image.asset(
            'images/poker_cards/$suit.png',
            width: 13,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      isDialog: false,
      config: _buildConfig(context),
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: KeyboardCustomInput<String>(
          focusNode: _nodeText,
          height: 65,
          notifier: notifier,
          builder: (context, card, hasFocus) {
            if (card.length > 0) {
              cards.add(card);
            }

            return GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 16),
              childAspectRatio: 1.5,
              crossAxisCount: 4,
              children: List.generate(52, (index) {
                String card = '';
                if (cards.length > index) {
                  card = cards[index];
                }
                index += 1;
                return Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$index',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w100)),
                    if (card.length > 0) ...[_buildCardDisplay(card)]
                  ],
                ));
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
