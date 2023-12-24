import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';

class StackDropdownButton extends StatelessWidget {
  const StackDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameRound>(builder: (context, round, child) {
      return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
            value: round.stackName,
            isExpanded: true,
            style: const TextStyle(color: Colors.white),
            icon: const Icon(Icons.arrow_downward, color: Colors.white),
            dropdownColor: Colors.black,
            items: round.map.stacks.keys
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                          child: Text(
                        e,
                        style: const TextStyle(color: Colors.white),
                      )),
                    ))
                .toList(),
            onChanged: (String? e) => round.setStack(e!, round.map.stacks[e]!)),
      );
    });
  }
}
