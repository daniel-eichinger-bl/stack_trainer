import 'package:flutter/material.dart';

class StackDropdownButton extends StatelessWidget {
  final String value = 'Mnemonica';
  final _stackCallback;
  final _stack;

  StackDropdownButton(this._stack, this._stackCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
            value: _stack,
            isExpanded: true,
            style: TextStyle(color: Colors.white),
            icon: Icon(Icons.arrow_downward, color: Colors.white),
            dropdownColor: Colors.black,
            items: ['Mnemonica', 'Aronson']
                .map((e) => DropdownMenuItem(
                      child: Container(
                          child: Text(
                        '$e',
                        style: TextStyle(color: Colors.white),
                      )),
                      value: e,
                    ))
                .toList(),
            onChanged: (e) => _stackCallback(e)),
      ),
    );
  }
}
