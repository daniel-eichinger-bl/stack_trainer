import 'package:flutter/material.dart';
import 'package:stack_trainer/StackManagerWidgets/StackAppBar.dart';

class StackCreator extends StatelessWidget {
  static const routeName = '/stack_manager';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: StackAppBar(
        height: 80,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
              autofocus: true,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
