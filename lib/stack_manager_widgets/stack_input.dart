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
      _nodeText.unfocus();
      return Future.value(false);
    }
    return Future.value(true);
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
              WillPopScope(
                onWillPop: _onBackPressed,
                child: KeyboardCustomInput<String>(
                  focusNode: _nodeText,
                  height: 65,
                  notifier: notifier,
                  builder: (context, card, hasFocus) {
                    if (card.length > 0) {
                      cards.add(card);
                    }

                    String msg = '';
                    if (cards.length > 0) {
                      msg = cards.join(',');
                    }
                    print(card);
                    return Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        msg,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
