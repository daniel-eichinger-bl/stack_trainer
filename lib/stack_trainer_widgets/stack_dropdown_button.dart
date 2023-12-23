import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';

class StackDropdownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameRound>(builder: (context, round, child) {
      return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
            value: round.stackName,
            isExpanded: true,
            style: TextStyle(color: Colors.white),
            icon: Icon(Icons.arrow_downward, color: Colors.white),
            dropdownColor: Colors.black,
            items: round.map.stacks.keys
                .map((e) => DropdownMenuItem(
                      child: Container(
                          child: Text(
                        '$e',
                        style: TextStyle(color: Colors.white),
                      )),
                      value: e,
                    ))
                .toList(),
            onChanged: (String? e) => round.setStack(e!, round.map.stacks[e]!)),
      );
    });
  }
}
