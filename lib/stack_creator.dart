import 'package:flutter/material.dart';
import 'package:stack_trainer/StackManagerWidgets/StackAppBar.dart';

class StackCreator extends StatelessWidget {
  static const routeName = '/stack_manager';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: StackAppBar(height: 80,),
      body: Text(
        "Test",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
