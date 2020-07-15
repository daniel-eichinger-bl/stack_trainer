import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'package:stack_trainer/models/Stack.dart';
import 'package:stack_trainer/models/card_stack_map.dart';
import 'package:stack_trainer/stack_manager_widgets/card_grid_view.dart';
import 'package:stack_trainer/storage_service.dart';
import 'card_picker_keyboard.dart';

class StackInput extends StatefulWidget {
  final String stackName;
  StackInput(this.stackName);

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

  void _saveStack() {
    if (cards.length < 4 || widget.stackName == null) {
      final snackbar = SnackBar(
        content: Text("Error while saving"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
      return;
    }

    Map<String, int> order = {};
    cards.asMap().forEach((key, value) {
      int idx = key + 1;
      order[value] = idx;
    });

    final round = Provider.of<GameRound>(context, listen: false);
    round.addStack(widget.stackName, CardStack(order));
  }

  Future<bool> _onBackPressed() {
    if (_nodeText.hasFocus) {
      notifier.value = '';
      _nodeText.unfocus();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      KeyboardActions(
        isDialog: false,
        config: _buildConfig(context),
        child: WillPopScope(
          onWillPop: () => _onBackPressed(),
          child: KeyboardCustomInput<String>(
            focusNode: _nodeText,
            height: 65,
            notifier: notifier,
            builder: (context, card, hasFocus) {
              if (card.length > 0 && !cards.contains(card)) {
                cards.add(card);
              }
              return CardGridView(cards);
            },
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: RawMaterialButton(
          padding: EdgeInsets.all(20),
          fillColor: Colors.red,
          onPressed: () => _saveStack(),
          shape: CircleBorder(),
          child: Text(
            'Save',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      )
    ]);
  }
}
