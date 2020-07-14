import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'card_picker_keyboard.dart';

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
          toolbarButtons: [
            (node) {
              return IconButton(
                icon: Icon(Icons.close, color: Colors.white,),
                onPressed: () {
                  notifier.value = '';
                  node.unfocus();
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

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      isDialog: false,
      config: _buildConfig(context),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              KeyboardCustomInput<String>(
                focusNode: _nodeText,
                height: 65,
                notifier: notifier,
                builder: (context, card, hasFocus) {
                  if (card != '-1' && card.length > 0) {
                    cards.add(card);
                  } else if (card == '-1' && cards.length > 0) {
                    cards.removeLast();
                  }

                  String msg = '';
                  if (cards.length > 0) {
                    msg = cards.join(',');
                  }
                  print(cards);
                  return Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text(
                      msg,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
