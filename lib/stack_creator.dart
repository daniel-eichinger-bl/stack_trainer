import 'package:flutter/material.dart';
import 'package:stack_trainer/stack_manager_widgets/stack_creator_appbar.dart';
import 'stack_manager_widgets/stack_input.dart';

class StackCreator extends StatelessWidget {
  static const routeName = '/stack_manager';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: StackCreatorAppBar(
        height: 80,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              onSubmitted: (value) => print(value),
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
          Expanded(child: StackInput())
        ],
      ),
    );
  }
}
