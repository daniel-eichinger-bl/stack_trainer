import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'package:stack_trainer/storage_service.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class StackDropdownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var json = StorageService.getString('stacks', defValue: '{}');
    Map<String, dynamic> stacks = jsonDecode(json);
    stacks['Mnemonica'] = CONST.stack;

    return Consumer<GameRound>(builder: (context, round, child) {
      return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
            value: round.stackName,
            isExpanded: true,
            style: TextStyle(color: Colors.white),
            icon: Icon(Icons.arrow_downward, color: Colors.white),
            dropdownColor: Colors.black,
            items: stacks.keys
                .map((e) => DropdownMenuItem(
                      child: Container(
                          child: Text(
                        '$e',
                        style: TextStyle(color: Colors.white),
                      )),
                      value: e,
                    ))
                .toList(),
            onChanged: (e) => round.setStack(e, stacks[e])),
      );
    });
  }
}
